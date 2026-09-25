#!/usr/bin/env python3
"""
Generate a NixOS module for programs.niri.settings from niri Rust config source.

Usage:
    python3 generate.py [--fetch] [niri_root] [output_file]

    --fetch     Clone/pull github:soulvice/niri into a temp dir and use that
                (default when the local niri_root does not exist)

Defaults:
    niri_root   ~/codes/nix/niri   (falls back to GitHub clone if absent)
    output_file ./generated-options.nix
"""

import re
import subprocess
import sys
import tempfile
from pathlib import Path
from dataclasses import dataclass
from typing import Optional

# ---------------------------------------------------------------------------
# Defaults
# ---------------------------------------------------------------------------

GITHUB_NIRI = "https://github.com/soulvice/niri"
DEFAULT_NIRI_ROOT = Path.home() / "codes/nix/niri"
DEFAULT_OUTPUT = Path(__file__).parent / "generated-options.nix"

# ---------------------------------------------------------------------------
# Root section discovery — parsed dynamically from ConfigPart::decode_children
# ---------------------------------------------------------------------------

def snake_to_pascal(s: str) -> str:
    return ''.join(w.capitalize() for w in s.split('_'))


def _parse_config_fields(lib_rs: str) -> dict[str, str]:
    """Return {field_name: rust_type} for every field in the Config struct."""
    fields: dict[str, str] = {}
    in_struct = False
    depth = 0
    for line in lib_rs.splitlines():
        s = line.strip()
        if re.match(r'pub struct Config\b', s):
            in_struct = True
            depth = 0
        if in_struct:
            depth += s.count('{') - s.count('}')
            if depth < 0:
                break
            m = re.match(r'pub\s+(\w+)\s*:\s*(.+?),?\s*$', s)
            if m:
                fields[m.group(1)] = m.group(2).strip().rstrip(',')
    return fields


def _arm_section(kdl_name: str, arm_text: str,
                 config_fields: dict, structs: dict) -> Optional[tuple]:
    """
    Determine (kdl_name, struct_name, is_list) from a block match arm's full text.
    Returns None for arms we intentionally skip (include, binds, _, etc.).
    """
    is_list = bool(re.search(r'\.push\(', arm_text))

    # Flag::decode_node → bare boolean setting (e.g. prefer-no-csd)
    if re.search(r'\bFlag::decode_node\b', arm_text):
        return (kdl_name, '_bool_flag', False)

    # Look for StructName::decode_node calls (most arms)
    for sname in re.findall(r'(\w+)::decode_node', arm_text):
        if sname in ('knuffel', 'Flag', 'Decode'):
            continue
        if sname in structs:
            return (kdl_name, sname, is_list)
        # Known structs that may not appear in the registry under that exact name
        if re.match(r'^[A-Z]\w+$', sname):
            return (kdl_name, sname, is_list)

    # knuffel::Decode::decode_node — resolve from the assignment field name
    if re.search(r'knuffel.*decode_node|Decode::decode_node', arm_text):
        m = re.search(r'borrow_mut\(\)\.(\w+)\s*=\s*part', arm_text)
        if m:
            field = m.group(1)
            rust_type = config_fields.get(field, '')
            vm = re.match(r'Vec<(\w+)>', rust_type)
            struct_name = vm.group(1) if vm else rust_type
            if struct_name:
                return (kdl_name, struct_name, bool(vm))

    return None  # skip (include, binds-only logic, _)


def parse_root_sections(lib_rs: str, structs: dict) -> list[tuple[str, str, bool]]:
    """
    Parse ConfigPart::decode_children's match block from lib.rs and return
    [(kdl_name, struct_name, is_list)] for every config section.

    struct_name is '_bool_flag' for bare boolean flags (e.g. prefer-no-csd).
    Sections without a parseable struct (binds, include, _) are omitted.
    """
    config_fields = _parse_config_fields(lib_rs)
    lines = lib_rs.splitlines()

    # Locate `match name {`
    match_idx = next((i for i, l in enumerate(lines) if re.search(r'\bmatch name\b', l)), None)
    if match_idx is None:
        return []

    sections: list[tuple[str, str, bool]] = []
    i = match_idx + 1
    match_depth = 1  # we are inside the `match name {`

    while i < len(lines) and match_depth > 0:
        line = lines[i].strip()
        arm_m = re.match(r'"([^"]+)"\s*=>', line)

        if arm_m:
            kdl_name = arm_m.group(1)
            rest = line[arm_m.end():].strip()

            # ---- m_merge!(field_name) — single-line merge arm ----
            mm = re.match(r'm_merge!\((\w+)\)', rest)
            if mm:
                field = mm.group(1)
                # Look up the field's actual type from Config, not just the name
                rust_type = config_fields.get(field, snake_to_pascal(field))
                # Try <RustType>Part first, then <RustType> directly
                sname = f'{rust_type}Part' if f'{rust_type}Part' in structs else rust_type
                sections.append((kdl_name, sname, False))
                match_depth += line.count('{') - line.count('}')
                i += 1
                continue

            # ---- m_push!(field_name) — single-line push arm ----
            mp = re.match(r'm_push!\((\w+)\)', rest)
            if mp:
                field = mp.group(1)
                rust_type = config_fields.get(field, '')
                vm = re.match(r'Vec<(\w+)>', rust_type)
                sname = vm.group(1) if vm else snake_to_pascal(field)
                sections.append((kdl_name, sname, True))
                match_depth += line.count('{') - line.count('}')
                i += 1
                continue

            # ---- block arm "name" => { ... } ----
            arm_depth = line.count('{') - line.count('}')
            arm_lines = [line]
            j = i + 1
            while j < len(lines) and arm_depth > 0:
                al = lines[j].strip()
                arm_depth += al.count('{') - al.count('}')
                arm_lines.append(al)
                j += 1
            arm_text = ' '.join(arm_lines)

            section = _arm_section(kdl_name, arm_text, config_fields, structs)
            if section:
                sections.append(section)

            # Net depth change of a self-contained block arm is 0; i advances past it.
            match_depth += sum(l.count('{') - l.count('}') for l in arm_lines)
            i = j
            continue

        # Non-arm line (comment, _, closing })
        match_depth += line.count('{') - line.count('}')
        i += 1

    return sections

# ---------------------------------------------------------------------------
# Data
# ---------------------------------------------------------------------------

@dataclass
class RustField:
    name: str
    rust_type: str
    knuffel: str           # annotation body, e.g. "child, unwrap(argument)"
    default: Optional[str] = None  # raw default literal from annotation
    doc: str = ""          # /// doc comment text
    apply: Optional[str] = None    # Nix apply expression, e.g. "v: if v == true then null else v"

@dataclass
class RustStruct:
    name: str
    fields: list  # list[RustField]

@dataclass
class RustEnum:
    name: str
    variants: list  # list[str] — CamelCase variant names
    default: Optional[str] = None

# ---------------------------------------------------------------------------
# Parser
# ---------------------------------------------------------------------------

def parse_all(niri_root: Path) -> tuple[dict, dict]:
    structs: dict[str, RustStruct] = {}
    enums:   dict[str, RustEnum]   = {}

    scan_dirs = [
        niri_root / "niri-config" / "src",
        niri_root / "niri-ipc" / "src",
    ]
    for d in scan_dirs:
        if d.exists():
            for path in sorted(d.rglob("*.rs")):
                _parse_file(path.read_text(), structs, enums)

    return structs, enums


def _parse_file(text: str, structs: dict, enums: dict):
    lines = text.splitlines()
    i = 0

    while i < len(lines):
        # Collect consecutive attribute lines before a definition.
        attrs: list[str] = []
        while i < len(lines) and lines[i].strip().startswith('#['):
            attr = lines[i].strip()
            # Merge continuation lines for multi-line attributes.
            while i + 1 < len(lines) and attr.count('[') > attr.count(']'):
                i += 1
                attr += ' ' + lines[i].strip()
            attrs.append(attr)
            i += 1

        if i >= len(lines):
            break

        line = lines[i].strip()

        # ---- struct ----
        m = re.match(r'(?:pub\s+)?struct\s+(\w+)', line)
        if m:
            name = m.group(1)
            is_knuffel_decode = any(
                'knuffel::Decode' in a and 'DecodeScalar' not in a
                for a in attrs
            )
            if is_knuffel_decode:
                # Pass i (the struct def line) — the opening '{' may be on that line.
                fields, i = _struct_body(lines, i)
                structs[name] = RustStruct(name=name, fields=fields)
                continue
            i += 1
            continue

        # ---- enum ----
        m = re.match(r'(?:pub\s+)?enum\s+(\w+)', line)
        if m:
            name = m.group(1)
            # Pass i (the enum def line) — the opening '{' may be on that line.
            variants, default_v, i = _enum_body(lines, i)
            if variants:
                enums[name] = RustEnum(name=name, variants=variants, default=default_v)
            continue

        i += 1


def _struct_body(lines: list, start: int) -> tuple[list, int]:
    """Parse a struct body; return (fields, next_line_index)."""
    i = start
    # Tuple struct: '(' appears before any '{' — skip to end of definition.
    if '(' in lines[i] and '{' not in lines[i]:
        while i < len(lines) and ');' not in lines[i]:
            i += 1
        return [], i + 1
    while i < len(lines) and '{' not in lines[i]:
        i += 1
    i += 1  # skip the '{' line

    fields: list[RustField] = []
    pending_knuffel: Optional[str] = None
    pending_default: Optional[str] = None
    pending_doc: list[str] = []
    depth = 1

    while i < len(lines):
        line = lines[i].strip()
        depth += line.count('{') - line.count('}')
        if depth <= 0:
            return fields, i + 1

        # Doc comment — accumulate before knuffel annotation
        if line.startswith('///'):
            pending_doc.append(line[3:].strip())
            i += 1
            continue

        # Knuffel annotation
        km = re.match(r'#\[knuffel\((.+)\)\]', line)
        if km:
            annot = km.group(1)
            # Extract default = <value>
            dm = re.search(r',\s*default\s*=\s*([^,\)]+)', annot)
            # Bare "default" (no value) → Rust Default::default()
            has_bare = bool(re.search(r',\s*default\s*[,\)]', annot))
            pending_default = dm.group(1).strip() if dm else (None if not has_bare else "__default")
            pending_knuffel = annot
            i += 1
            continue

        # Other attributes — skip and reset doc accumulator
        if line.startswith('#['):
            pending_doc = []
            i += 1
            continue

        # Field line: `pub field_name: FieldType,`
        SKIP_KEYWORDS = {
            'pub', 'use', 'type', 'const', 'fn', 'impl', 'where',
            'let', 'for', 'if', 'else', 'return', 'match', 'struct',
        }
        fm = re.match(r'(?:pub\s+)?(\w+)\s*:\s*(.+?)(?:\s*,)?\s*$', line)
        if fm and pending_knuffel is not None:
            fname = fm.group(1)
            ftype = fm.group(2).strip().rstrip(',')
            if fname not in SKIP_KEYWORDS:
                fields.append(RustField(
                    name=fname,
                    rust_type=ftype,
                    knuffel=pending_knuffel,
                    default=pending_default,
                    doc=' '.join(pending_doc),
                ))
            pending_knuffel = None
            pending_default = None
            pending_doc = []
        elif line and not line.startswith('//') and not line.startswith('#'):
            # Any real code line resets the pending annotation
            pending_knuffel = None
            pending_default = None
            pending_doc = []

        i += 1

    return fields, i


def _enum_body(lines: list, start: int) -> tuple[list, Optional[str], int]:
    """Parse an enum body; return (variants, default_variant, next_line_index)."""
    i = start
    while i < len(lines) and '{' not in lines[i]:
        i += 1
    i += 1  # skip '{'

    variants: list[str] = []
    default_v: Optional[str] = None
    pending_default = False
    depth = 1

    while i < len(lines):
        line = lines[i].strip()
        depth += line.count('{') - line.count('}')
        if depth <= 0:
            return variants, default_v, i + 1

        if line == '#[default]':
            pending_default = True
            i += 1
            continue

        # Skip other attributes and comments
        if line.startswith('#') or line.startswith('//') or not line:
            i += 1
            continue

        # Variant: `VariantName,`  or  `VariantName(#[attr] type, …),`
        # Use a loose match — [^)]* breaks on nested parens like `(#[knuffel(argument)] f64)`.
        SKIP = {'pub', 'use', 'impl', 'fn', 'let', 'match', 'where', 'mod', 'extern', 'crate'}
        vm = re.match(r'^(_?\w+)', line)
        if vm:
            vname = vm.group(1)
            if vname not in SKIP and (vname[0].isupper() or vname.startswith('_')):
                variants.append(vname)
                if pending_default:
                    default_v = vname
                pending_default = False

        i += 1

    return variants, default_v, i

# ---------------------------------------------------------------------------
# Type resolution helpers
# ---------------------------------------------------------------------------

INT_TYPES   = {'u8','u16','u32','u64','usize','i8','i16','i32','i64','isize'}
FLOAT_TYPES = {'f32','f64'}
PRIMITIVE: dict[str, str] = {
    'bool':         'lib.types.bool',
    'Flag':         'lib.types.bool',
    'String':       'lib.types.str',
    'Color':        'lib.types.str',   # users pass hex strings like "#rrggbbaa"
    'Percent':      'lib.types.float',
    'MaxBpc':       'lib.types.int',
    'ScrollFactor': 'lib.types.float',
    # Complex types without knuffel::Decode — resolved manually
    'WorkspaceReference':      '(lib.types.either lib.types.int lib.types.str)',  # 1 or "name"
    'WorkspaceReferenceArg':   '(lib.types.either lib.types.int lib.types.str)',
    'CornerRadius': (
        '(lib.types.either lib.types.float (lib.types.submodule {\n'
        '            options = {\n'
        '              top-left     = lib.mkOption { type = lib.types.float; default = 0.0; };\n'
        '              top-right    = lib.mkOption { type = lib.types.float; default = 0.0; };\n'
        '              bottom-right = lib.mkOption { type = lib.types.float; default = 0.0; };\n'
        '              bottom-left  = lib.mkOption { type = lib.types.float; default = 0.0; };\n'
        '            };\n'
        '          }))'
    ),
    'GradientInterpolation':   'lib.types.str',     # CSS-like "srgb", "oklch shorter", etc.
    'RegexEq':                 'lib.types.str',
    # PresetSize / DefaultPresetSize: injected as RustStructs in _inject_animation_structs
    'MruBinds':                '(lib.types.attrsOf lib.types.anything)',
    # niri_ipc::Layer — not knuffel::DecodeScalar, so parser misses it
    'Layer':    '(lib.types.enum [ "background" "bottom" "top" "overlay" ])',
    # Simple newtype wrappers and special string types
    'PathBuf':             'lib.types.str',
    'WorkspaceName':       'lib.types.str',
    'Mode':                'lib.types.str',    # e.g. "1920x1080@60"
    'Modeline':            'lib.types.str',    # xrandr modeline
    # Output transform — niri uses "normal", "90", "180", "270", "flipped", ...
    'Transform': (
        '(lib.types.enum [ "normal" "90" "180" "270" '
        '"flipped" "flipped-90" "flipped-180" "flipped-270" ])'
    ),
}


# Types that are transparent wrappers — resolve them as their inner type.
TYPE_ALIASES: dict[str, str] = {
    'WorkspaceLayoutPart': 'LayoutPart',
}

# Root-level tuple structs whose Nix representation can't be derived from fields alone.
# Maps struct_name -> (nix_type_expr, nix_default_literal)
TUPLE_STRUCT_ROOT: dict[str, tuple[str, str]] = {
    # screenshot-path "~/path"  →  a single optional string argument
    'ScreenshotPath': (
        '(lib.types.nullOr lib.types.str)',
        '"~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png"',
    ),
    # environment { VAR "val"; }  →  attrset of var→optional string
    'Environment': ('lib.types.attrsOf (lib.types.nullOr lib.types.str)', '{}'),
}


def camel_to_kebab(s: str) -> str:
    # Strip leading underscores (e.g. _90 -> 90 for Transform variants)
    s = s.lstrip('_')
    # Insert hyphen between lowercase/digit and uppercase letter
    s = re.sub(r'([A-Z]+)([A-Z][a-z])', r'\1-\2', s)
    s = re.sub(r'([a-z])([A-Z])', r'\1-\2', s)
    # Insert hyphen between letter and digit run (e.g. Flipped90 -> flipped-90)
    s = re.sub(r'([a-zA-Z])(\d)', r'\1-\2', s)
    return s.lower()


def snake_to_kebab(s: str) -> str:
    return s.replace('_', '-')


def rust_type_to_nix(rt: str, structs: dict, enums: dict, depth: int = 0) -> str:
    """Map a Rust type string to a Nix type expression."""
    t = rt.strip()
    # Resolve transparent aliases first
    t = TYPE_ALIASES.get(t, t)

    # Option<T>
    m = re.match(r'^Option<(.+)>$', t)
    if m:
        inner = rust_type_to_nix(m.group(1), structs, enums, depth)
        return f'(lib.types.nullOr {inner})'

    # Vec<T>
    m = re.match(r'^Vec<(.+)>$', t)
    if m:
        inner = rust_type_to_nix(m.group(1), structs, enums, depth)
        return f'(lib.types.listOf {inner})'

    # FloatOrInt<min, max>
    if t.startswith('FloatOrInt<'):
        return 'lib.types.float'

    if t in PRIMITIVE:
        return PRIMITIVE[t]
    if t in INT_TYPES:
        return 'lib.types.int'
    if t in FLOAT_TYPES:
        return 'lib.types.float'

    # Known struct → submodule (checked before enums so injected structs win)
    if t in structs:
        return _struct_to_submodule(structs[t], structs, enums, depth)

    # Known enum → enum type with all variant values
    if t in enums:
        e = enums[t]
        vs = ' '.join(f'"{camel_to_kebab(v)}"' for v in e.variants)
        return f'(lib.types.enum [ {vs} ])'

    if t == '__NiriAction':
        return 'lib.types.anything'

    if t == '__EasingCurve':
        return 'lib.types.anything'

    if t == '__HotkeyOverlay':
        return (
            '(lib.types.nullOr (lib.types.submodule {\n'
            '            options = {\n'
            '              title  = lib.mkOption { type = lib.types.nullOr lib.types.str; default = null; };\n'
            '              hidden = lib.mkOption { type = lib.types.bool; default = false; };\n'
            '            };\n'
            '          }))'
        )

    # Strip Rust module path prefix (e.g. niri_ipc::Layer → Layer) and retry.
    if '::' in t:
        short = t.split('::')[-1]
        short = TYPE_ALIASES.get(short, short)
        if short in PRIMITIVE:
            return PRIMITIVE[short]
        if short in INT_TYPES:
            return 'lib.types.int'
        if short in FLOAT_TYPES:
            return 'lib.types.float'
        if short in structs:
            return _struct_to_submodule(structs[short], structs, enums, depth)
        if short in enums:
            e = enums[short]
            vs = ' '.join(f'"{camel_to_kebab(v)}"' for v in e.variants)
            return f'(lib.types.enum [ {vs} ])'

    return 'lib.types.anything'


def _struct_to_submodule(s: RustStruct, structs: dict, enums: dict, depth: int) -> str:
    """Render a struct as a `lib.types.submodule { options = { ... }; }` expression.

    depth is the indentation level of the field that owns this type.
    The submodule appears inline after `type = `, so its internals need
    to be indented 2 extra levels to sit visually inside the type value.
    """
    opts = _gen_options(s.fields, structs, enums, depth + 3)
    if not opts.strip():
        return 'lib.types.attrsOf lib.types.anything'
    pad_close = '  ' * (depth + 1)  # closing `})`
    pad_opts  = '  ' * (depth + 2)  # `options = {` and `};`
    return (
        f'(lib.types.submodule {{\n'
        f'{pad_opts}options = {{\n'
        f'{opts}'
        f'{pad_opts}}};\n'
        f'{pad_close}}})'
    )

# ---------------------------------------------------------------------------
# Nix option generation
# ---------------------------------------------------------------------------

def _field_nix_type(f: RustField, structs: dict, enums: dict, depth: int) -> str:
    """Compute the Nix type for a single struct field."""
    # Plain bool / Flag without unwrap → presence flag
    if f.rust_type in ('bool', 'Flag') and 'unwrap' not in f.knuffel:
        return 'lib.types.bool'
    return rust_type_to_nix(f.rust_type, structs, enums, depth)


def _field_default(f: RustField) -> Optional[str]:
    """Compute a Nix literal for the field's default, or None (→ force null in caller)."""
    # Explicit value from annotation
    if f.default is not None and f.default != "__default":
        d = f.default.strip()
        if d in ('true', 'false'):
            return d
        if re.match(r'^-?[\d.]+(?:\.[.\d]*)?$', d):
            return d
        return None  # complex struct constructor — caller forces null

    # Option<T> → null
    if f.rust_type.startswith('Option<'):
        return 'null'

    # bool / Flag → false
    if f.rust_type in ('bool', 'Flag') and 'unwrap' not in f.knuffel:
        return 'false'

    # Vec<T> → []
    if f.rust_type.startswith('Vec<'):
        return '[]'

    # Bare Rust Default::default() — emit known primitives; rest → caller forces null
    if f.default == "__default":
        rt = f.rust_type.strip()
        if rt in INT_TYPES:
            return '0'
        if rt in FLOAT_TYPES:
            return '0.0'
        return None  # String / complex type → caller forces null

    return None  # no annotation default → caller forces null


def _gen_options(fields: list, structs: dict, enums: dict, depth: int) -> str:
    """Render a list of RustFields as Nix mkOption stanzas."""
    lines: list[str] = []
    pad = '  ' * depth

    # Detect on/off flag fields and collapse them into a single `enable` option.
    field_names = {f.name for f in fields}
    has_on  = 'on'  in field_names
    has_off = 'off' in field_names

    if has_on or has_off:
        if has_on and has_off:
            # Both flags: true → emit on;  false → emit off;  null → nothing
            apply_fn = 'v: if v == null then null else { __kdl_flag = if v then "on" else "off"; }'
        elif has_on:
            # on-only: true → emit on;  false/null → nothing
            apply_fn = 'v: if v == true then { __kdl_flag = "on"; } else null'
        else:
            # off-only: false → emit off;  true/null → nothing
            apply_fn = 'v: if v == false then { __kdl_flag = "off"; } else null'

        lines.append(f'{pad}enable = lib.mkOption {{')
        lines.append(f'{pad}  type = (lib.types.nullOr lib.types.bool);')
        lines.append(f'{pad}  default = null;')
        lines.append(f'{pad}  apply = {apply_fn};')
        lines.append(f'{pad}}};')

    for f in fields:
        # Skip on/off — replaced by enable above.
        if f.name in ('on', 'off') and (has_on or has_off):
            continue

        nix_name = snake_to_kebab(f.name)
        nix_type = _field_nix_type(f, structs, enums, depth)
        nix_def  = _field_default(f)

        # Every option must have a default so partial submodule configs evaluate.
        # Fields with no natural default become `nullOr T` defaulting to null;
        # the KDL serialiser already skips null values.
        if nix_def is None:
            nix_def = 'null'
            # Check only the outermost type — searching the whole string finds
            # `nullOr` inside nested submodule definitions and falsely skips the wrap.
            if not nix_type.startswith('(lib.types.nullOr') \
                    and not nix_type.startswith('lib.types.nullOr'):
                nix_type = f'(lib.types.nullOr {nix_type})'

        lines.append(f'{pad}{nix_name} = lib.mkOption {{')
        lines.append(f'{pad}  type = {nix_type};')
        lines.append(f'{pad}  default = {nix_def};')
        if f.apply:
            lines.append(f'{pad}  apply = {f.apply};')
        lines.append(f'{pad}}};')

    return '\n'.join(lines) + ('\n' if lines else '')

# ---------------------------------------------------------------------------
# Root-level module generation
# ---------------------------------------------------------------------------

def _gen_root_sections(root_sections: list, structs: dict, enums: dict) -> str:
    sections: list[str] = []
    pad = '    '  # 4 spaces — inside options.programs.niri.settings = {

    for kdl_name, struct_name, is_list in root_sections:

        # Special case: bare boolean flag
        if struct_name == '_bool_flag':
            sections.append(
                f'{pad}{kdl_name} = lib.mkOption {{\n'
                f'{pad}  type = lib.types.bool;\n'
                f'{pad}  default = false;\n'
                f'{pad}}};'
            )
            continue

        if struct_name not in structs:
            # binds: use injected Bind struct (attrsOf keyed by key-combo string)
            if kdl_name == 'binds' and 'Bind' in structs:
                bind_s = structs['Bind']
                bind_opts = _gen_options(bind_s.fields, structs, enums, depth=5)
                sections.append(
                    f'{pad}{kdl_name} = lib.mkOption {{\n'
                    f'{pad}  type = lib.types.attrsOf (lib.types.submodule {{\n'
                    f'{pad}    options = {{\n'
                    f'{bind_opts}'
                    f'{pad}    }};\n'
                    f'{pad}  }});\n'
                    f'{pad}  default = {{}};\n'
                    f'{pad}}};'
                )
            else:
                sections.append(
                    f'{pad}# {kdl_name}: skipped (struct {struct_name!r} not found in source)'
                )
            continue

        s = structs[struct_name]

        if is_list:
            inner = _struct_to_submodule(s, structs, enums, depth=3)
            sections.append(
                f'{pad}{kdl_name} = lib.mkOption {{\n'
                f'{pad}  type = lib.types.listOf {inner};\n'
                f'{pad}  default = [];\n'
                f'{pad}}};'
            )
        else:
            # Non-list section: render fields inline as an attrset of options.
            opts = _gen_options(s.fields, structs, enums, depth=3)
            if opts.strip():
                sections.append(f'{pad}{kdl_name} = {{\n{opts}{pad}}};')
            elif struct_name in TUPLE_STRUCT_ROOT:
                nix_type, nix_def = TUPLE_STRUCT_ROOT[struct_name]
                sections.append(
                    f'{pad}{kdl_name} = lib.mkOption {{\n'
                    f'{pad}  type = {nix_type};\n'
                    f'{pad}  default = {nix_def};\n'
                    f'{pad}}};'
                )
            else:
                sections.append(f'{pad}# {kdl_name}: no parseable options')

    return '\n\n'.join(sections)

# ---------------------------------------------------------------------------
# Doc generation
# ---------------------------------------------------------------------------

def _human_type(rt: str, structs: dict, enums: dict) -> tuple[str, str]:
    """Return (type_label, values_note) for a Rust type.
    values_note lists allowed values for enums/bools; empty string otherwise.
    """
    t = rt.strip()
    t = TYPE_ALIASES.get(t, t)

    m = re.match(r'^Option<(.+)>$', t)
    if m:
        label, vals = _human_type(m.group(1), structs, enums)
        return f'`null` or {label}', vals

    m = re.match(r'^Vec<(.+)>$', t)
    if m:
        label, _ = _human_type(m.group(1), structs, enums)
        return f'list of {label}', ''

    if t.startswith('FloatOrInt<'):
        return '`float`', ''

    if t in ('bool', 'Flag'):
        return '`bool`', '`true`, `false`'
    if t in FLOAT_TYPES or t in ('Percent', 'ScrollFactor', 'CornerRadius'):
        return '`float`', ''
    if t in INT_TYPES or t == 'MaxBpc':
        return '`int`', ''
    if t in ('String', 'Color', 'PathBuf', 'WorkspaceName', 'Mode',
             'Modeline', 'GradientInterpolation', 'RegexEq'):
        return '`string`', ''
    if t == 'Transform':
        vals = ('`"normal"`, `"90"`, `"180"`, `"270"`, '
                '`"flipped"`, `"flipped-90"`, `"flipped-180"`, `"flipped-270"`')
        return '`string`', vals
    if t == 'PresetSize':
        return '`any`', 'proportion (`{ proportion = 0.5; }`) or fixed (`{ fixed = 960; }`)'
    if t in ('MruBinds',):
        return '`attrs`', ''

    if t in enums:
        e = enums[t]
        vals = ', '.join(f'`"{camel_to_kebab(v)}"`' for v in e.variants)
        if e.default:
            vals += f' *(default: `"{camel_to_kebab(e.default)}"`)* '
        return '`string`', vals

    if t in structs:
        return '`submodule`', ''

    return '`any`', ''


def _esc_html(s: str) -> str:
    return s.replace('&', '&amp;').replace('<', '&lt;').replace('>', '&gt;').replace('"', '&quot;')


def _gen_html_docs(sections: list, structs: dict, enums: dict) -> str:
    """Generate interactive HTML documentation for all programs.niri.settings.* options."""
    base = 'programs.niri.settings'

    # ── gather per-section data ──────────────────────────────────────────────
    section_data = []
    total_opts = 0

    for kdl_name, struct_name, is_list in sections:
        section_path = f'{base}.{kdl_name}'
        rows = []

        if struct_name == '_bool_flag':
            rows = [{'path': section_path, 'type': '`bool`', 'values': '', 'default': 'false', 'doc': ''}]
        elif kdl_name == 'binds' or struct_name == 'Binds':
            rows = [{'path': f'{section_path}.<key>', 'type': '`attrsOf submodule`', 'values': '',
                     'default': '{}',
                     'doc': 'Key is a key combination (e.g. "Mod+Return"). '
                            'Set one action field per bind. Metadata: allow-when-locked, allow-inhibiting, cooldown-ms, repeat, hotkey-overlay.'}]
        elif struct_name in TUPLE_STRUCT_ROOT:
            nix_type, nix_def = TUPLE_STRUCT_ROOT[struct_name]
            human = nix_type.replace('lib.types.', '').replace('(', '').replace(')', '').strip()
            rows = [{'path': section_path, 'type': f'`{human}`', 'values': '', 'default': nix_def, 'doc': ''}]
        elif struct_name in structs:
            path_tpl = f'{section_path}.<n>' if is_list else section_path
            rows = _doc_fields_flat(struct_name, path_tpl, structs, enums)

        total_opts += len(rows)
        section_data.append((kdl_name, rows))

    # ── HTML template ────────────────────────────────────────────────────────
    sections_html = ''
    for kdl_name, rows in section_data:
        rows_html = ''
        for r in rows:
            path_short = r['path'].replace(base + '.', '')
            type_html  = _esc_html(r['type'].strip('`'))
            vals_html  = _esc_html(r['values']) if r['values'] else '—'
            def_html   = _esc_html(str(r['default'])) if r['default'] is not None else '—'
            doc_html   = _esc_html(r['doc']) if r.get('doc') else ''
            rows_html += (
                f'<tr data-path="{_esc_html(r["path"])}">'
                f'<td><code>{_esc_html(path_short)}</code>'
                f'{"<br><span class=doc>" + doc_html + "</span>" if doc_html else ""}</td>'
                f'<td><span class="badge">{type_html}</span></td>'
                f'<td><code>{def_html}</code></td>'
                f'<td class="vals">{vals_html}</td>'
                f'</tr>\n'
            )
        sections_html += (
            f'<details class="section" id="{_esc_html(kdl_name)}">\n'
            f'<summary>'
            f'<span class="sec-name">{_esc_html(kdl_name)}</span>'
            f'<span class="sec-count">{len(rows)}</span>'
            f'</summary>\n'
            f'<table>\n'
            f'<thead><tr><th>Option</th><th>Type</th><th>Default</th><th>Allowed values</th></tr></thead>\n'
            f'<tbody>\n{rows_html}</tbody>\n</table>\n'
            f'</details>\n'
        )

    return f'''<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
<title>niri Options</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&family=JetBrains+Mono:wght@400;500&display=swap');

:root {{
  --bg:       #f8f8f8;
  --bg2:      #ffffff;
  --bg3:      #f0f0f2;
  --border:   #e0e0e6;
  --text:     #1a1a2e;
  --text2:    #555566;
  --accent:   #5b6af0;
  --accent2:  #e8eaff;
  --mono:     'JetBrains Mono', 'Fira Mono', monospace;
  --sans:     'Inter', system-ui, sans-serif;
  --radius:   6px;
}}
@media (prefers-color-scheme: dark) {{
  :root:not([data-theme="light"]) {{
    --bg:     #13131a;
    --bg2:    #1c1c26;
    --bg3:    #24242f;
    --border: #2e2e3e;
    --text:   #e8e8f2;
    --text2:  #9090aa;
    --accent: #7c89f8;
    --accent2:#1e2040;
  }}
}}
:root[data-theme="dark"] {{
  --bg:     #13131a;
  --bg2:    #1c1c26;
  --bg3:    #24242f;
  --border: #2e2e3e;
  --text:   #e8e8f2;
  --text2:  #9090aa;
  --accent: #7c89f8;
  --accent2:#1e2040;
}}

*, *::before, *::after {{ box-sizing: border-box; margin: 0; padding: 0; }}
html {{ font-size: 15px; }}
body {{
  font-family: var(--sans);
  background: var(--bg);
  color: var(--text);
  padding-inline: max(16px, 5vw);
  padding-block: 32px env(safe-area-inset-bottom, 0px);
  line-height: 1.5;
}}

header {{
  margin-bottom: 28px;
}}
header h1 {{
  font-size: 1.7rem;
  font-weight: 600;
  letter-spacing: -0.02em;
  color: var(--text);
}}
header p {{
  color: var(--text2);
  font-size: 0.9rem;
  margin-top: 4px;
}}
.stats {{
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
  margin-top: 14px;
}}
.stat {{
  background: var(--bg2);
  border: 1px solid var(--border);
  border-radius: var(--radius);
  padding: 8px 14px;
  font-size: 0.82rem;
  color: var(--text2);
}}
.stat strong {{ color: var(--text); font-variant-numeric: tabular-nums; }}

.controls {{
  display: flex;
  gap: 10px;
  margin-bottom: 20px;
  flex-wrap: wrap;
  align-items: center;
}}
#search {{
  flex: 1;
  min-width: 200px;
  padding: 8px 12px;
  border: 1px solid var(--border);
  border-radius: var(--radius);
  background: var(--bg2);
  color: var(--text);
  font-family: var(--sans);
  font-size: 0.9rem;
  outline: none;
}}
#search:focus {{ border-color: var(--accent); }}
.btn {{
  padding: 8px 14px;
  border: 1px solid var(--border);
  border-radius: var(--radius);
  background: var(--bg2);
  color: var(--text2);
  cursor: pointer;
  font-size: 0.82rem;
  font-family: var(--sans);
  white-space: nowrap;
}}
.btn:hover {{ border-color: var(--accent); color: var(--accent); }}

.section {{
  background: var(--bg2);
  border: 1px solid var(--border);
  border-radius: var(--radius);
  margin-bottom: 10px;
  overflow: hidden;
}}
.section[hidden] {{ display: none; }}
summary {{
  display: flex;
  align-items: center;
  gap: 10px;
  padding: 12px 16px;
  cursor: pointer;
  list-style: none;
  user-select: none;
}}
summary::-webkit-details-marker {{ display: none; }}
summary::before {{
  content: '›';
  font-size: 1.1rem;
  color: var(--text2);
  transition: transform 0.15s;
  min-width: 14px;
  text-align: center;
}}
details[open] > summary::before {{ transform: rotate(90deg); }}
.sec-name {{
  font-family: var(--mono);
  font-size: 0.9rem;
  font-weight: 500;
  color: var(--accent);
}}
.sec-count {{
  margin-left: auto;
  background: var(--bg3);
  border: 1px solid var(--border);
  border-radius: 20px;
  padding: 1px 10px;
  font-size: 0.75rem;
  color: var(--text2);
}}

table {{
  width: 100%;
  border-collapse: collapse;
  font-size: 0.83rem;
}}
thead {{ background: var(--bg3); }}
th {{
  text-align: left;
  padding: 8px 14px;
  font-weight: 600;
  font-size: 0.77rem;
  text-transform: uppercase;
  letter-spacing: 0.06em;
  color: var(--text2);
  border-bottom: 1px solid var(--border);
}}
td {{
  padding: 7px 14px;
  border-bottom: 1px solid var(--border);
  vertical-align: top;
  color: var(--text);
}}
tr:last-child td {{ border-bottom: none; }}
tr[hidden] {{ display: none; }}
tr:hover td {{ background: var(--bg3); }}
td code {{
  font-family: var(--mono);
  font-size: 0.82rem;
  color: var(--text);
  background: var(--bg3);
  padding: 1px 5px;
  border-radius: 3px;
}}
.badge {{
  font-family: var(--mono);
  font-size: 0.78rem;
  background: var(--accent2);
  color: var(--accent);
  padding: 2px 7px;
  border-radius: 20px;
  white-space: nowrap;
}}
.vals {{ color: var(--text2); font-size: 0.8rem; }}
.doc {{ color: var(--text2); font-size: 0.79rem; display: block; margin-top: 3px; }}
.no-results {{
  text-align: center;
  color: var(--text2);
  padding: 40px 0;
  font-size: 0.9rem;
}}
</style>
</head>
<body>
<header>
  <h1>niri Options</h1>
  <p>Auto-generated from niri Rust config source. All <code>programs.niri.settings.*</code> options.</p>
  <div class="stats">
    <div class="stat"><strong>{len(sections)}</strong> sections</div>
    <div class="stat"><strong>{total_opts}</strong> options</div>
    <div class="stat">Regenerate: <strong>nix run .#generate</strong></div>
  </div>
</header>

<div class="controls">
  <input id="search" type="search" placeholder="Search options…" autocomplete="off" spellcheck="false">
  <button class="btn" onclick="expandAll()">Expand all</button>
  <button class="btn" onclick="collapseAll()">Collapse all</button>
</div>

<div id="sections">
{sections_html}
</div>
<p class="no-results" id="no-results" hidden>No options match your search.</p>

<script>
const search = document.getElementById('search');
const noResults = document.getElementById('no-results');
search.addEventListener('input', () => {{
  const q = search.value.toLowerCase().trim();
  let anyVisible = false;
  document.querySelectorAll('.section').forEach(sec => {{
    let secVisible = false;
    sec.querySelectorAll('tr[data-path]').forEach(row => {{
      const match = !q || row.dataset.path.toLowerCase().includes(q)
                       || (row.textContent || '').toLowerCase().includes(q);
      row.hidden = !match;
      if (match) secVisible = true;
    }});
    sec.hidden = !secVisible;
    if (secVisible) {{ anyVisible = true; if (q) sec.open = true; }}
  }});
  noResults.hidden = anyVisible;
}});
function expandAll() {{
  document.querySelectorAll('.section:not([hidden])').forEach(s => s.open = true);
}}
function collapseAll() {{
  document.querySelectorAll('.section').forEach(s => s.open = false);
}}
</script>
</body>
</html>
'''


def _doc_fields_flat(struct_name: str, path: str, structs: dict, enums: dict,
                     depth: int = 0, max_depth: int = 4,
                     _visited: Optional[frozenset] = None) -> list[dict]:
    """Flatten a struct's fields into a list of option-doc dicts, recursing into submodules."""
    if _visited is None:
        _visited = frozenset()
    if struct_name in _visited or depth > max_depth or struct_name not in structs:
        return []
    _visited = _visited | {struct_name}

    rows = []
    for f in structs[struct_name].fields:
        nix_name = snake_to_kebab(f.name)
        full_path = f'{path}.{nix_name}'

        label, vals = _human_type(f.rust_type, structs, enums)
        default = _field_default(f)

        rows.append({
            'path': full_path,
            'type': label,
            'values': vals,
            'default': default,
            'doc': f.doc,
        })

        # Recurse into submodule structs (unwrap Option/Vec)
        inner = f.rust_type
        for pat in (r'^Option<(.+)>$', r'^Vec<(.+)>$'):
            m = re.match(pat, inner)
            if m:
                inner = m.group(1)
        is_list = bool(re.match(r'^Vec<', f.rust_type) or
                       re.match(r'^Option<Vec<', f.rust_type))
        inner = TYPE_ALIASES.get(inner.strip(), inner.strip())

        if inner in structs and depth < max_depth:
            sub_path = f'{full_path}.<item>' if is_list else full_path
            rows.extend(_doc_fields_flat(inner, sub_path, structs, enums,
                                         depth + 1, max_depth, _visited))

    return rows


def _gen_docs(sections: list, structs: dict, enums: dict) -> str:
    """Generate Markdown documentation for all programs.niri.settings.* options."""
    base = 'programs.niri.settings'
    lines: list[str] = [
        '# niri settings options',
        '',
        'Auto-generated from niri Rust config source — do not edit manually.  ',
        'Regenerate: `python3 generate.py`',
        '',
        '## Table of contents',
        '',
    ]
    for kdl_name, _, _ in sections:
        lines.append(f'- [`{base}.{kdl_name}`](#{kdl_name})')
    lines += ['', '---', '']

    for kdl_name, struct_name, is_list in sections:
        section_path = f'{base}.{kdl_name}'
        lines += [f'## `{section_path}`', '']

        if struct_name == '_bool_flag':
            lines += ['**Type:** `bool`  **Default:** `false`', '', '---', '']
            continue

        if kdl_name == 'binds' or struct_name == 'Binds':
            lines += [
                '**Type:** `attrsOf submodule`  **Default:** `{}`',
                '',
                'Each key is a key combination (e.g. `"Mod+Return"`). Set exactly one action field'
                ' per bind; the rest default to `false`/`null`.',
                '',
                '**Action fields** (all `bool` or typed, default `false`/`null`):'
                ' `quit`, `suspend`, `close-window`, `fullscreen-window`, `spawn` (list of str),'
                ' `spawn-sh` (str), `focus-column-left/right`, `focus-workspace` (int or str),'
                ' `set-column-width` (str), `set-window-width/height` (str), `maximize-column`,'
                ' and many more — see the generated options for the full list.',
                '',
                '**Metadata fields:**',
                '',
                '| Option | Type | Default | Description |',
                '|--------|------|---------|-------------|',
                '| `allow-when-locked` | `bool` | `false` | Allow this bind when the screen is locked |',
                '| `allow-inhibiting` | `bool` | `true` | Allow apps to inhibit this keybind |',
                '| `cooldown-ms` | `null or int` | `null` | Minimum ms between triggers |',
                '| `repeat` | `bool` | `true` | Trigger repeatedly when held |',
                '| `hotkey-overlay` | `null or submodule` | `null` | Hotkey overlay display: `{ title = "…"; }` sets a label, `{ hidden = true; }` hides the bind |',
                '',
                '---',
                '',
            ]
            continue

        if struct_name in TUPLE_STRUCT_ROOT:
            nix_type, nix_def = TUPLE_STRUCT_ROOT[struct_name]
            # Strip lib.types. prefix for readability
            human = nix_type.replace('lib.types.', '').replace('(', '').replace(')', '').strip()
            lines += [f'**Type:** `{human}`  **Default:** `{nix_def}`', '', '---', '']
            continue

        if struct_name not in structs:
            lines += [f'*Not documented — struct `{struct_name}` not found in source.*',
                      '', '---', '']
            continue

        if is_list:
            lines += ['**Type:** list of submodules  **Default:** `[]`', '']
            rows = _doc_fields_flat(struct_name, f'{section_path}.<n>', structs, enums)
        else:
            rows = _doc_fields_flat(struct_name, section_path, structs, enums)

        for row in rows:
            lines.append(f'### `{row["path"]}`')
            lines.append('')
            meta = f'**Type:** {row["type"]}'
            if row['default'] is not None:
                meta += f'  **Default:** `{row["default"]}`'
            lines.append(meta)
            if row['values']:
                lines.append(f'**Values:** {row["values"]}')
            if row['doc']:
                lines.append('')
                lines.append(row['doc'])
            lines.append('')

        lines += ['---', '']

    return '\n'.join(lines) + '\n'


# ---------------------------------------------------------------------------
# Animation struct injection
# ---------------------------------------------------------------------------

# Animation types have custom knuffel::Decode impls so the parser misses them.
# We inject synthetic structs that mirror the KDL-level fields.

_ANIM_NO_SHADER = [
    'WorkspaceSwitchAnim', 'HorizontalViewMovementAnim', 'WindowMovementAnim',
    'ConfigNotificationOpenCloseAnim', 'ExitConfirmationOpenCloseAnim',
    'ScreenshotUiOpenAnim', 'OverviewOpenCloseAnim', 'RecentWindowsCloseAnim',
]
_ANIM_WITH_SHADER = ['WindowOpenAnim', 'WindowCloseAnim', 'WindowResizeAnim']


def _inject_animation_structs(structs: dict) -> None:
    # PresetSize: proportion 0.33 | fixed 960  — user sets exactly one field.
    preset_fields = [
        RustField('proportion', 'Option<f64>', 'child, unwrap(argument)', default=None),
        RustField('fixed',      'Option<i32>', 'child, unwrap(argument)', default=None),
    ]
    structs['PresetSize']        = RustStruct('PresetSize',        preset_fields)
    structs['DefaultPresetSize'] = RustStruct('DefaultPresetSize', list(preset_fields))

    structs['EasingParams'] = RustStruct('EasingParams', [
        RustField('duration_ms', 'u32',    'child, unwrap(argument)', default='250'),
        RustField('curve',       '__EasingCurve', 'child, unwrap(argument)', default=None),
    ])
    structs['SpringParams'] = RustStruct('SpringParams', [
        RustField('damping_ratio', 'f64', 'child, unwrap(argument)', default='1.0'),
        RustField('stiffness',     'u32', 'child, unwrap(argument)', default='1000'),
        RustField('epsilon',       'f64', 'child, unwrap(argument)', default='0.0001'),
    ])

    base = [
        RustField('off',    'bool',                 'child', default='false'),
        RustField('easing', 'Option<EasingParams>', 'child', default=None),
        RustField('spring', 'Option<SpringParams>', 'child', default=None),
    ]
    for name in _ANIM_NO_SHADER:
        structs[name] = RustStruct(name, list(base))
    for name in _ANIM_WITH_SHADER:
        structs[name] = RustStruct(name, base + [
            RustField('custom_shader', 'Option<String>', 'child, unwrap(argument)', default=None),
        ])


# ---------------------------------------------------------------------------
# Bind struct injection
# ---------------------------------------------------------------------------

# Non-skip Action variants that take no argument — rendered as bare KDL nodes (bool true/false).
_ACTION_BARE = [
    'Quit', 'Suspend', 'PowerOffMonitors', 'PowerOnMonitors',
    'ToggleDebugTint', 'DebugToggleOpaqueRegions', 'DebugToggleDamage',
    'ToggleKeyboardShortcutsInhibit',
    'CloseWindow', 'FullscreenWindow', 'ToggleWindowedFullscreen',
    'FocusWindowPrevious',
    'FocusColumnLeft', 'FocusColumnRight', 'FocusColumnFirst', 'FocusColumnLast',
    'FocusColumnRightOrFirst', 'FocusColumnLeftOrLast',
    'FocusWindowOrMonitorUp', 'FocusWindowOrMonitorDown',
    'FocusColumnOrMonitorLeft', 'FocusColumnOrMonitorRight',
    'FocusWindowDown', 'FocusWindowUp',
    'FocusWindowDownOrColumnLeft', 'FocusWindowDownOrColumnRight',
    'FocusWindowUpOrColumnLeft', 'FocusWindowUpOrColumnRight',
    'FocusWindowOrWorkspaceDown', 'FocusWindowOrWorkspaceUp',
    'FocusWindowTop', 'FocusWindowBottom', 'FocusWindowDownOrTop', 'FocusWindowUpOrBottom',
    'MoveColumnLeft', 'MoveColumnRight', 'MoveColumnToFirst', 'MoveColumnToLast',
    'MoveColumnLeftOrToMonitorLeft', 'MoveColumnRightOrToMonitorRight',
    'MoveWindowDown', 'MoveWindowUp',
    'MoveWindowDownOrToWorkspaceDown', 'MoveWindowUpOrToWorkspaceUp',
    'MoveColumnToWorkspaceDown', 'MoveColumnToWorkspaceUp',
    'MoveWindowToWorkspaceDown', 'MoveWindowToWorkspaceUp',
    'ConsumeOrExpelWindowLeft', 'ConsumeOrExpelWindowRight',
    'ConsumeWindowIntoColumn', 'ExpelWindowFromColumn',
    'SwapWindowLeft', 'SwapWindowRight',
    'ToggleColumnTabbedDisplay',
    'CenterColumn', 'CenterWindow', 'CenterVisibleColumns',
    'FocusWorkspaceDown', 'FocusWorkspaceUp', 'FocusWorkspacePrevious',
    'MoveWorkspaceDown', 'MoveWorkspaceUp',
    'UnsetWorkspaceName',
    'FocusMonitorLeft', 'FocusMonitorRight', 'FocusMonitorDown', 'FocusMonitorUp',
    'FocusMonitorPrevious', 'FocusMonitorNext',
    'MoveWindowToMonitorLeft', 'MoveWindowToMonitorRight',
    'MoveWindowToMonitorDown', 'MoveWindowToMonitorUp',
    'MoveWindowToMonitorPrevious', 'MoveWindowToMonitorNext',
    'MoveColumnToMonitorLeft', 'MoveColumnToMonitorRight',
    'MoveColumnToMonitorDown', 'MoveColumnToMonitorUp',
    'MoveColumnToMonitorPrevious', 'MoveColumnToMonitorNext',
    'ResetWindowHeight',
    'SwitchPresetColumnWidth', 'SwitchPresetColumnWidthBack',
    'SwitchPresetWindowWidth', 'SwitchPresetWindowWidthBack',
    'SwitchPresetWindowHeight', 'SwitchPresetWindowHeightBack',
    'MaximizeColumn', 'MaximizeWindowToEdges', 'ExpandColumnToAvailableWidth',
    'SetColumnDisplay',  # string arg but we treat as flag; user uses set-column-display str
    'ShowHotkeyOverlay',
    'MoveWorkspaceToMonitorLeft', 'MoveWorkspaceToMonitorRight',
    'MoveWorkspaceToMonitorDown', 'MoveWorkspaceToMonitorUp',
    'MoveWorkspaceToMonitorPrevious', 'MoveWorkspaceToMonitorNext',
    'ToggleWindowFloating', 'MoveWindowToFloating', 'MoveWindowToTiling',
    'FocusFloating', 'FocusTiling', 'SwitchFocusBetweenFloatingAndTiling',
    'ToggleWindowRuleOpacity', 'SetDynamicCastWindow', 'ClearDynamicCastTarget',
    'ToggleOverview', 'OpenOverview', 'CloseOverview',
    # These have focus=bool properties but default=true, so bare node is fine for most users.
    'Screenshot', 'ScreenshotScreen', 'ScreenshotWindow',
    'DoScreenTransition',
]

# Removed from _ACTION_BARE — need typed handling:
# SetColumnDisplay → str arg
# So add it to _ACTION_STR instead.

# Action variants that take a single string argument (or SizeChange/enum serialised as str).
_ACTION_STR = [
    # SpawnSh is handled in the special spawn section of _gen_actions_nix
    'SetColumnWidth',      # set-column-width "+10%" / "960"
    'SetWindowWidth',
    'SetWindowHeight',
    'SwitchLayout',        # switch-layout "next" / "prev"
    'SetWorkspaceName',    # set-workspace-name "name"
    'FocusMonitor',        # focus-monitor "output-name"
    'MoveWindowToMonitor',
    'MoveColumnToMonitor',
    'MoveWorkspaceToMonitor',
]

# Action variants that take a string arg for column display (enum).
_ACTION_STR_DISPLAY = ['SetColumnDisplay']   # set-column-display "normal" / "tabbed"

# Action variants that take a single int argument.
_ACTION_INT = [
    'FocusWindowInColumn',  # focus-window-in-column 2
    'FocusColumn',          # focus-column 3
    'MoveColumnToIndex',
    'MoveWorkspaceToIndex',
]

# Action variants that take a workspace reference (int or string name).
_ACTION_WORKSPACE_REF = [
    'FocusWorkspace',
    'MoveWindowToWorkspace',
    'MoveColumnToWorkspace',
]

# Spawn: listOf str rendered as multi-arg node.
# SetDynamicCastMonitor: optional string.


def _gen_actions_nix() -> str:
    """Generate lib/actions.nix from the action lists already parsed above."""
    lines: list[str] = [
        '# Auto-generated by generate.py — do not edit manually.',
        '# Regenerate: python3 generate.py',
        '#',
        '# Niri action constructors for use in programs.niri.settings.binds:',
        '#   programs.niri.settings.binds = with config.lib.niri.actions; {',
        '#     "Mod+Return".action  = spawn "alacritty";',
        '#     "Mod+Q".action       = close-window;',
        '#     "Mod+1".action       = focus-workspace 1;',
        '#   };',
        'let',
        '  mk  = name:        { __niriAction = name; args = []; props = {}; };',
        '  mkA = name: args:  { __niriAction = name; inherit args; props = {}; };',
        '  mkP = name: props: { __niriAction = name; args = []; inherit props; };',
        'in {',
    ]

    def kebab(camel: str) -> str:
        return camel_to_kebab(camel)

    # ── Quit (has skip-confirmation property variant) ──────────────────────
    lines += [
        '',
        '  # ── Session ──────────────────────────────────────────────────────────────',
        '  quit                   = mk "quit";',
        '  quit-skip-confirmation = mkP "quit" { "skip-confirmation" = true; };',
    ]

    # ── Bare no-arg actions ────────────────────────────────────────────────
    # Exclude actions that need special handling below.
    _SPECIAL = {'Quit', 'Spawn', 'SpawnSh', 'Screenshot', 'ScreenshotScreen',
                'ScreenshotWindow', 'DoScreenTransition', 'SetColumnDisplay',
                'SetDynamicCastMonitor'}
    bare_actions = [v for v in _ACTION_BARE if v not in _SPECIAL]

    lines += ['', '  # ── No-arg actions ───────────────────────────────────────────────────────']
    for v in bare_actions:
        k = kebab(v)
        lines.append(f'  "{k}" = mk "{k}";')

    # ── Screenshot (bare + prop variants) ─────────────────────────────────
    lines += [
        '',
        '  # ── Screenshot ───────────────────────────────────────────────────────────',
        '  screenshot                     = mk  "screenshot";',
        '  screenshot-no-pointer          = mkP "screenshot"        { "show-pointer"  = false; };',
        '  screenshot-screen              = mk  "screenshot-screen";',
        '  screenshot-screen-no-pointer   = mkP "screenshot-screen" { "show-pointer"  = false; };',
        '  screenshot-screen-no-disk      = mkP "screenshot-screen" { "write-to-disk" = false; };',
        '  screenshot-window              = mk  "screenshot-window";',
        '  screenshot-window-show-pointer = mkP "screenshot-window" { "show-pointer"  = true;  };',
        '  screenshot-window-no-disk      = mkP "screenshot-window" { "write-to-disk" = false; };',
    ]

    # ── do-screen-transition ──────────────────────────────────────────────
    lines += [
        '',
        '  # ── Screen transition ────────────────────────────────────────────────────',
        '  do-screen-transition    = mk "do-screen-transition";',
        '  do-screen-transition-ms = ms: mkP "do-screen-transition" { "delay-ms" = ms; };',
    ]

    # ── Spawn ─────────────────────────────────────────────────────────────
    lines += [
        '',
        '  # ── Spawn ────────────────────────────────────────────────────────────────',
        '  spawn    = cmd: mkA "spawn"    (if builtins.isList cmd then cmd else [cmd]);',
        '  spawn-sh = cmd: mkA "spawn-sh" [cmd];',
    ]

    # ── String-arg actions ─────────────────────────────────────────────────
    lines += ['', '  # ── String-arg actions ──────────────────────────────────────────────────']
    for v in _ACTION_STR:
        k = kebab(v)
        lines.append(f'  "{k}" = s: mkA "{k}" [s];')

    # ── set-column-display ────────────────────────────────────────────────
    lines += [
        '  set-column-display = d: mkA "set-column-display" [d];  # "normal" | "tabbed"',
    ]

    # ── set-dynamic-cast-monitor ──────────────────────────────────────────
    lines += [
        '  set-dynamic-cast-monitor = name: mkA "set-dynamic-cast-monitor" [name];',
    ]

    # ── Int-arg actions ───────────────────────────────────────────────────
    lines += ['', '  # ── Int-arg actions ──────────────────────────────────────────────────────']
    for v in _ACTION_INT:
        k = kebab(v)
        lines.append(f'  "{k}" = n: mkA "{k}" [n];')

    # ── Workspace-reference actions ────────────────────────────────────────
    lines += ['', '  # ── Workspace-reference actions (int index or "name") ─────────────────────']
    for v in _ACTION_WORKSPACE_REF:
        k = kebab(v)
        lines.append(f'  "{k}" = ref: mkA "{k}" [ref];')

    lines += ['}', '']
    return '\n'.join(lines)


def _inject_bind_structs(structs: dict) -> None:
    """Inject BindAction and Bind structs for typed binds support."""
    action_fields: list[RustField] = []

    # Bare/bool actions
    for v in _ACTION_BARE:
        name = _camel_to_snake(v)
        action_fields.append(RustField(name, 'bool', 'child', default='false'))

    # Remove SetColumnDisplay from bare (added to _ACTION_STR_DISPLAY instead)
    action_fields = [f for f in action_fields if f.name != 'set_column_display']

    # String-arg actions
    for v in _ACTION_STR + _ACTION_STR_DISPLAY:
        name = _camel_to_snake(v)
        action_fields.append(RustField(name, 'Option<String>', 'child, unwrap(argument)'))

    # Int-arg actions
    for v in _ACTION_INT:
        name = _camel_to_snake(v)
        action_fields.append(RustField(name, 'Option<u32>', 'child, unwrap(argument)'))

    # Workspace-reference actions (int or str)
    for v in _ACTION_WORKSPACE_REF:
        name = _camel_to_snake(v)
        action_fields.append(RustField(name, 'Option<WorkspaceReference>', 'child, unwrap(argument)'))

    # spawn — listOf str, rendered as multi-arg node by renderBindAction
    action_fields.append(RustField('spawn',    'Option<Vec<String>>', 'child, unwrap(arguments)'))
    # set-dynamic-cast-monitor — optional string
    action_fields.append(RustField('set_dynamic_cast_monitor', 'Option<String>', 'child, unwrap(argument)'))

    structs['BindAction'] = RustStruct('BindAction', action_fields)

    # action uses lib.types.anything so the __niriAction sentinel (config.lib.niri.actions.*)
    # passes through without submodule validation.
    structs['Bind'] = RustStruct('Bind', [
        RustField('action',                '__NiriAction',   'child'),
        RustField('allow_when_locked',     'bool',           'property', default='false',
                  apply='v: if v == false then null else v'),
        RustField('allow_inhibiting',      'bool',           'property', default='true',
                  apply='v: if v == true then null else v'),
        RustField('cooldown_ms',           'Option<u64>',    'property', default=None),
        RustField('repeat',                'bool',           'property', default='true',
                  apply='v: if v == true then null else v'),
        RustField('hotkey_overlay',         '__HotkeyOverlay', 'property', default=None),
    ])


def _camel_to_snake(s: str) -> str:
    """CamelCase → snake_case."""
    s = re.sub(r'([A-Z]+)([A-Z][a-z])', r'\1_\2', s)
    s = re.sub(r'([a-z])([A-Z])', r'\1_\2', s)
    return s.lower()


# ---------------------------------------------------------------------------
# Layer-rule Match collision fix
# ---------------------------------------------------------------------------

def _fix_layer_rule_match(structs: dict, niri_root: Path) -> None:
    """
    Both layer_rule.rs and window_rule.rs define a struct named Match.
    parse_all scans files in sorted order, so window_rule.rs wins and
    structs['Match'] ends up with window-rule fields.

    This re-parses layer_rule.rs, saves its Match as LayerRuleMatch, and
    patches LayerRule's field types so matches/excludes resolve correctly.
    """
    from dataclasses import replace as dc_replace

    lr_path = niri_root / "niri-config" / "src" / "layer_rule.rs"
    if not lr_path.exists():
        return

    tmp_structs: dict = {}
    tmp_enums:   dict = {}
    _parse_file(lr_path.read_text(), tmp_structs, tmp_enums)

    if 'Match' not in tmp_structs:
        return

    structs['LayerRuleMatch'] = RustStruct('LayerRuleMatch', tmp_structs['Match'].fields)

    if 'LayerRule' in structs:
        fixed = []
        for f in structs['LayerRule'].fields:
            if f.rust_type == 'Vec<Match>':
                fixed.append(dc_replace(f, rust_type='Vec<LayerRuleMatch>'))
            else:
                fixed.append(f)
        structs['LayerRule'] = RustStruct('LayerRule', fixed)


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

def _fetch_niri(dest: Path) -> None:
    """Clone or update github:soulvice/niri into dest."""
    if (dest / ".git").exists():
        print(f"Pulling {GITHUB_NIRI} → {dest}", file=sys.stderr)
        subprocess.run(["git", "-C", str(dest), "pull", "--ff-only"], check=True)
    else:
        # Remove empty dir if it exists (e.g. from tempfile.mkdtemp) so git
        # clone can create it fresh.
        if dest.exists() and not any(dest.iterdir()):
            dest.rmdir()
        print(f"Cloning {GITHUB_NIRI} → {dest}", file=sys.stderr)
        subprocess.run(
            ["git", "clone", "--depth=1", GITHUB_NIRI, str(dest)],
            check=True,
        )


def main():
    args = sys.argv[1:]
    fetch = False
    if args and args[0] == "--fetch":
        fetch = True
        args = args[1:]

    niri_root = Path(args[0]) if len(args) > 0 else DEFAULT_NIRI_ROOT
    output    = Path(args[1]) if len(args) > 1 else DEFAULT_OUTPUT

    # Fetch logic:
    #   --fetch  → update/clone into the local default path (developer workflow)
    #   path absent, no --fetch → temp clone (CI / first-time run without local checkout)
    _tmp_dir = None
    if fetch:
        # Intentional local update: clone/pull into ~/codes/nix/niri
        niri_root.parent.mkdir(parents=True, exist_ok=True)
        _fetch_niri(niri_root)
    elif not niri_root.exists():
        # Path absent (CI or no local clone): use a temp dir, leave home alone
        _tmp_dir = tempfile.mkdtemp(prefix="niri-src-")
        niri_root = Path(_tmp_dir)
        _fetch_niri(niri_root)

    print(f"Scanning: {niri_root}", file=sys.stderr)
    structs, enums = parse_all(niri_root)
    _inject_animation_structs(structs)
    _inject_bind_structs(structs)
    _fix_layer_rule_match(structs, niri_root)
    print(f"  {len(structs)} structs with #[derive(knuffel::Decode)]", file=sys.stderr)
    print(f"  {len(enums)} enums (DecodeScalar + plain)", file=sys.stderr)

    # Discover root sections dynamically from ConfigPart::decode_children
    lib_rs = (niri_root / "niri-config" / "src" / "lib.rs").read_text()
    sections = parse_root_sections(lib_rs, structs)
    print(f"  {len(sections)} root sections discovered:", file=sys.stderr)
    for kdl, sname, is_list in sections:
        print(f"    {kdl} -> {sname}{'[]' if is_list else ''}", file=sys.stderr)

    root_sections_nix = _gen_root_sections(sections, structs, enums)

    module = (
        "# Auto-generated by generate.py — do not edit manually.\n"
        "# Regenerate: python3 generate.py\n"
        "# This file is imported by module.nix which adds the config section.\n"
        "{ lib, ... }:\n"
        "{\n"
        "  options.programs.niri.settings = {\n\n"
        f"{root_sections_nix}\n\n"
        "  };\n"
        "}\n"
    )

    output.write_text(module)
    print(f"Written: {output}", file=sys.stderr)

    actions_output = output.parent / "lib" / "actions.nix"
    actions_output.parent.mkdir(parents=True, exist_ok=True)
    actions_output.write_text(_gen_actions_nix())
    print(f"Written: {actions_output}", file=sys.stderr)

    docs_output = output.parent / "options.md"
    docs_output.write_text(_gen_docs(sections, structs, enums))
    print(f"Written: {docs_output}", file=sys.stderr)

    html_output = output.parent / "options.html"
    html_output.write_text(_gen_html_docs(sections, structs, enums))
    print(f"Written: {html_output}", file=sys.stderr)

    if _tmp_dir:
        import shutil
        shutil.rmtree(_tmp_dir, ignore_errors=True)


if __name__ == "__main__":
    main()

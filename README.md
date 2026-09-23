# niri-flake

Auto-generated NixOS/Home Manager modules for [niri](https://github.com/YaLTeR/niri), a scrollable-tiling Wayland compositor.

The options in `programs.niri.settings.*` are generated directly from niri's Rust config source (`generate.py`). Run `python3 generate.py` after pulling upstream niri changes to regenerate `generated-options.nix` and `options.md`.

## Usage

### Home Manager (standalone or NixOS + HM)

Add to your flake inputs and import the Home Manager module:

```nix
inputs.niri-flake.url = "github:soulvice/niri-flake";

# In your home-manager configuration:
imports = [ inputs.niri-flake.homeManagerModules.default ];

programs.niri = {
  enable = true;
  settings = {
    prefer-no-csd = true;
    input.keyboard.xkb.layout = "us";
    layout.gaps = 8.0;
    binds."Super+Return".action = { spawn = ["alacritty"]; };
  };
};
```

The module writes `~/.config/niri/config.kdl` and validates it with `niri validate` at build time — a broken config is a build failure.

### NixOS module (replaces nixpkgs programs.niri)

If you want our module to handle the system-level setup (session registration, xdg-portal, gnome-keyring, polkit, systemd units) instead of the nixpkgs `programs.niri` module, use `nixosModules.default`. This automatically disables the nixpkgs module to avoid option redeclaration conflicts.

```nix
inputs.niri-flake.url = "github:soulvice/niri-flake";

# In your NixOS configuration:
imports = [ inputs.niri-flake.nixosModules.default ];

programs.niri = {
  enable = true;
  # useNautilus = true;  # default: true
};
```

### Using both together

The NixOS module handles system-level setup; the Home Manager module handles per-user config. Import both:

```nix
# In nixosConfigurations:
imports = [ inputs.niri-flake.nixosModules.default ];
programs.niri.enable = true;

# In homeConfigurations (or home-manager.users.<name>):
imports = [ inputs.niri-flake.homeManagerModules.default ];
programs.niri = {
  enable = true;
  settings = { ... };
};
```

## Regenerating options

```bash
nix develop   # gets python3
cd ~/codes/nix/niri
git pull
cd ~/codes/nix/niri-flake
python3 generate.py
```

This rewrites `generated-options.nix` (Nix option declarations) and `options.md` (human-readable reference).

## See also

- `options.md` — full option reference, grouped by section
- `module.nix` — static Home Manager module (KDL serialiser + niri validate)
- `nixos-module.nix` — NixOS system-level module
- `generate.py` — parser and code generator
- `generated-options.nix` — auto-generated (do not edit by hand)

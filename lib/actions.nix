# Niri action constructors.
# Each value is either a sentinel attrset or a function returning one:
#   { __niriAction = "name"; args = [...]; props = {...}; }
#
# Usage (in a home-manager module):
#   programs.niri.settings.binds = with config.lib.niri.actions; {
#     "Mod+Return".action = spawn "alacritty";
#     "Mod+Q".action      = close-window;
#     "Mod+1".action      = focus-workspace 1;
#   };
let
  mk  = name:        { __niriAction = name; args = []; props = {}; };
  mkA = name: args:  { __niriAction = name; inherit args; props = {}; };
  mkP = name: props: { __niriAction = name; args = []; inherit props; };
in {
  # ── Session ──────────────────────────────────────────────────────────────
  quit                     = mk "quit";
  quit-skip-confirmation   = mkP "quit" { "skip-confirmation" = true; };
  suspend                  = mk "suspend";
  power-off-monitors       = mk "power-off-monitors";
  power-on-monitors        = mk "power-on-monitors";

  # ── Spawn ─────────────────────────────────────────────────────────────────
  # spawn "app" or spawn ["app" "arg1" "arg2"]
  spawn    = cmd: mkA "spawn"    (if builtins.isList cmd then cmd else [cmd]);
  # spawn-sh runs the argument through $SHELL -c
  spawn-sh = cmd: mkA "spawn-sh" [cmd];

  # ── Screenshot ────────────────────────────────────────────────────────────
  screenshot                       = mk  "screenshot";
  screenshot-no-pointer            = mkP "screenshot"        { "show-pointer"   = false; };
  screenshot-screen                = mk  "screenshot-screen";
  screenshot-screen-no-pointer     = mkP "screenshot-screen" { "show-pointer"   = false; };
  screenshot-screen-no-disk        = mkP "screenshot-screen" { "write-to-disk"  = false; };
  screenshot-window                = mk  "screenshot-window";
  screenshot-window-show-pointer   = mkP "screenshot-window" { "show-pointer"   = true; };
  screenshot-window-no-disk        = mkP "screenshot-window" { "write-to-disk"  = false; };

  # ── Screen transition ─────────────────────────────────────────────────────
  do-screen-transition    = mk "do-screen-transition";
  do-screen-transition-ms = ms: mkP "do-screen-transition" { "delay-ms" = ms; };

  # ── Overview ──────────────────────────────────────────────────────────────
  toggle-overview = mk "toggle-overview";
  open-overview   = mk "open-overview";
  close-overview  = mk "close-overview";

  # ── Hotkey overlay ────────────────────────────────────────────────────────
  show-hotkey-overlay = mk "show-hotkey-overlay";

  # ── Inhibit ───────────────────────────────────────────────────────────────
  toggle-keyboard-shortcuts-inhibit = mk "toggle-keyboard-shortcuts-inhibit";

  # ── Window management ─────────────────────────────────────────────────────
  close-window              = mk "close-window";
  fullscreen-window         = mk "fullscreen-window";
  toggle-windowed-fullscreen = mk "toggle-windowed-fullscreen";
  toggle-window-floating    = mk "toggle-window-floating";
  move-window-to-floating   = mk "move-window-to-floating";
  move-window-to-tiling     = mk "move-window-to-tiling";
  focus-floating            = mk "focus-floating";
  focus-tiling              = mk "focus-tiling";
  switch-focus-between-floating-and-tiling = mk "switch-focus-between-floating-and-tiling";
  toggle-window-rule-opacity = mk "toggle-window-rule-opacity";
  reset-window-height       = mk "reset-window-height";
  maximize-window-to-edges  = mk "maximize-window-to-edges";

  # ── Window sizing ─────────────────────────────────────────────────────────
  # arg: size string — "50%", "+10%", "-200", "200"
  set-window-width  = w: mkA "set-window-width"  [w];
  set-window-height = h: mkA "set-window-height" [h];

  # ── Column management ─────────────────────────────────────────────────────
  focus-window-previous     = mk "focus-window-previous";
  focus-column-left         = mk "focus-column-left";
  focus-column-right        = mk "focus-column-right";
  focus-column-first        = mk "focus-column-first";
  focus-column-last         = mk "focus-column-last";
  focus-column-right-or-first = mk "focus-column-right-or-first";
  focus-column-left-or-last   = mk "focus-column-left-or-last";
  focus-column              = n: mkA "focus-column" [n];
  focus-window-in-column    = n: mkA "focus-window-in-column" [n];

  move-column-left          = mk "move-column-left";
  move-column-right         = mk "move-column-right";
  move-column-to-first      = mk "move-column-to-first";
  move-column-to-last       = mk "move-column-to-last";
  move-column-left-or-to-monitor-left   = mk "move-column-left-or-to-monitor-left";
  move-column-right-or-to-monitor-right = mk "move-column-right-or-to-monitor-right";
  move-column-to-index      = n: mkA "move-column-to-index" [n];

  center-column             = mk "center-column";
  center-window             = mk "center-window";
  center-visible-columns    = mk "center-visible-columns";
  maximize-column           = mk "maximize-column";
  expand-column-to-available-width = mk "expand-column-to-available-width";
  toggle-column-tabbed-display = mk "toggle-column-tabbed-display";
  set-column-display        = d: mkA "set-column-display" [d]; # "normal" | "tabbed"
  set-column-width          = w: mkA "set-column-width" [w];
  switch-preset-column-width      = mk "switch-preset-column-width";
  switch-preset-column-width-back = mk "switch-preset-column-width-back";
  switch-preset-window-width      = mk "switch-preset-window-width";
  switch-preset-window-width-back = mk "switch-preset-window-width-back";
  switch-preset-window-height     = mk "switch-preset-window-height";
  switch-preset-window-height-back = mk "switch-preset-window-height-back";

  swap-window-left          = mk "swap-window-left";
  swap-window-right         = mk "swap-window-right";
  consume-or-expel-window-left  = mk "consume-or-expel-window-left";
  consume-or-expel-window-right = mk "consume-or-expel-window-right";
  consume-window-into-column    = mk "consume-window-into-column";
  expel-window-from-column      = mk "expel-window-from-column";

  # ── Window focus (directional) ────────────────────────────────────────────
  focus-window-down         = mk "focus-window-down";
  focus-window-up           = mk "focus-window-up";
  focus-window-down-or-column-left  = mk "focus-window-down-or-column-left";
  focus-window-down-or-column-right = mk "focus-window-down-or-column-right";
  focus-window-up-or-column-left    = mk "focus-window-up-or-column-left";
  focus-window-up-or-column-right   = mk "focus-window-up-or-column-right";
  focus-window-or-workspace-down    = mk "focus-window-or-workspace-down";
  focus-window-or-workspace-up      = mk "focus-window-or-workspace-up";
  focus-window-or-monitor-up        = mk "focus-window-or-monitor-up";
  focus-window-or-monitor-down      = mk "focus-window-or-monitor-down";
  focus-column-or-monitor-left      = mk "focus-column-or-monitor-left";
  focus-column-or-monitor-right     = mk "focus-column-or-monitor-right";
  focus-window-top          = mk "focus-window-top";
  focus-window-bottom       = mk "focus-window-bottom";
  focus-window-down-or-top  = mk "focus-window-down-or-top";
  focus-window-up-or-bottom = mk "focus-window-up-or-bottom";

  move-window-down          = mk "move-window-down";
  move-window-up            = mk "move-window-up";
  move-window-down-or-to-workspace-down = mk "move-window-down-or-to-workspace-down";
  move-window-up-or-to-workspace-up     = mk "move-window-up-or-to-workspace-up";

  # ── Workspace management ──────────────────────────────────────────────────
  focus-workspace-down      = mk "focus-workspace-down";
  focus-workspace-up        = mk "focus-workspace-up";
  focus-workspace-previous  = mk "focus-workspace-previous";
  focus-workspace           = ref: mkA "focus-workspace" [ref]; # int index or "name"

  move-column-to-workspace-down = mk "move-column-to-workspace-down";
  move-column-to-workspace-up   = mk "move-column-to-workspace-up";
  move-column-to-workspace      = ref: mkA "move-column-to-workspace" [ref];
  move-window-to-workspace-down = mk "move-window-to-workspace-down";
  move-window-to-workspace-up   = mk "move-window-to-workspace-up";
  move-window-to-workspace      = ref: mkA "move-window-to-workspace" [ref];

  move-workspace-down       = mk "move-workspace-down";
  move-workspace-up         = mk "move-workspace-up";
  move-workspace-to-index   = n: mkA "move-workspace-to-index" [n];
  move-workspace-to-monitor = name: mkA "move-workspace-to-monitor" [name];
  move-workspace-to-monitor-left  = mk "move-workspace-to-monitor-left";
  move-workspace-to-monitor-right = mk "move-workspace-to-monitor-right";
  move-workspace-to-monitor-down  = mk "move-workspace-to-monitor-down";
  move-workspace-to-monitor-up    = mk "move-workspace-to-monitor-up";
  move-workspace-to-monitor-previous = mk "move-workspace-to-monitor-previous";
  move-workspace-to-monitor-next     = mk "move-workspace-to-monitor-next";

  set-workspace-name        = name: mkA "set-workspace-name" [name];
  unset-workspace-name      = mk "unset-workspace-name";

  # ── Monitor management ────────────────────────────────────────────────────
  focus-monitor-left        = mk "focus-monitor-left";
  focus-monitor-right       = mk "focus-monitor-right";
  focus-monitor-down        = mk "focus-monitor-down";
  focus-monitor-up          = mk "focus-monitor-up";
  focus-monitor-previous    = mk "focus-monitor-previous";
  focus-monitor-next        = mk "focus-monitor-next";
  focus-monitor             = name: mkA "focus-monitor" [name];

  move-window-to-monitor-left     = mk "move-window-to-monitor-left";
  move-window-to-monitor-right    = mk "move-window-to-monitor-right";
  move-window-to-monitor-down     = mk "move-window-to-monitor-down";
  move-window-to-monitor-up       = mk "move-window-to-monitor-up";
  move-window-to-monitor-previous = mk "move-window-to-monitor-previous";
  move-window-to-monitor-next     = mk "move-window-to-monitor-next";
  move-window-to-monitor          = name: mkA "move-window-to-monitor" [name];

  move-column-to-monitor-left     = mk "move-column-to-monitor-left";
  move-column-to-monitor-right    = mk "move-column-to-monitor-right";
  move-column-to-monitor-down     = mk "move-column-to-monitor-down";
  move-column-to-monitor-up       = mk "move-column-to-monitor-up";
  move-column-to-monitor-previous = mk "move-column-to-monitor-previous";
  move-column-to-monitor-next     = mk "move-column-to-monitor-next";
  move-column-to-monitor          = name: mkA "move-column-to-monitor" [name];

  # ── Layout ────────────────────────────────────────────────────────────────
  switch-layout             = l: mkA "switch-layout" [l]; # "next" | "prev"

  # ── Dynamic cast ─────────────────────────────────────────────────────────
  set-dynamic-cast-window   = mk "set-dynamic-cast-window";
  set-dynamic-cast-monitor  = name: mkA "set-dynamic-cast-monitor" [name];
  clear-dynamic-cast-target = mk "clear-dynamic-cast-target";

  # ── Debug ─────────────────────────────────────────────────────────────────
  toggle-debug-tint           = mk "toggle-debug-tint";
  debug-toggle-opaque-regions = mk "debug-toggle-opaque-regions";
  debug-toggle-damage         = mk "debug-toggle-damage";
}

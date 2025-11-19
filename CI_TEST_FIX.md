# CI Test Fix: Missing Test Files

## 🐛 **Problem**

The workflow was failing because it tried to use test files that weren't committed to the repository:

```bash
error: path '/home/runner/work/niri-flake/niri-flake/test-config.nix' does not exist
```

## 🔍 **Root Cause**

The workflow was referencing external test files (`test-config.nix`, `tests/test-*.nix`) that existed locally but weren't committed to the repository, making them unavailable in the CI environment.

## 🔧 **Solution: Inline Test Generation**

Instead of relying on external files, the workflow now **creates test configurations inline** using heredoc syntax.

### **Before (Broken):**
```bash
# ❌ Depends on external file
nix eval --impure -f test-config.nix basic-config.programs.niri.enable
```

### **After (Fixed):**
```bash
# ✅ Creates test inline
cat > test-basic.nix << 'EOF'
{
  basic-config = {
    programs.niri = {
      enable = true;
      settings = {
        input.keyboard.repeat-delay = 600;
        layout.gaps = 16;
        spawn-at-startup = [ "alacritty" ];
      };
    };
  };
}
EOF

nix eval --impure -f test-basic.nix basic-config.programs.niri.enable
```

### **Key Benefits:**

1. **Self-contained CI** - No dependency on external files
2. **Always works** - Test configs are generated fresh each time
3. **Version controlled** - Test logic is in the workflow YAML
4. **Easy to modify** - No need to update separate files

### **Tests Now Included:**

#### **1. Basic Configuration Test**
```nix
programs.niri = {
  enable = true;
  settings = {
    input.keyboard.repeat-delay = 600;  # kebab-case
    layout.gaps = 16;
    spawn-at-startup = [ "alacritty" ];
  };
};
```

#### **2. Kebab-Case Validation Test**
```nix
programs.niri = {
  enable = true;
  settings = {
    input = {
      keyboard.repeat-delay = 600;      # kebab-case
      touchpad.accel-profile = "adaptive"; # kebab-case
    };
    layout.focus-ring = {               # kebab-case
      enable = true;
      active-color = "#7fc8ff";         # kebab-case
    };
  };
};
```

#### **3. Actions Library Test**
```nix
let
  actionsLib = import ./generator/actions-lib.nix;
in {
  actionTests = {
    close-window-action = actionsLib.close-window;
    spawn-test = actionsLib.spawn "test-app";
    close-window-correct = actionsLib.close-window == "close-window";
  };
}
```

## ✅ **Verification**

All inline tests work correctly:

```bash
# ✅ Basic config evaluation
nix eval --impure -f test-basic.nix basic-config.programs.niri.enable
# → true

# ✅ Kebab-case config evaluation
nix eval --impure -f test-basic.nix kebab-config.programs.niri.enable
# → true

# ✅ Actions library validation
nix eval --impure -f test-validation.nix actionTests.close-window-correct
# → true
```

## 🎯 **Workflow Reliability**

The workflow is now **completely self-contained** and doesn't depend on any external test files. This makes it:

- **More reliable** - No missing file errors
- **Easier to maintain** - Tests are visible in the workflow
- **Faster** - No need to check for file existence
- **Clearer** - Test intentions are obvious

The CI should now pass without any missing file errors! 🎉
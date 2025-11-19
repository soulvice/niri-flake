# Workflow Fix: Flake Output Issue

## 🐛 **Problem**

The workflow was failing with this error:
```
error: expected flake output attribute 'homeManagerModules.niri' to be a derivation or path but found a function: «lambda generateModule @ /home/runner/work/niri-flake/niri-flake/generator/module-generator.nix:18:5»
```

## 🔍 **Root Cause**

The flake was trying to expose a **generator function** as a home-manager module instead of an actual module. The `generateNiriModule` function returns a function that needs to be called, but flake outputs expect ready-to-use modules.

### **Before (Broken):**
```nix
# flake.nix
homeManagerModules = {
  niri = generator.generateNiriModule { inherit niriSrc; };  # ❌ Function
}
```

### **After (Fixed):**
```nix
# flake.nix
homeManagerModules = {
  niri = import ./module/niri.nix;  # ✅ Actual module
}
```

## 🔧 **Solution**

### **1. Use Static Module**
Instead of generating the module dynamically at evaluation time, use the **static module** we already have in `module/niri.nix`.

### **2. Simplify Flake Structure**
```nix
outputs = { self, nixpkgs, flake-utils }:
{
  # Use the static module directly (system independent)
  homeManagerModules = {
    niri = import ./module/niri.nix;
    default = import ./module/niri.nix;
  };

  # Make the module easily testable
  nixosModules.niri = import ./module/niri.nix;
}
```

### **3. Update Workflow Testing**
Changed from trying to build the module (which was a function) to evaluating it:

```bash
# Before (failed):
nix build .#homeManagerModules.niri

# After (works):
nix eval .#homeManagerModules.niri --impure
```

## ✅ **Benefits of This Approach**

1. **Simpler Flake** - Direct import instead of complex generation
2. **Faster Evaluation** - No dynamic generation needed
3. **Better Caching** - Static imports are more cache-friendly
4. **Clearer Structure** - Obvious what the flake exposes

## 🧪 **Testing**

The fix can be tested locally:

```bash
# Test module evaluation
nix eval .#homeManagerModules.niri --impure >/dev/null

# Test with actual configurations
nix eval --impure -f test-config.nix basic-config.programs.niri.enable

# Test generator still works for development
nix build .#packages.x86_64-linux.generator
```

## 🎯 **Key Insight**

**Flake outputs should be data, not functions.** The `homeManagerModules` attribute should contain actual modules that can be imported, not generator functions that produce modules.

This fix makes the flake behave correctly while maintaining all the validation and kebab-case functionality we built! ✅
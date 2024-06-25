# aura
A primitive AUR helper written in Bash.

## Install aura
To install aura, just run `sudo make`, then `make clean` to delete clutter.
### Fallback
If you forget to use `sudo`, aura will be partially installed. To finish installation, just run `sudo make -f make-fallback` and follow the instructions that it gives you.

## Managing packages
To install a package from the AUR, just pass the package name as an argument. For example:
```bash
aura devtoys-bin
```
To remove a package, pass the `-R` flag.
```bash
aura -R devtoys-bin
```

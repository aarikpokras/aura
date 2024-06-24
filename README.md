# aura
A primitive AUR helper written in Bash.

## Install aura
To install aura, just run `sudo make`, then `make clean` to delete clutter.

## Managing packages
To install a package from the AUR, just pass the package name as an argument. For example:
```bash
aura devtoys-bin
```
To remove a package, pass the `-R` flag.
```bash
aura -R devtoys-bin
```

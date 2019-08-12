# WARNING

This is tailored for my personal use, *do not use without forking and adjusting for yours*.

I use this for initialising a fresh MacOS install to somewhat usable state, it is not intended to fully automate the system configuration.

## Usage

```sh
xcode-select --install
cd && mkdir src && cd !$
git clone https://github.com/chkhd/init-macos && cd init-macos
./install
```

The script will try to make backups in `~/.backups` before overwriting stuff.

## Inspiration
https://github.com/mathiasbynens/dotfiles
https://github.com/holman/dotfiles

# WARNING

This is tailored for my personal use, *do not use without forking and adjusting for yours*.

I use this for initialising a fresh MacOS install to somewhat usable state, it is not intended to fully automate the system configuration.

## init-macos

What can be automated, should be automated. In that vein, this will take a fresh MacOS machine and install:
- Command Line Tools, Homebrew
- Apps from Mac App Store
- Apps using Cask
- Command line utilities using brew, pip etc.

It will also adjust several MacOS defaults, configure Emacs, Vim, Nano and bunch of other stuff. I invite you to read `install`, it should be mostly self explanatory.

## Usage

```sh
git clone https://github.com/chkhd/init-macos
cd init-macos
./install
```

The script will try to make backups for most stuff in `~/backups` but local files intended to be populated by automation or `install` itself will be ruthlessly overwritten.

## Inspiration
https://github.com/mathiasbynens/dotfiles  
https://github.com/holman/dotfiles

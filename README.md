# Dotfiles

This is my [dotfiles](https://dotfiles.github.io/). There are many like it, but this one is mine.

## Instructions

First of all you're going to need to install a couple of things:

1. System update and Command Line Tools

Make sure to have installed all updates available for your system.

```sh
/usr/sbin/softwareupdate –i -a
/usr/bin/xcode-select --install
if /usr/sbin/sysctl -n machdep.cpu.brand_string | grep -o "Apple"; then
  /usr/sbin/softwareupdate –install-rosetta –agree-to-license
fi
sudo xcodebuild -license
```

1. Install `nix` and `home-manager

```sh
sh <(curl -L https://nixos.org/nix/install) --darwin-use-unencrypted-nix-store-volume
source $HOME/.nix-profile/etc/profile.d/nix.sh
nix-env -iA nixpkgs.stow
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
```

1. Configuration

This will build and install the appropriate configuration for your system.

```sh
make
make install
```

1. Tmux plugins

Start a new terminal window and create a new tmux session.

```sh
tmux
```

Now once you're connected to a tmux session, you have to install plugins by
pressing `prefix` + `I` (capital i).

That's it, you should be ready to go now...

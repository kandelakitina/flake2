## Installation

### Bootstrapping

After cloning the repo use:

```sh
nix develop
```

This will create a custom shell, that is defined in `flake.nix` under `devShell`
in `outputs` part, which refers to `shell.nix`, found in the folder. It uses
versions of packages, locked in the `flake.lock` to avoid updating the flake
(takes time).

The custom shell allows to use `Home-Manager` to do `home-manager switch .`.

Additionally, there's `age` and `sops` to encrypt secrets.

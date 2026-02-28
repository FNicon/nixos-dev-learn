

# Bash

## Development

### Build

```bash
nix-build '<nixpkgs/nixos>' -A vm -I nixpkgs=channel:nixos-25.11 -I nixos-config=./vm/configuration.nix
```

### Check build

```bash
ls -R ./result
```

### Run TTY

```bash
QEMU_KERNEL_PARAMS=console=ttyS0 ./result/bin/run-nixos-vm -nographic; reset
```


### Run GUI

```bash
nix-build '<nixpkgs/nixos>' -A vm -I nixpkgs=channel:nixos-25.11 -I nixos-config=./vm/configuration.nix
./result/bin/run-nixos-vm
```

### Power off VM

```bash
sudo poweroff
```

### Remove VM

```bash
rm nixos.qcow2
```

## ISO

```bash
NIX_PATH=nixpkgs=https://github.com/NixOS/nixpkgs/archive/74e2faf5965a12e8fa5cff799b1b19c6cd26b0e3.tar.gz nix-shell -p nixos-generators --run "nixos-generate --format iso --configuration ./iso/image.nix -o result"
dd if=result/iso/*.iso of=/dev/sdX status=progress
sync
```

## Docker

```bash
nix-build ./docker/docker.nix
```

## Test

```bash
nix-build ./test/minimal-test.nix
```

```bash
$(nix-build -A driverInteractive ./test/minimal-test.nix)/bin/nixos-test-driver
```

## Remote SSH Deploy NixOS

### nix shell remote

```bash
nix-shell -p npins
```

### run shell.nix

```bash
nix-shell
```

### Test disk layout

```bash
nix-build -E "((import <nixpkgs> {}).nixos [ ./configuration.nix ]).installTest"
```

### Deploy

```bash
toplevel=$(nixos-rebuild build --no-flake)
diskoScript=$(nix-build -E "((import <nixpkgs> {}).nixos [ ./configuration.nix ]).diskoScript")
nixos-anywhere --store-paths "$diskoScript" "$toplevel" root@target-host
```

### Update

```bash
npins update nixpkgs
nixos-rebuild switch --no-flake --target-host root@target-host
```


# Reference

https://nix.dev/tutorials/nixos/nixos-configuration-on-vm#nixos-vms
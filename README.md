# Hyprland smart borders (aka dynamic borders)

A bash script to enable **dynamic borders** (aka **smart borders**) in hyprland using _hyprland-ipc_. This does what could be done via scripting mentioned [here](https://github.com/hyprwm/Hyprland/issues/2324).

Handles almost all the cases which I could think of.

See the demo to see how it works.

https://github.com/devadathanmb/hyprland-dynamic-borders/assets/84301852/c32d2c2d-5d94-4063-b053-5dcdab05c296

## Dependencies

1. [socat](https://man.archlinux.org/man/socat.1.en) : For communicating with hyprland ipc instance
2. [jq](https://man.archlinux.org/man/jq.1.en) : For parsing hyprctl response

## Example usage

1. Download the script using

```bash
wget https://raw.githubusercontent.com/devadathanmb/hyprland-dynamic-borders/main/dynamic-borders.sh
```

2. Make sure the script is executable and move it to the preferred location

```bash
chmod a+x ./dynamic-borders.sh
mkdir -p ~/.local/bin
mv ./dynamic-borders.sh ~/.loca/bin
```

4. Put the script to your auto start section in `~/.config/hyprland.conf`

```bash
exec-once = ~/.local/bin/dynamic-borders.sh
```

5. Enjoy smart borders!

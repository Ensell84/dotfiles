# dotfiles

## Install

To generate all simlinks:

```bash
source link.sh
```

## Keyd

```bash
git clone https://github.com/rvaiya/keyd
cd keyd
make && sudo make install
sudo systemctl enable --now keyd
```

## Kernel params

```bash
sudo grubby --update-kernel=ALL --args="random.trust_cpu=on rcu_nocbs=all rcutree.enable_rcu_lazy=1 amdgpu.abmlevel=0"
```

## Powertop

```bash
sudo pacman -Syu powertop
```

Run `powertop.sh`(callibration + auto-tune service):
```bash
source powertop.sh
```

## Rclone sync

> TODO

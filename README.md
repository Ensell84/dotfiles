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
sudo grubby --update-kernel=ALL --args="random.trust_cpu=on module_blacklist=ideapad_laptop rcu_nocbs=all rcutree.enable_rcu_lazy=1 amdgpu.abmlevel=0"
```

## Powertop

```bash
sudo dnf install powertop
sudo powertop --calibrate
```

After calibration:

```bash
sudo ln -nfs $HOME/dotfiles/powertop-auto-tune.service /etc/systemd/system/powertop-auto-tune.service
sudo systemctl daemon-reload
sudo systemctl enable powertop-auto-tune.service
```

## Rclone sync

> TODO

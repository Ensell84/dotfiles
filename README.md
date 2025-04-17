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
sudo grubby --update-kernel=ALL --args="random.trust_cpu=on module_blacklist=ideapad_laptop rcu_nocbs=all rcutree.enable_rcu_lazy=1 amdgpu.abmlevel=0"

## Powertop
sudo dnf install powertop
sudo powertop --calibrate

### Autostort service

sudo nvim /etc/systemd/system/powertop-auto-tune.service

```
[Unit]
Description=PowerTOP Auto-Tune
After=multi-user.target

[Service]
Type=oneshot
ExecStart=/usr/sbin/powertop --auto-tune

[Install]
WantedBy=multi-user.target
```

```bash
sudo systemctl daemon-reload
sudo systemctl enable powertop-auto-tune.service
```

## Rclone sync

> TODO

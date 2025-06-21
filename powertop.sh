sudo powertop --calibrate
sudo ln -nfs $HOME/dotfiles/configs/powertop-auto-tune.service /etc/systemd/system/powertop-auto-tune.service
sudo systemctl daemon-reload
sudo systemctl enable powertop-auto-tune.service

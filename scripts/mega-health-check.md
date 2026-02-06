# Setting up the Health check script
Create the user systemd folder if it doesnt exist and link the script to ~/.local/bin
```sh
mkdir -p $HOME/.config/systemd/user
ln -s path/to/dotfiles/scripts/mega-health-check.sh $HOME/.local/bin/mega-health-check.sh
```

# Systemd service and timer
The systemd unit and timer files are located in `.config/systemd/user`. Copy these files to the folder created in the previous step
```sh
cp path/to/dofiles/.config/systemd/user/mega-health.service $HOME/.config/systemd/user
cp path/to/dofiles/.config/systemd/user/mega-health.timer $HOME/.config/systemd/user
```

## Enabling systemd service and timer
```sh
systemctl --user daemon-reexec
systemctl --user daemon-reload

#enable the timer
systemctl --user enable --now mega-health.timer
systemctl --user start mega-health.service
```

## Checking if its running
```sh
# check if the timer is running
systemctl --user list-timers | grep mega

# check the logs of the service
journalctl --user -u mega-health.service

# you can also check the log file
less ~/.cache/mega-health/mega.log
```

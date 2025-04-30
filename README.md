# Roon Pi Display with Clock Fallback

This project sets up a Raspberry Pi to:

- Display your Roon "Now Playing" screen fullscreen
- Automatically fall back to a large 24-hour digital clock if Roon is unreachable

## Install

Run the following on your Pi (after cloning or pointing to this repo):

```bash
bash <(curl -s https://raw.githubusercontent.com/<your-user>/<your-repo>/main/full-install-with-clock.sh)
```

You'll be prompted to enter your Roon Core's IP address.

## After setup

Reboot the Pi:

```bash
sudo reboot
```

It will boot straight into Roon Display or clock fallback.

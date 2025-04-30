# Roon Pi Display with Clock Fallback

This project sets up a Raspberry Pi to:

- Display your Roon "Now Playing" screen fullscreen
- Automatically fall back to a large 24-hour digital clock if Roon is unreachable

  <https://chatgpt.com/c/681034b2-bfd8-800d-b6bb-e181313b4b44>

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

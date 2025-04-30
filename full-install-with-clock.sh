#!/bin/bash

set -e

sudo apt update
sudo apt install --no-install-recommends -y \
  xserver-xorg x11-xserver-utils xinit openbox chromium-browser unclutter nginx

# Prompt for Roon Core IP
read -rp "Enter your Roon Core IP address (e.g. 192.168.1.100): " ROONCOREIP

# Setup nginx HTML content
sudo mkdir -p /var/www/html/clock
sudo mkdir -p /var/www/html/launcher

# Clock page
sudo tee /var/www/html/clock/index.html > /dev/null <<'EOF'
<!DOCTYPE html>
<html>
<head>
<title>Clock</title>
<style>
body {
  background-color: black;
  color: white;
  font-family: sans-serif;
  font-size: 10vw;
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
  margin: 0;
}
</style>
</head>
<body>
<div id="clock"></div>
<script>
function updateClock() {
  const now = new Date();
  const h = now.getHours().toString().padStart(2, '0');
  const m = now.getMinutes().toString().padStart(2, '0');
  document.getElementById('clock').innerText = h + ':' + m;
}
setInterval(updateClock, 1000);
updateClock();
</script>
</body>
</html>
EOF

# Launcher page
sudo tee /var/www/html/index.html > /dev/null <<EOF
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="refresh" content="0; url=http://$ROONCOREIP:9330/display/" />
<script>
setTimeout(function() {
  window.location.href = "/clock/";
}, 10000);
</script>
</head>
<body>
Redirecting to Roon Display...
</body>
</html>
EOF

# Configure Openbox autostart
mkdir -p ~/.config/openbox
cat > ~/.config/openbox/autostart <<EOF
xset s off
xset -dpms
xset s noblank
unclutter -idle 0.5 &
while true; do
  chromium-browser --noerrdialogs --disable-infobars --kiosk http://localhost/
  sleep 2
done
EOF

# Configure startx at login
if ! grep -q "startx" ~/.bash_profile 2>/dev/null; then
  echo '
if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
  startx
fi
' >> ~/.bash_profile
fi

echo "✅ Setup complete. Reboot your Pi with: sudo reboot"

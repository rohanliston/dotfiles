# ==[ MacBook  ]=============================================================================

# Reset keyboard backlight on boot
#is_macbook=$(dmidecode -s system-product-name | grep MacbookPro)
#[[ (is_macbook) ]] && echo 0 > /sys/class/leds/smc::kbd_backlight/brightness

# ==[ Keyboard ]=============================================================================

# Set keybaoard delay and repeat
xset r rate 250 40


# ==[ Key Bindings (xkb ]====================================================================

# Remap Caps Lock to Control
setxkbmap -option ctrl:nocaps


# ==[ Key Bindings (gsettings) ]=============================================================

setopt shwordsplit

BEGINNING="gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings"
KEY_PATH="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings"

gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings \
"['$KEY_PATH/custom0/', '$KEY_PATH/custom1/', '$KEY_PATH/custom2/', '$KEY_PATH/custom3/']"

# Take a screenshot of the entire display
$BEGINNING/custom0/ name "Screenshot Entire Screen"
$BEGINNING/custom0/ command "gnome-screenshot -c"
$BEGINNING/custom0/ binding "<Alt><Shift>2"

# screenshot the current active window
$BEGINNING/custom1/ name "Screenshot Active Window"
$BEGINNING/custom1/ command "gnome-screenshot -cw"
$BEGINNING/custom1/ binding "<Alt><Shift>3"

# Take a selection of screen with screenshot
$BEGINNING/custom2/ name "Screenshot Selection"
$BEGINNING/custom2/ command "gnome-screenshot -ca"
$BEGINNING/custom2/ binding "<Alt><Shift>4"

# Open up file browser
$BEGINNING/custom3/ name "Nautilus"
$BEGINNING/custom3/ command "/usr/bin/nautilus --new-window"
$BEGINNING/custom3/ binding "<Super>E"

unsetopt shwordsplit


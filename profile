export GOPATH=$HOME/Development/go_path

setxkbmap -option ctrl:nocaps       # Make Caps Lock a Control key
echo 0 >> /sys/class/leds/smc::kbd_backlight/brightness

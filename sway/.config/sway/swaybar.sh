keyboard_input_name="1:1:AT_Translated_Set_2_keyboard"
datetime=$(date "+%F %T")

battery_charge=$(upower --show-info $(upower --enumerate | grep 'BAT') | grep "percentage" | awk '{print $2}')
battery_status=$(upower --show-info $(upower --enumerate | grep 'BAT') | grep "state" | awk '{print $2}')

audio_volume=$(pamixer --get-volume)
audio_is_muted=$(pamixer --get-mute)

# Others
language=$(swaymsg -r -t get_inputs | awk '/1:1:AT_Translated_Set_2_keyboard/;/xkb_active_layout_name/' | grep -A1 '\b1:1:AT_Translated_Set_2_keyboard\b' | grep "xkb_active_layout_name" | awk -F '"' '{print $4}')

if [ $battery_status = "discharging" ];
then
    battery_pluggedin='⚠'
else
    battery_pluggedin='⚡'
fi

if [ $audio_is_muted = "true" ]
then
    audio_active='🔇'
else
    audio_active='🔊'
fi

echo "⌨ $language | $audio_active $audio_volume% | $battery_pluggedin $battery_charge | 🕘 $datetime"

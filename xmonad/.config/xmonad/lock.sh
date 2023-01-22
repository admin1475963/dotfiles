B='#00000000'  # blank
C='#ffffff00'  # clear ish
D='#00bbffff'  # default
T='#00bbffff'  # text
W='#ff0000ff'  # wrong
V='#0000ffbb'  # verifying
IMAGE="$WALLPAPERS/current"

i3lock \
--image=$IMAGE --scale \
--insidever-color=$C   \
--ringver-color=$V     \
--insidewrong-color=$C \
--ringwrong-color=$W   \
--inside-color=$B      \
--ring-color=$D        \
--line-color=$B        \
--separator-color=$D   \
--verif-color=$T        \
--wrong-color=$T        \
--time-color=$T        \
--date-color=$T        \
--layout-color=$T      \
--keyhl-color=$W       \
--bshl-color=$W        \
--screen 1            \
--clock               \
--indicator           \
--time-str="%H:%M:%S"  \
--date-str="%d %m %Y" \
--keylayout 1

-----------------------------------------------------------------------
-- Imports
-- Not xmonad imports
import System.Exit
import qualified Data.Map as M
-- Base of xmonad
import           XMonad
import qualified XMonad.StackSet as W
import           XMonad.Actions.GridSelect
import           XMonad.Hooks.DynamicLog
import           XMonad.Hooks.StatusBar
import           XMonad.Hooks.StatusBar.PP
import           XMonad.Hooks.ManageDocks
import           XMonad.Hooks.EwmhDesktops
import           XMonad.Layout.Spacing
import           XMonad.Layout.TwoPane
import           XMonad.Util.EZConfig
import           XMonad.Util.Loggers
import           XMonad.Util.SpawnOnce
-----------------------------------------------------------------------
-- Main
main = xmonad . docks . ewmhFullscreen . ewmh . xmobarProp $ myConfig
myConfig = def {
    modMask            = myModMask,
    terminal           = myTerminal,
    borderWidth        = myBorderWidth,
    normalBorderColor  = myNormalBorderColor,
    focusedBorderColor = myFocusedBorderColor,
    focusFollowsMouse  = myFocusFollowsMouse,
    workspaces         = myWorkspaces,
    layoutHook         = myLayoutHook,
    manageHook         = myManageHook,
    startupHook        = myStartupHook
} `additionalKeysP` myKeys `removeKeysP` ["M-<Space>"]
-----------------------------------------------------------------------
-- ModKey
myModMask = mod4Mask
-----------------------------------------------------------------------
-- Terminal
myTerminal = "alacritty"
-----------------------------------------------------------------------
-- Window borders
myBorderWidth = 2
myNormalBorderColor  = "#dddddd"
myFocusedBorderColor = "#00ffff"
-----------------------------------------------------------------------
-- Whether focus follows the mouse pointer.
myFocusFollowsMouse = True
-----------------------------------------------------------------------
-- Workspaces
myWorkspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
------------------------------------------------------------------------
-- LayoutHook
myLayoutHook =
    avoidStruts $
    spacingWithEdge 4 $
    Full ||| TwoPane (3/100) (1/2)
------------------------------------------------------------------------
-- ManageHook
myManageHook = composeAll [
    className =? "Emacs" --> doShift "2"
    , className =? "okular" --> doShift "3"
    , className =? "Brave-browser" --> doShift "4"
    , className =? "TelegramDesktop" --> doShift "6"
    , className =? "thunderbird" --> doShift "6"
    , className =? "zoom" --> doShift "7"
    ]
------------------------------------------------------------------------
-- StartupHook
myStartupHook = do
    spawnOnce "xcompmgr -c -o.0"
    spawn     "feh --bg-scale $WALLPAPERS/current"
    spawnOnce "xmobar"
    spawnOnce "trayer --edge right --align center --widthtype request --height 20 --SetDockType true --SetPartialStrut true"
------------------------------------------------------------------------
-- Keymaps
myKeys = [
    -- Quit xmonad
    ("M-S-q", io exitSuccess)

    -- Restart xmonad
    , ("M-S-r", spawn "xmonad --recompile; xmonad --restart")

    -- Rotate through the available layout algorithms
    , ("M-S-<Tab>", sendMessage NextLayout)

    -- Close focused window
    , ("M-S-c", kill)

    -- Shrink the master area
    , ("M-h", sendMessage Shrink)

    -- Expand the master area
    , ("M-l", sendMessage Expand)

    -- Move focus to the next window
    , ("M-j", windows W.focusDown)

    -- Move focus to the previous window
    , ("M-k", windows W.focusUp)

    -- Toggle float mode
    , ("M-t", withFocused toggleFloat)

    -- Launch menu
    , ("M-m", spawn "dmenu_run")

    -- Applications list
    , ("M-a", spawn "rofi -show window")

    -- Launch a terminal
    , ("M-<Return>", spawn myTerminal)

    -- Passwords
    , ("M-C-p", spawn "pass.sh")

    -- Launch emacs
    , ("M-e", spawn "emacsclient -c -a 'emacs'")

    -- Launch browser
    , ("M-w", spawn "brave")

    -- Restart emacs daemon
    , ("M-C-e", spawn "killall emacs; emacs --daemon > /tmp/emacs.log")

    -- Lock screen
    , ("M-C-l", spawn "lock.sh")

    -- Launch telegram
    , ("M-C-t", spawn "telegram-desktop --")

    -- Launch mail client
    , ("M-C-m", spawn "thunderbird")

    -- Screenshot
    , ("M-C-s", spawn "flameshot gui")

    -- Move mouse
    , ("M-<Left>", spawn "xdotool mousemove_relative -- -10 0")
    , ("M-<Right>", spawn "xdotool mousemove_relative -- 10 0")
    , ("M-<Up>", spawn "xdotool mousemove_relative -- 0 -10")
    , ("M-<Down>", spawn "xdotool mousemove_relative -- 0 10")
    , ("M-C-c", spawn "xdotool click 1")
    , ("M-C-d", spawn "xdotool mousedown 1")
    , ("M-C-z", spawn "xdotool mouseup 1")

    -- Sound control
    , ("<XF86AudioMute>", spawn "amixer set Master toggle")
    , ("<XF86AudioLowerVolume>", spawn "amixer -q sset Master 5%-")
    , ("<XF86AudioRaiseVolume>", spawn "amixer -q sset Master 5%+")

    -- Brightness control
    , ("<XF86MonBrightnessDown>", spawn "xbacklight -dec 10")
    , ("<XF86MonBrightnessUp>", spawn "xbacklight -inc 10")
    ]
  where
    toggleFloat w = windows (\s -> if M.member w (W.floating s)
                    then W.sink w s
                    else (W.float w (W.RationalRect (1/7) (1/7) (5/7) (5/7)) s))

------------------------------------------------------------------------
-- App grid configuration
myGSConfig colorizer = (buildDefaultGSConfig colorizer)
myGridColorizer = colorRangeFromClassName
                     black            -- lowest inactive bg
                     black            -- highest inactive bg
                     white            -- active bg
                     white            -- inactive fg
                     black            -- active fg
  where black = minBound
        white = maxBound
------------------------------------------------------------------------

import XMonad
import XMonad.Config.Gnome
import XMonad.ManageHook

main = xmonad gnomeConfig {
    manageHook = myManageHook
    , startupHook = startup
    }

terminal :: String
terminal = "xterm"

myManageHook = composeAll (
    [ manageHook gnomeConfig
    , className =? "Do"       --> doFloat
    ])

startup :: X ()
startup = do
          spawn "gnome-do"
          spawn "ssh-add"
          spawn "parcellite"
          spawn "/home/tyler/.screenlayout/autostart.sh"

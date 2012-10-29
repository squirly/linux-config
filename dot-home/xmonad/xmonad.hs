import XMonad
import XMonad.Config.Gnome
import XMonad.ManageHook

main = xmonad gnomeConfig {
    manageHook = myManageHook
    , startupHook = startup
    , terminal = "xterm"
    , borderWidth = 1
    , normalBorderColor  = "#000"
    , focusedBorderColor = "#FF5721"
    }

myManageHook = composeAll (
    [ manageHook gnomeConfig
    , className =? "Do"       --> doFloat
    ])

startup :: X ()
startup = do
          spawn "gnome-keyring-daemon"
          spawn "gnome-screensaver"
          spawn "gnome-settings-daemon"
          spawn "gnome-power-manager"
          spawn "/home/tyler/.startup"
          spawn "ssh-add"
          spawn "gnome-do"
          spawn "parcellite"

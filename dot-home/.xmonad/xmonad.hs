import XMonad
import XMonad.Config.Gnome
import XMonad.ManageHook

main = xmonad gnomeConfig {
    manageHook = myManageHook
    , startupHook = startup
    }

myManageHook = composeAll (
    [ manageHook gnomeConfig
    , className =? "Do"       --> doFloat
    ])

startup :: X ()
startup = do
          spawn "gnome-do"

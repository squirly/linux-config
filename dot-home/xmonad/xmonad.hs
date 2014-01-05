import XMonad
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.ManageHook
import XMonad.Hooks.EwmhDesktops
import Data.List

main = do
    xmproc <- spawnPipe "/usr/bin/xmobar /home/tyler/.xmonad/xmobar"

    xmonad $ ewmh defaultConfig {
          manageHook = manageDocks <+> myManageHook
	, layoutHook = avoidStruts $ layoutHook defaultConfig
        , startupHook = startup
        , terminal = "xterm"
        , borderWidth = 1
        , normalBorderColor  = "#000"
        , focusedBorderColor = "#FF5721"
    }

myManageHook = composeAll [
      manageHook defaultConfig
    , className =? "Do"   --> doFloat
    , className =? "Gimp" --> doFloat
    , className =? "Vncviewer" --> doFloat
    ]

startup :: X ()
startup = do
          spawn "/usr/bin/gnome-keyring-daemon --start --components=pkcs11"
          spawn "xloadimage -onroot -fullscreen ~/.background"
          spawn "gnome-screensaver"
          spawn "gnome-settings-daemon"
          spawn "~/.startup"
          spawn "ssh-add"
          spawn "gnome-do"
          spawn "parcellite"

import XMonad
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.ManageHook
import XMonad.Hooks.EwmhDesktops
import XMonad.Actions.CopyWindow
import Data.Map as Map
import Data.List

q ~=? x = fmap (isPrefixOf x) q

main = do
    xmproc <- spawnPipe "/usr/bin/xmobar /home/tyler/.xmonad/xmobar"

    xmonad $ ewmh defaultConfig {
          manageHook = myManageHook
	, layoutHook = avoidStruts $ layoutHook defaultConfig
        , startupHook = startup
        , XMonad.keys = myKeys  <+> XMonad.keys defaultConfig
        , terminal = "xterm"
        , borderWidth = 1
        , normalBorderColor  = "#000"
        , focusedBorderColor = "#FF5721"
    }

myManageHook = composeAll [
      manageHook defaultConfig
    , resource =? "synapse" --> doIgnore
    , className =? "Gimp" --> doFloat
    , className =? "Vncviewer" --> doFloat
    , (className ~=? "jetbrains-") <&&> (title ~=? "win") --> doIgnore
    ] <+> manageDocks

myKeys conf@(XConfig {XMonad.modMask = modm}) = Map.fromList [
      ((modm .|. controlMask, xK_a ), windows copyToAll) -- @@ Make focused window always visible
    , ((modm .|. controlMask .|. shiftMask, xK_a ),  killAllOtherCopies) -- @@ Toggle window state back
    ]

startup :: X ()
startup = do
          spawn "wmname LG3D"
          spawn "/usr/bin/gnome-keyring-daemon --start --components=pkcs11"
          spawn "xloadimage -onroot -fullscreen ~/.background"
          spawn "gnome-screensaver"
          spawn "gnome-session"
          spawn "unity-settings-daemon"
          spawn "~/.startup"
          spawn "ssh-add"
          spawn "synapse"

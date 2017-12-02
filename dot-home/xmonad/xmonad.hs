import XMonad
import XMonad.Actions.CopyWindow
import XMonad.Config.Gnome
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import System.Exit

import qualified Data.Map        as M
import qualified Data.List       as L
import qualified XMonad.StackSet as W

q ~=? x = fmap (L.isPrefixOf x) q

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList [
      ((modm              ,  xK_k ), windows W.focusDown     )
    , ((modm              ,  xK_j ), windows W.focusUp       )
    , ((modm .|. shiftMask,  xK_k ), windows W.swapDown      )
    , ((modm .|. shiftMask,  xK_j ), windows W.swapUp        )
    , ((modm              ,  xK_a ), windows copyToAll       )
    , ((modm .|. shiftMask,  xK_a ), killAllOtherCopies      )
    , ((modm              ,  xK_b ), sendMessage ToggleStruts)
  ]

myLayout = avoidStruts (tiled ||| Mirror tiled ||| Full)
    where tiled = Tall 1 (2/100) (4/7)

-- Use `xprop | grep WM_CLASS` for 'className' and 'resource'
-- Use `xprop | grep WM_NAME` for 'title'
myManageHook = composeAll [
      className =? "Cerebro"        --> doCenterFloat
    , className =? "Gimp"           --> doFloat
    , className =? "Vncviewer"      --> doFloat
    , (className ~=? "jetbrains-") <&&> (title ~=? "win") --> doIgnore
    , resource  =? "desktop_window" --> doIgnore
  ]

myLogHook = return ()

myStartupHook = do
    -- spawn "wmname LG3D"
    spawn "gnome-keyring-daemon --start --components=pkcs11"
    spawn "xloadimage -onroot -center -zoom 80 ~/.background"
    spawn "gnome-screensaver"
    spawn "gnome-session"
    spawn "~/.startup"
    spawn "ssh-add"
    spawn "cerebro"

main =
    xmonad $ gnomeConfig {
        terminal           = "xterm",
        focusFollowsMouse  = True,
        borderWidth        = 1,
        normalBorderColor  = "black",
        focusedBorderColor = "#FF5721",
        keys               = myKeys <+> XMonad.keys defaultConfig,
        layoutHook         = myLayout,
        manageHook         = myManageHook,
        logHook            = myLogHook,
        startupHook        = myStartupHook
    }

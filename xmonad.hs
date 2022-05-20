import XMonad
import Graphics.X11.ExtraTypes.XF86
import XMonad.Actions.SpawnOn
import XMonad.Util.EZConfig
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.SetWMName
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.UrgencyHook
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing

defaults = defaultConfig 
   { terminal			= "alacritty"
   , modMask			= defaultModMask
   , borderWidth  		= 0
   , layoutHook 		= defaultLayoutHook
   , workspaces			= defaultWorkspaces
   , handleEventHook 	= defaultEventHook
   , manageHook 		= defaultManageHook
   , startupHook 		= defaultStartupHook
   } `additionalKeys` myKeys

webWs					= "1:web"
devWs					= "2:dev"
pdfWs					= "3:pdf"
steamWs 				= "4:steam"

defaultModMask = mod4Mask

defaultWorkspaces = [webWs, devWs, pdfWs, steamWs] ++ map show [5..9]

defaultEventHook = fullscreenEventHook <+> ewmhDesktopsEventHook

defaultManageHook = manageSpawn <+> composeAll
    [ className =? "Google-chrome" 		     --> doShift webWs
    , className =? "jetbrains-idea-ce" 		 --> doShift devWs 
    , className =? "Atril"			         --> doShift pdfWs
    , className =? "Steam"			         --> doShift steamWs
    , isFullscreen                     		 --> doFullFloat
    , isDialog                         		 --> doCenterFloat
    ]

defaultLayoutHook = smartBorders tiled ||| noBorders Full
  where
    tiled   = spacing pix $ Tall nmaster delta ratio
    pix     = 3
    nmaster = 1
    ratio   = 1/2
    delta   = 5/100

defaultStartupHook = do 
	setWMName "LG3D"

myKeys = [
   ((0, xF86XK_AudioRaiseVolume),  spawn "amixer -D pulse sset Master 5%+")
 , ((0, xF86XK_AudioLowerVolume),  spawn "amixer -D pulse sset Master 5%-")
 , ((0, xF86XK_AudioMute),         spawn "amixer -D pulse sset Master toggle")
 , ((0, xK_Print),	   	           spawn "scrot -e '~/.config/./scrot_screen.sh $f'")
 ]

xmobarCurrentWorkspaceColor = "#6699CC"
urgencyColor = "#F99157"
xmobarTitleColor = "#66CCCC"

defaultXmobarPP = xmobarPP
    { ppCurrent = xmobarColor xmobarCurrentWorkspaceColor "" . wrap "<fn=3>[" "]</fn>"
    , ppUrgent  = xmobarColor urgencyColor ""
    , ppSep     = " | "
    , ppTitle   = xmobarColor xmobarTitleColor "" . shorten 60 .wrap "" ""
    }

main = do
    cfg <- statusBar "xmobar" defaultXmobarPP
           (\c -> (modMask c, xK_f)) . withUrgencyHook (BorderUrgencyHook urgencyColor)
           $ defaults
    xmonad cfg
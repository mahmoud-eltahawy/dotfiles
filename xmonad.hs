import XMonad
import Data.Monoid

import System.Exit
import XMonad.Util.SpawnOnce
import XMonad.Util.Run

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

-- M (Alt) is mapped to s (super)

myKeys conf@(XConfig {XMonad.modMask = super}) = M.fromList $
    [
    -- launch a terminal
      ((super,               xK_Return), spawn $ XMonad.terminal conf)

    -- launch dmenu
    , ((super,               xK_a     ), spawn "dmenu_run")

    -- launch emacs client
    , ((super,               xK_e     ), spawn "emacsclient -c")

    -- close focused window
    , ((super,               xK_q     ), kill)

     -- Rotate through the available layout algorithms
    , ((super,               xK_f ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((super .|. shiftMask, xK_f ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((super,               xK_5     ), refresh)

    -- Move focus to the next window
    , ((super,               xK_l   ), windows W.focusDown)

    -- Move focus to the next window
    , ((super,               xK_l     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((super,               xK_h     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((super,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window with the next window
    , ((super .|. mod1Mask, xK_l     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((super .|. mod1Mask, xK_h     ), windows W.swapUp    )

    -- Shrink the master area
    , ((super .|. shiftMask, xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((super .|. shiftMask, xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((super,               xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((super              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((super              , xK_period), sendMessage (IncMasterN (-1)))

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    -- , ((super              , xK_b     ), sendMessage ToggleStruts)

    -- Quit xmonad
    , ((super .|. shiftMask, xK_q     ), io exitSuccess)

    -- Restart xmonad
    , ((super .|. mod1Mask , xK_q     ), spawn "xmonad --recompile; xmonad --restart")

    -- switch language
    , ((super,               xK_space ), spawn "setxkbmap us")
    , ((super .|. mod1Mask , xK_space ), spawn "setxkbmap ar")

    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. super, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = super}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((super, button1), \w -> focus w >> mouseMoveWindow w >> windows W.shiftMaster)

    -- mod-button2, Raise the window to the top of the stack
    , ((super, button2), \w -> focus w >> windows W.shiftMaster)

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((super, button3), \w -> focus w >> mouseResizeWindow w>> windows W.shiftMaster)

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
myLayout = tiled ||| Full
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore ]

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook = mempty

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
myLogHook = return ()

------------------------------------------------------------------------
-- Startup hook---------------------------------------------------------
------------------------------------------------------------------------

myStartupHook = do
     spawnOnce "emacs --bg-daemon &"
     spawnOnce "nitrogen --restore &"
     spawnOnce "picom &"

------------------------------------------------------------------------
--Now run xmonad with all the defaults we set up------------------------
------------------------------------------------------------------------

main = do
    xmproc <- spawnPipe "xmobar ~/magit/workflow/xmobarrc"
    xmonad defaults

-- A structure containing your configuration settings, overriding
defaults = def {
        terminal           = "alacritty",
        focusFollowsMouse  = True,
        clickJustFocuses   = False,
        borderWidth        = 1,
        modMask            = mod4Mask,
        workspaces         = ["1","2","3","4","5","6","7","8","9"],
        normalBorderColor  = "#dddddd",
        focusedBorderColor = "#ff0000",

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = myLayout,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        logHook            = myLogHook,
        startupHook        = myStartupHook
    }

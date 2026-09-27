-- monitor
hl.monitor({
  output   = "",
  mode     = "preferred",
  position = auto,
  scale    = "1"
})
-- application variables
local appRunner = "hyprlauncher"
local emulateTerminal = "kitty"
local launchGames = "steam"
local manageFiles = "thunar"
local notificationDaemon = "mako"
local statusBar = "waybar"
local wallpaperUtility = "hyprpaper"
local webAltBrowser = "firefox"
local webBrowser = "chromium"
-- auto start applications
hl.on( "hyprland.start", function ( )
  hl.exec_cmd( notificationDaemon )
  hl.exec_cmd( wallpaperUtility )
  hl.exec_cmd( statusBar )
  hl.exec_cmd( emulateTerminal )
end)
-- environment
---- cursor
hl.env( "XCURSOR_SIZE", "16" )
hl.env( "HYPRCURSOR_SIZE", "16" )
-- key bindings
local superKey = "SUPER"
---- single key
hl.bind( superKey .. " + B", hl.dsp.exec_cmd( webBrowser ))
hl.bind( superKey .. " + F", hl.dsp.exec_cmd( manageFiles ))
hl.bind( superKey .. " + G", hl.dsp.exec_cmd( launchGames ))
hl.bind( superKey .. " + R", hl.dsp.exec_cmd( appRunner ))
hl.bind( superKey .. " + T", hl.dsp.exec_cmd( emulateTerminal ))
hl.bind( superKey .. " + V", hl.dsp.window.float({ action = "toggle" }))
---- multiple keys
hl.bind( superKey .. " + ALT + B", hl.dsp.exec_cmd( webAltBrowser ) )
hl.bind( superKey .. " + RETURN", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
------ closing related
hl.bind( superKey .. " + ESCAPE", hl.dsp.window.close( ))
hl.bind( superKey .. " + CONTROL + ESCAPE", hl.dsp.exec_cmd( "command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'" ))
---- Move focus in current workspace
hl.bind( superKey .. " + left" , hl.dsp.focus({ direction = "left"  }))
hl.bind( superKey .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind( superKey .. " + up"   , hl.dsp.focus({ direction = "up"    }))
hl.bind( superKey .. " + down" , hl.dsp.focus({ direction = "down"  }))
hl.bind( superKey .. " + Tab"  , function ( )
  hl.dispatch( hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
  hl.dispatch( hl.dsp.window.cycle_next( ))
  hl.dispatch( hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
end)
---- Switch workspaces
for key = 1, 8 do
  hl.bind( superKey .. " + "         .. key, hl.dsp.focus({ workspace = key }))
  hl.bind( superKey .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = key }))
end
---- Scroll through existing workspaces
hl.bind( superKey .. " + ALT + left" , hl.dsp.focus({ workspace = "e-1" }))
hl.bind( superKey .. " + ALT + right", hl.dsp.focus({ workspace = "e+1" }))
---- Move/resize windows with `mainMod + LMB/RMB` and dragging
hl.bind( superKey .. " + mouse:272", hl.dsp.window.drag( )  , { mouse = true })
hl.bind( superKey .. " + mouse:273", hl.dsp.window.resize( ), { mouse = true })
---- Laptop multimedia keys for volume and LCD brightness
hl.bind( "XF86AudioMute",        hl.dsp.exec_cmd( "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")    , { locked = true, repeating = true })
hl.bind( "XF86AudioMicMute",     hl.dsp.exec_cmd( "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle")  , { locked = true, repeating = true })
hl.bind( "XF86AudioRaiseVolume", hl.dsp.exec_cmd( "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind( "XF86AudioLowerVolume", hl.dsp.exec_cmd( "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-")     , { locked = true, repeating = true })
hl.bind( "XF86MonBrightnessUp",  hl.dsp.exec_cmd( "brightnessctl -e4 -n2 set 5%+")                 , { locked = true, repeating = true })
hl.bind( "XF86MonBrightnessDown",hl.dsp.exec_cmd( "brightnessctl -e4 -n2 set 5%-")                 , { locked = true, repeating = true })

-- 特殊工作区
hl.workspace_rule({
  workspace = "special:exposed",
  gaps_out = 16,
  gaps_in = 9,
  border_size = 5,
  no_border = false,
  no_shadow = true,
})

hl.workspace_rule({
  workspace = "special:special",
  gaps_out = 64,
  gaps_in = 9,
  border_size = 3,
  no_border = false,
  no_shadow = true,
  -- 原 hyprlang: on-created-empty:[fullscreenstate 0 1]alacritty
  on_created_empty = "[fullscreenstate 0 1]alacritty",
})

hl.layer_rule({
  name = "eww-slide-anim",
  match = { namespace = "eww-slide" },
  animation = "slide",
})

hl.window_rule({
  name = "persistent-size",
  match = { initial_class = ".*" },
  persistent_size = true,
})

-- ----------- Floating windows -----------
local floatClasses =
  "[Tt]hunar|clash-verge|yesplaymusic|QQ|xdg-desktop-portal-gtk|org.pulseaudio.pavucontrol|com.github.hluk.copyq|nm-connection-editor|.blueman-manager-wrapped|gay.vaskel.Soteria"
local floatTitles = "微信"

hl.window_rule({
  name = "float-by-class",
  match = { initial_class = floatClasses },
  float = true,
})

hl.window_rule({
  name = "float-by-title",
  match = { initial_title = floatTitles },
  float = true,
})

-- ----------- Floating windows with specific size -----------
local haltSizeClasses =
  "clash-verge|QQ|xdg-desktop-portal-gtk|org.pulseaudio.pavucontrol|com.github.hluk.copyq|nm-connection-editor|.blueman-manager-wrapped"

hl.window_rule({
  name = "half-size",
  match = { initial_class = haltSizeClasses },
  size = "50% 50%",
})

hl.window_rule({
  name = "half-size-thunar",
  match = { initial_class = "[Tt]hunar", initial_title = ".*[Tt]hunar" },
  size = "50% 50%",
})

-- ----------- Center the floating windows -----------
hl.window_rule({
  name = "center-floating",
  match = { float = true },
  center = true,
})

-- ----------- Fix wechat popup -----------
hl.window_rule({
  name = "wechat-move",
  match = { initial_title = "wechat" },
  move = "cursor -10% -10%",
})

hl.window_rule({
  name = "wechat-noblur",
  match = { initial_title = "wechat" },
  no_blur = true,
})

-- ----------- activeopacity / inactiveopacity / fullscreenopacity -----------
hl.window_rule({
  name = "opacity-terminal",
  match = { initial_class = "Alacritty|kitty" },
  opacity = "0.8 0.7 0.9", -- active, inactive, fullscreen
})

hl.window_rule({
  name = "opacity-obsidian",
  match = { initial_class = "obsidian" },
  opacity = "0.95 0.9 0.95", -- active, inactive, fullscreen
})

hl.window_rule({
  name = "pin-swappy",
  match = { initial_class = "swappy" },
  pin = true,
})

hl.window_rule({
  name = "idleinhibit-fullscreen",
  match = { fullscreen = true },
  idle_inhibit = "fullscreen",
})

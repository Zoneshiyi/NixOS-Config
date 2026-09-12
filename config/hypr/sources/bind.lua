local mainMod = "SUPER"
local files = "thunar"
local term = "alacritty"

-- LAUNCH
hl.bind(
  mainMod .. " + A",
  hl.dsp.exec_cmd(
    [[hyprctl monitors -j | jq -c ".[] | select(.focused==true) | .name" | xargs -I {} eww open --toggle apps --arg monitor={}]]
  )
)
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd([[pkill rofi || rofi -show combi -combi-modi "drun,run"]]))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(files))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd([[grim -g "$(slurp)" - | swappy -f -]]))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("code $ELECTRON_OPTIONS"))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.exec_cmd("pkill wlogout || wlogout -b 4"))
hl.bind(mainMod .. " + SHIFT + Return", hl.dsp.exec_cmd(term))

-- pyprland
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("pkill rofi || pypr menu"))
hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd("pypr zoom"))
hl.bind(mainMod .. " + tab", hl.dsp.exec_cmd("pypr expose"))
-- 原 bindl（锁屏时也可用）-> locked
hl.bind(mainMod .. " + ALT + L", hl.dsp.exec_cmd("pypr toggle_dpms"), { locked = true })

-- SESSION
hl.bind("CTRL + ALT + Delete", hl.dsp.exit())

-- FULLSCREEN / PROPS
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ action = "set" }))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ action = "unset" }))
hl.bind(mainMod .. " + ALT + F", hl.dsp.exec_cmd("hyprctl dispatch workspaceopt allfloat"))
hl.bind(mainMod .. " + ALT + O", hl.dsp.window.set_prop({ prop = "opaque", value = "toggle" }))

-- WINDOW
-- 原 hyprlang 里 SUPER+C 同时绑了 togglefloating 和 centerwindow
hl.bind(mainMod .. " + C", function()
  hl.dispatch(hl.dsp.window.float({ action = "toggle" }))
  hl.dispatch(hl.dsp.window.center())
end)

hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + ALT + Q", hl.dsp.window.kill())

-- 原 ALT+tab 同时绑了 cyclenext 和 alterzorder top
hl.bind("ALT + tab", function()
  hl.dispatch(hl.dsp.window.cycle_next())
  hl.dispatch(hl.dsp.window.alter_zorder({ mode = "top" }))
end)

-- Resize windows（原 binde -> repeating）
hl.bind(
  mainMod .. " + SHIFT + left",
  hl.dsp.window.resize({ x = -50, y = 0, relative = true }),
  { repeating = true }
)
hl.bind(
  mainMod .. " + SHIFT + right",
  hl.dsp.window.resize({ x = 50, y = 0, relative = true }),
  { repeating = true }
)
hl.bind(
  mainMod .. " + SHIFT + up",
  hl.dsp.window.resize({ x = 0, y = -50, relative = true }),
  { repeating = true }
)
hl.bind(
  mainMod .. " + SHIFT + down",
  hl.dsp.window.resize({ x = 0, y = 50, relative = true }),
  { repeating = true }
)

-- Move windows
hl.bind(mainMod .. " + CTRL + left", hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + CTRL + right", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + CTRL + up", hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + CTRL + down", hl.dsp.window.move({ direction = "d" }))

-- Move focus
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "d" }))

-- Workspaces
hl.bind(mainMod .. " + Return", hl.dsp.workspace.toggle_special())
hl.bind(mainMod .. " + comma", hl.dsp.focus({ workspace = "-1" }))
hl.bind(mainMod .. " + period", hl.dsp.focus({ workspace = "+1" }))
hl.bind(mainMod .. " + s", hl.dsp.window.move({ workspace = "special" }))

-- 数字工作区：code:10..19 = 1..0
for i = 1, 10 do
  local key = "code:" .. (i + 9) -- 10 -> 1, ..., 19 -> 0
  hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
  hl.bind(mainMod .. " + CTRL + " .. key, hl.dsp.window.move({ workspace = i, silent = true }))
end

hl.bind(mainMod .. " + SHIFT + comma", hl.dsp.window.move({ workspace = "-11" }))
hl.bind(mainMod .. " + SHIFT + period", hl.dsp.window.move({ workspace = "+1" }))
hl.bind(mainMod .. " + CTRL + comma", hl.dsp.window.move({ workspace = "-1", silent = true }))
hl.bind(mainMod .. " + CTRL + period", hl.dsp.window.move({ workspace = "+1", silent = true }))

-- 滚轮切换工作区
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "-1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "+1" }))

-- 拖拽 / 缩放窗口（原 bindm -> mouse = true）
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

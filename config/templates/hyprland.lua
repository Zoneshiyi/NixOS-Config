-- 每主机模板：显示器布局 / 工作区绑定 / eww 开关
-- 由 home-manager 的 create-templates 复制到 ~/.config/templates/

local monitor0 = "DP-1"
local monitor1 = "HDMI-A-1"
-- local monitor2 = "DP-2"

hl.monitor({ output = monitor0, mode = "prefered", position = "1920x0", scale = 1.5 })
hl.monitor({ output = monitor1, mode = "1920x1080@60", position = "0x0", scale = 1, transform = 0 })

hl.env("XCURSOR_SIZE", "32")

for i = 1, 5 do
  hl.workspace_rule({ workspace = i, monitor = monitor0 })
end
for i = 6, 10 do
  hl.workspace_rule({ workspace = i, monitor = monitor1 })
end

local toggleTopBar = 'eww open-many --toggle top-bar:top-0 top-bar:top-1'
  .. ' --arg top-0:monitor="' .. monitor0 .. '" --arg top-1:monitor="' .. monitor1 .. '"'
local toggleSideBar = 'eww open-many --toggle side-bar:side-0 side-bar:side-1'
  .. ' --arg side-0:monitor="' .. monitor0 .. '" --arg side-1:monitor="' .. monitor1 .. '"'

hl.on("hyprland.start", function()
  hl.exec_cmd(toggleTopBar .. " && " .. toggleSideBar)
end)

hl.bind("SUPER + W", hl.dsp.exec_cmd(toggleTopBar .. " && " .. toggleSideBar))

-- exec-once 等价物：只在 Hyprland 启动时触发，reload 不会重复执行
hl.on("hyprland.start", function()
  hl.exec_cmd("pypr &")
  hl.exec_cmd("copyq --start-server &")
  hl.exec_cmd("clash-verge &")

  hl.exec_cmd("fcitx5 -d -r &")
  hl.exec_cmd("xrdb -merge ~/.Xresources &")

  -- rclone 必须后台：--daemon 会阻塞到挂载就绪，卡住会拖住整个启动
  hl.exec_cmd(
    "rclone mount --vfs-cache-mode full --daemon --dir-perms 0755 --file-perms 0660 "
      .. "Obsidian: ~/Documents/rclone/Obsidian/docs &"
  )
end)

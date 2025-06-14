function listen-events
  switch $argv[1]
    case "wsp"
      workspaces
    case "win"
      windows
    case "vol"
      volume
  end
end

function volume
  pw-mon | rg --line-buffered -F "Channel Volumes" | while read line

    set -l volume (wpctl get-volume @DEFAULT_AUDIO_SINK@)
    set -l muted (echo $volume | cut -d ' ' -f 3)
    set -l volume (math "$(echo $volume | cut -d ' ' -f 2) * 100")

    if test -z $muted
      set muted "\"\""
    else
      set muted "\"\""
    end

    echo "{\"volume\":$volume,\"muted\":$muted}"
  end
end

function windows
  opened-windows
  socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | rg --line-buffered -F -e "activewindowv2" -e "closewindow" -e "openwindow" | while read line
    opened-windows
  end
end

function opened-windows
  set -l id2name (hyprctl monitors -j | jq -c 'sort_by(.id)|map(.name)')

  set -l active_window (hyprctl activewindow -j | jq '.address')

  set -l windows (hyprctl clients -j | jq --argjson id2name $id2name --argjson active_window $active_window -c '
  sort_by(.pid)
  | sort_by(.workspace.id)
  | map({monitor,initialClass,address})
  | group_by(.monitor)
  | map ({key:$id2name[.[0].monitor],
  value:map([.initialClass,.address,
    if .address==$active_window then "active"
    else "opened"
    end
  ])}) | from_entries')

  echo $windows
end

function workspaces
  created-workspaces
  socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | rg --line-buffered -F -e "workspacev2" -e "focusedmonv2" | while read line
    created-workspaces
  end
end

function created-workspaces

  set -l active_wsp (hyprctl activeworkspace -j | jq '.id')
  set -l icons '"󰲡","󰲣","󰲥","󰲧","󰲩","󰲫","󰲭","󰲯","󰲱","󰿭"'
  set -l active_icons '"󰲠","󰲢","󰲤","󰲦","󰲨","󰲪","󰲬","󰲮","󰲰","󰿬"'

  set -l workspaces (hyprctl workspaces -j | jq -c "
  map({monitor,id}|select(.id>0))
  | sort_by(.id)
  | group_by(.monitor)
  | map({ key: .[0].monitor, value: map(.id) }) 
  | from_entries
  | with_entries(
    .value |= map(
      if .==$active_wsp then [., [$active_icons][.-1], \"active\"]
      else [., [$icons][.-1], \"created\"]
      end
    )
  )")

  echo $workspaces

end
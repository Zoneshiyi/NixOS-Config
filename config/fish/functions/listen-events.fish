function listen-events
  if test $argv[1] = "wsp"
    workspaces
  else if test $argv[1] = "win"
    windows
  else if test $argv[1] = "vol"
    volume
  end
end

function volume
  pw-mon | rg --line-buffered "Channel Volumes" | while read line
    echo -n "["

    set -l volume (wpctl get-volume @DEFAULT_AUDIO_SINK@)
    set -l muted (echo $volume | cut -d ' ' -f 3)
    set -l volume (math "$(echo $volume | cut -d ' ' -f 2) * 100")

    echo -n $volume,

    if test -z $muted
      echo -n "\"\""
    else
      echo -n "\"\""
    end

    echo "]"
  end
end

function windows
  opened-windows
  socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | rg --line-buffered "activewindowv2" | while read line
    opened-windows
  end
end

function opened-windows
  set -l id2name (hyprctl monitors -j | jq -c 'sort_by(.id)|map(.name)')

  set -l active_window (hyprctl activewindow -j | jq '.address')

  set -l windows (hyprctl clients -j | jq --argjson id2name $id2name --argjson active_window $active_window -c '
  map({monitor,initialClass,address})
  | sort_by(.initialClass)
  | group_by(.monitor)
  | map ({key:$id2name[.[0].monitor],
  value:map([.initialClass,.address,
    if .address==$active_window then "active"
    else "opened"
    end
  ])})
  |from_entries')

  echo $windows
end

function workspaces
  created-workspaces
  socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | rg --line-buffered "workspacev2|focusedmonv2" | while read line
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
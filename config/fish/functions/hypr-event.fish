function hypr-event
  if test $argv[1] = "wsp"
    workspaces
  else if test $argv[1] = "win"
    windows
  end
end

function windows
  opened-windows
  socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read line
    if string match -q "activewindowv2*" $line
      opened-windows
    end
  end
end

function opened-windows
  set -l id2name (hyprctl monitors -j | jq -c 'sort_by(.id)|map(.name)')
  set -l windows (hyprctl clients -j | jq --argjson id2name "$id2name" -c 'sort_by(.initialClass) | group_by(.monitor) | map ({key:$id2name[.[0].monitor],value:map(.initialClass)})|from_entries')
  echo $windows
end

function workspaces
  created-workspaces
  socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read line
    if string match -q "workspacev2*" $line; or string match -q "focusedmonv2*" $line
      created-workspaces
    end
  end
end

function created-workspaces
  set -l workspaces (hyprctl workspaces -j | jq -c 'sort_by(.id) | group_by(.monitor) | map({ key: .[0].monitor, value: map(.id) }) | from_entries')
  set -l active_wsp (hyprctl activeworkspace -j | jq '.id')
  set -l icons '"󰲡","󰲣","󰲥","󰲧","󰲩","󰲫","󰲭","󰲯","󰲱","󰿭"'
  set -l active_icons '"󰲠","󰲢","󰲤","󰲦","󰲨","󰲪","󰲬","󰲮","󰲰","󰿬"'
  echo $workspaces | jq -c "with_entries(.value |= map(select(. > 0))) |
    with_entries(
      .value |= map([., [$icons][.-1], \"used\"])
    ) | with_entries(
      .value |= map(
        if .[0]==$active_wsp then [.[0], [$active_icons][.[0]-1], \"active\"]
        else .
        end
      )
    )
  "
end
function hypr-event
  if test $argv[1] = "wsp"
    workspaces
  end
end

function workspaces
  used-workspaces
  socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read line
    if string match -q "workspacev2*" $line; or string match -q "focusedmonv2*" $line
      used-workspaces
    end
  end
end

function used-workspaces
  set -l workspaces (hyprctl workspaces -j | jq 'sort_by(.id) | group_by(.monitor) | map({ key: .[0].monitor, value: map(.id) }) | from_entries')
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
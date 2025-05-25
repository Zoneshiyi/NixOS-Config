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
  pw-mon | rg --line-buffered -F "Channel Volumes" | while read line
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
  socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | rg --line-buffered -F "activewindowv2" | while read line
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
  ])}) | .[]')

  echo $windows | while read -l entry
    set -l monitor (echo $entry | jq -r '.key')
    set -l apps (echo $entry | jq -c '.value[]')

    set -l new_apps

    for app in $apps
      set -l name (echo $app | jq -r '.[0]')
      set -l addr (echo $app | jq -r '.[1]')
      set -l state (echo $app | jq -r '.[2]')
      set -l new_name (cat $(xdg-which $name) | rg -F -m 1 "Icon" | cut -d "=" -f 2)
      if test -z $new_name
        set new_name "default-application"
      end

      set -l json_line (jq -nc --arg name "$new_name" --arg addr "$addr" --arg state "$state" '[$name, $addr, $state]')
      set new_apps $new_apps $json_line
    end

    set new_apps "[$(string join "," $new_apps)]"
    echo (jq -nc --arg key "$monitor" --argjson value $new_apps '{($key): $value}')
  end | jq -s -c 'add'
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
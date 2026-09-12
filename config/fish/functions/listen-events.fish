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

    echo "[$volume,$muted]"
  end
end

function windows
  opened-windows
  niri msg --json event-stream 2>/dev/null | jq -c --unbuffered '
    select(has("WindowOpenedOrChanged") or has("WindowClosed")
        or has("WindowFocusChanged") or has("WindowsChanged")
        or has("WorkspacesChanged"))
  ' | while read line
    opened-windows
  end
end

function opened-windows
  set -l wsmap (niri msg --json workspaces 2>/dev/null | jq -c '
    map({key: (.id|tostring), value: {output: (.output // "unknown"), idx: .idx}})
    | from_entries')

  niri msg --json windows 2>/dev/null | jq -c --argjson wsmap $wsmap '
    map(. + {out: $wsmap[(.workspace_id|tostring)].output,
             wsi: $wsmap[(.workspace_id|tostring)].idx})
    | map(select(.out != null))
    | sort_by(.wsi, .id)
    | group_by(.out)
    | map({key: .[0].out,
           value: map([(.app_id // "unknown"), .id,
                       (if .is_focused then "active" else "opened" end)])})
    | from_entries'
end

function workspaces
  set -l icons '"󰲡","󰲣","󰲥","󰲧","󰲩","󰲫","󰲭","󰲯","󰲱","󰿭"'
  set -l active_icons '"󰲠","󰲢","󰲤","󰲦","󰲨","󰲪","󰲬","󰲮","󰲰","󰿬"'
  niri msg --json event-stream 2>/dev/null | jq -c --unbuffered '
    select(has("WorkspacesChanged") or has("WorkspaceActivated"))
  ' | while read line
    niri msg --json workspaces 2>/dev/null | jq -c --unbuffered --argjson icons "[$icons]" --argjson active_icons "[$active_icons]" '
      group_by(.output)
      | map({key: (.[0].output // "unknown"),
             value: (sort_by(.idx)
                     | map(. as $w
                            | (if $w.is_active then $active_icons else $icons end)[$w.idx - 1]
                            | [$w.idx, ., (if $w.is_active then "active" else "created" end)]))})
      | from_entries
    '
  end
end
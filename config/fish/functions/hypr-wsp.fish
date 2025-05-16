function hypr-wsp
  if test "$argv[1]" = "available"
    available-workspaces
  else if test "$argv[1]" = "active"
    active-workspaces
  end
end


function available-workspaces
  set -l num2icon "󰲠" "󰲢" "󰲤" "󰲦" "󰲨" "󰲪" "󰲬" "󰲮" "󰲰" "󰿬"
  set -l workspaces (hyprctl workspaces -j | jq 'sort_by(.id) | group_by(.monitor) | map({ key: .[0].monitor, value: map(.id) }) | from_entries')
  echo $workspaces
  # echo $workspaces | jq '
  #   with_entries(
  #     .value |= map(
  #       if . == 1 then "󰲠"
  #       elif . == 2 then "󰲢"
  #       elif . == 3 then "󰲤"
  #       elif . == 4 then "󰲦"
  #       elif . == 5 then "󰲨"
  #       elif . == 6 then "󰲪"
  #       elif . == 7 then "󰲬"
  #       elif . == 8 then "󰲮"
  #       elif . == 9 then "󰲰"
  #       elif . == 10 then "󰿬"
  #       else "0"
  #       end
  #     )
  #   )
  # '
end

function active-workspaces
  set -l workspace (hyprctl activeworkspace -j | jq '.id')
  echo $workspace
end
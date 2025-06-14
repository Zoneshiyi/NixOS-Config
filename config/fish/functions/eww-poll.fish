function eww-poll
  switch $argv[1]
    case "once"
      poll-once
    case "5s"
      poll-5s
    case "apps"
      apps-name2icon
  end
end

function poll-once
  echo -n "["
  if test (pgrep hyprsunset)
    echo -n '"󱩌"'
  else
    echo -n '"󱩍"'
  end

  if test (dunstctl is-paused | rg -F "false")
    echo -n ',"󰂛"'
  else
    echo -n ',"󰂚"'
  end
  # set -l theme (theme-choose check)
  # eww update theme=$theme
  echo -n "]"
end

function poll-5s

  set -l hour (date +%H)
  set -l minute (date +%M)
  set -l weekday (date +%a)
  set -l month (date +%m)
  set -l day (date +%d)

  echo -n "{\"hour\":\"$hour\",\"minute\":\"$minute\",\"weekday\":\"$weekday\",\"month\":\"$month\",\"day\":\"$day\"}"
end

function apps-name2icon
  xdg-list | cut -d ":" -f 1 | while read name
    set -l icon (cat $(xdg-which $name) | rg -F -m 1 "Icon=" | cut -d "=" -f 2)
    if test -z $icon
      set icon "default-application"
    end
    echo "{\"$name\":\"$icon\"}"
  end | jq -s -c 'add'
end
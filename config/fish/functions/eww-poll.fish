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
  echo -n "{"

  set -l hour (date +%H)
  set -l minute (date +%M)
  set -l weekday (date +%a)
  set -l month (date +%m)
  set -l day (date +%d)

  echo -n "\"hour\": \"$hour\","
  echo -n "\"minute\": \"$minute\","
  echo -n "\"weekday\": \"$weekday\","
  echo -n "\"month\": \"$month\","
  echo -n "\"day\": \"$day\""

  echo -n "}"
end

function apps-name2icon
  xdg-list | cut -d ":" -f 1 | while read name
    set -l icon (cat $(xdg-which $name) | rg -F -m 1 "Icon=" | cut -d "=" -f 2)
    echo -n "{"
    echo -n "\"$name\""
    echo -n ": "
    if test -z $icon
      echo -n "\"default-application\""
    else
      echo -n "\"$icon\""
    end
    echo -n "}"
  end | jq -s -c 'add'
end
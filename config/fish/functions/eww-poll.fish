function eww-poll
  if test $argv[1] = "once"
    poll-once
  else if test $argv[1] = "5s"
    poll-5s
  else if test $argv[1] = "apps"
    apps-name2icon
  end
end

function poll-once
  if test (pgrep hyprsunset)
    echo -n "󱩌"
  else
    echo -n "󱩍"
  end

  # set -l theme (theme-choose check)
  # eww update theme=$theme
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
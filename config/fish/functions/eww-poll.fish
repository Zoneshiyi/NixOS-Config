function eww-poll
  if test $argv[1] = "once"
    poll-once
  else if test $argv[1] = "5s"
    poll-5s
  end
end

function poll-once
  echo -n "{"

  set -l theme (theme-choose check)

  echo -n "\"theme\": \"$theme\","
  if test (pgrep hyprsunset)
    echo -n "\"nightmode\": \"󱩌\""
  else
    echo -n "\"nightmode\": \"󱩍\""
  end

  echo -n "}"
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
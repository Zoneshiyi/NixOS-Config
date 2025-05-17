function eww-poll
  if test $argv[1] = "once"
    poll-once
  else if test $argv[1] = "5s"
    poll-5s
  end
end

function poll-once
  echo "{"

  set -l theme (theme-choose check)
  echo "\"theme\": \"$theme\","

  if test (pgrep hyprsunset)
    echo "\"nightmode\": \"󱩌\""
  else
    echo "\"nightmode\": \"󱩍\""
  end

  echo "}"
end

function poll-5s
  echo "{"

  set -l time (date +%H:%M)
  set -l weekday (date +%A)
  set -l date (date +%m-%d)

  echo "\"time\": \"$time\","
  echo "\"weekday\": \"$weekday\","
  echo "\"date\": \"$date\""

  echo "}"
end
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

  set -l time (date +%H:%M)
  set -l weekday (date +%A)
  set -l date (date +%m-%d)

  echo -n "\"time\": \"$time\","
  echo -n "\"weekday\": \"$weekday\","
  echo -n "\"date\": \"$date\""

  echo -n "}"
end
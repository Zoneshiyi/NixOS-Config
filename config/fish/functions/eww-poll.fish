function eww-poll
  if test $argv[1] = "once"
    poll-once
  else if test $argv[1] = "1s"
    poll-1s
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

function poll-1s
  echo "{"

  set -l volume (wpctl get-volume @DEFAULT_AUDIO_SINK@)
  set -l muted (echo $volume | cut -d ' ' -f 3)
  set -l volume (math "$(echo $volume | cut -d ' ' -f 2) * 100")
  echo "\"volume\": \"$volume\","
  if test -z $muted
    echo "\"icon\": \"\""
  else
    echo "\"icon\": \"󰖁\""
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
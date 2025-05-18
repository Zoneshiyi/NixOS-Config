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

function poll-1s
  echo -n "{"

  set -l volume (wpctl get-volume @DEFAULT_AUDIO_SINK@)
  set -l muted (echo $volume | cut -d ' ' -f 3)
  set -l volume (math "$(echo $volume | cut -d ' ' -f 2) * 100")
  echo -n "\"volume\": [ \"$volume\","
  if test -z $muted
    echo -n "\"\"]"
  else
    echo -n "\"\"]"
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
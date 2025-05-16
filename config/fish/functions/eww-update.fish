function eww-update
  set -l volume (wpctl get-volume @DEFAULT_AUDIO_SINK@ | cut -d ' ' -f 2)
  eww update volume=$volume
  set -l theme (theme-choose check)
  eww update theme=$theme
end
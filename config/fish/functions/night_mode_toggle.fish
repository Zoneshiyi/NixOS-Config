function night_mode_toggle
    set target_process hyprsunset

    if pgrep $target_process >/dev/null
        pkill -RTMIN+9 waybar
        pkill $target_process;
    else
        pkill -RTMIN+9 waybar
        hyprsunset
    end
end

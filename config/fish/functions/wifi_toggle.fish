function wifi_toggle
    set wifi_status (rfkill list wifi | grep -i -o "Soft blocked: yes")
    if [ -z "$wifi_status" ]
        rfkill block wifi
    else
        rfkill unblock wifi
    end
end

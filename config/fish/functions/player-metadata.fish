function player-metadata
    playerctl -a metadata --format "{\"title\": \"{{title}}\",\"artist\": \"{{artist}}\", \"status\": \"{{status}}\"}" -F
end
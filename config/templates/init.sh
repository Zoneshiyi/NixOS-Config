srcDir="/home/zone/NixOS/config/templates"
dstDir="$HOME/.config/templates"

owner=$(id -un)
group=$(id -gn)
dirPerms="755"
filePerms="644"

if [ ! -d "$dstDir" ]; then
  install -d -o "$owner" -g "$group" -m "$dirPerms" "$dstDir"
fi

files=("hyprland.conf")
dirs=("fish" "kitty")

for file in "${files[@]}"; do
  if [ ! -f "$dstDir/$file" ]; then
    install -D -o "$owner" -g "$group" -m "$filePerms" "$srcDir/$file" "$dstDir/$file"
  fi
done

for dir in "${dirs[@]}"; do
  if [ ! -d "$dstDir/$dir" ]; then
    cp -r "$srcDir/$dir" "$dstDir"
    chown -R "$owner:$group" "$dstDir/$dir"
    find "$dstDir/$dir" -type d -print0 | xargs -0 chmod "$dirPerms"
    find "$dstDir/$dir" -type f -print0 | xargs -0 chmod "$filePerms"
  fi
done

if [ ! -d "/etc/firewalld" ]; then
  cp -r "$srcDir/firewalld" "/etc"
  chown -R "root:root" "/etc/firewalld"
  find "/etc/firewalld" -type d -print0 | xargs -0 chmod "$dirPerms"
  find "/etc/firewalld" -type f -print0 | xargs -0 chmod "$filePerms"
fi
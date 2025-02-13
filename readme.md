# Notes

## Fetchers

https://ryantm.github.io/nixpkgs/builders/fetchers/

# Issues

## Nvidia Flickering

https://github.com/hyprwm/Hyprland/issues/4857

https://discourse.nixos.org/t/hyprland-nvidia-4060-flickering-in-some-apps/47241

https://github.com/NixOS/nixpkgs/blob/nixpkgs-unstable/pkgs/os-specific/linux/nvidia-x11/default.nix

https://www.nvidia.com/en-us/drivers/unix/

**Solutions:**

- 通过`--disable-gpu-compositing`选项禁用 GPU 加速

## Usb bluetooth in Driver CDROM Mode
`sudo usb_modeswitch -v 0x0bda -p 0x1a2b -KW`

## wrong ownership on runtime directory /run/user/
`XDG_RUNTIME_DIR=/run/user/1000`

## 识别不到wifi设备
手动编译正确的驱动
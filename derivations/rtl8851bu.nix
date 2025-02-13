{ lib
, stdenv
, fetchFromGitHub
, kernel
, bc
, nukeReferences
,
}:

stdenv.mkDerivation rec {
  pname = "rtl8831";
  version = "${kernel.version}-unstable-2025-01-04";

  src = fetchFromGitHub {
    owner = "shenmintao";
    repo = pname;
    rev = "45f8ed2510d4dcbc535ec02acc9cfc048530d1e7";
    hash = "sha256-opiwyQr2ZvwLsytypb1FH1HcNxGKxxOV0Xvd+lK2Zp0=";
  };

  nativeBuildInputs = [
    bc
    nukeReferences
  ] ++ kernel.moduleBuildDependencies;
  hardeningDisable = [
    "pic"
    "format"
  ];

  postPatch = ''
    substituteInPlace ./Makefile \
      --replace-fail /sbin/depmod \# \
      --replace-fail '$(MODDESTDIR)' "$out/lib/modules/${kernel.modDirVersion}/kernel/net/wireless/"
    substituteInPlace ./platform/i386_pc.mk \
      --replace-fail /lib/modules "${kernel.dev}/lib/modules"
  '';

  makeFlags =
    [
      "ARCH=${stdenv.hostPlatform.linuxArch}"
      ("CONFIG_PLATFORM_I386_PC=" + (if stdenv.hostPlatform.isx86 then "y" else "n"))
      ("CONFIG_PLATFORM_ARM_RPI=" + (if stdenv.hostPlatform.isAarch then "y" else "n"))
    ]
    ++ lib.optionals (stdenv.hostPlatform != stdenv.buildPlatform) [
      "CROSS_COMPILE=${stdenv.cc.targetPrefix}"
    ];

  preInstall = ''
    mkdir -p "$out/lib/modules/${kernel.modDirVersion}/kernel/net/wireless/"
    mkdir -p "$out/usr/lib/systemd/system-sleep"
  '';

  postInstall = ''
    nuke-refs $out/lib/modules/*/kernel/net/wireless/*.ko
  '';

  enableParallelBuilding = true;

  meta = with lib; {
    description = "Driver for Realtek rtl8851bu";
    homepage = "https://github.com/shenmintao/rtl8831";
    # license = licenses.gpl2Only;
    platforms = platforms.linux;
    # maintainers = with maintainers; [ lonyelon ];
  };
}

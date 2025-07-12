import 'package:wlist_site/models/platform_info.dart';

PlatformInfo getPlatformInfo(Platform platform) => switch (platform) {
  Platform.android => const PlatformInfo(
    name: 'Android',
    version: '1.0.0',
    downloadUrl: [],
  ),
  Platform.windows => const PlatformInfo(
    name: 'Windows',
    version: '1.0.1',
    downloadUrl: [
      ('exe', 'https://github.com/wlist-org/wlist-releases/releases/download/1.0.1/wlist_ui-1.0.1-windows-x86_64.exe'),
      ('msix', 'https://github.com/wlist-org/wlist-releases/releases/download/1.0.1/wlist_ui-1.0.1-windows-x86_64.msix'),
      ('zip', 'https://github.com/wlist-org/wlist-releases/releases/download/1.0.1/wlist_ui-1.0.1-windows-x86_64.zip'),
    ],
  ),
  Platform.macos => const PlatformInfo(
    name: 'MacOS',
    version: '1.0.1',
    downloadUrl: [
      ('dmg', 'https://github.com/wlist-org/wlist-releases/releases/download/1.0.1/wlist_ui-1.0.1-macos.dmg'),
      ('pkg', 'https://github.com/wlist-org/wlist-releases/releases/download/1.0.1/wlist_ui-1.0.1-macos.pkg'),
      ('zip', 'https://github.com/wlist-org/wlist-releases/releases/download/1.0.1/wlist_ui-1.0.1-macos.zip'),
    ],
  ),
  Platform.ios => const PlatformInfo(
    name: 'IOS',
    version: '1.0.0',
    downloadUrl: [],
  ),
  Platform.linux => const PlatformInfo(
    name: 'Linux',
    version: '1.0.1',
    downloadUrl: [
      ('deb', 'https://github.com/wlist-org/wlist-releases/releases/download/1.0.1/wlist_ui-1.0.1-linux-x86_64.deb'),
      ('rpm', 'https://github.com/wlist-org/wlist-releases/releases/download/1.0.1/wlist_ui-1.0.1-linux-x86_64.rpm'),
      ('zip', 'https://github.com/wlist-org/wlist-releases/releases/download/1.0.1/wlist_ui-1.0.1-linux-x86_64.zip'),
    ],
  ),
};

String getLatestInternalVersion() => "0.4.0";

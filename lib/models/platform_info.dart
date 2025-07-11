import 'dart:io' as io;
import 'dart:ui_web' as web;

import 'package:flutter/foundation.dart';

enum Platform {
  android,
  windows,
  macos,
  ios,
  linux,
}

Platform getSatisfiedPlatform() {
  Platform? platform;
  if (kIsWeb) {
    switch (web.browser.operatingSystem) {
      case web.OperatingSystem.iOs:
        platform = Platform.ios;
        break;
      case web.OperatingSystem.android:
        platform = Platform.android;
        break;
      case web.OperatingSystem.linux:
        platform = Platform.linux;
        break;
      case web.OperatingSystem.windows:
        platform = Platform.windows;
        break;
      case web.OperatingSystem.macOs:
        platform = Platform.macos;
        break;
      case web.OperatingSystem.unknown:
        break;
    }
  } else if (io.Platform.isAndroid) {
    platform = Platform.android;
  } else if (io.Platform.isWindows) {
    platform = Platform.windows;
  } else if (io.Platform.isMacOS) {
    platform = Platform.macos;
  } else if (io.Platform.isIOS) {
    platform = Platform.ios;
  } else if (io.Platform.isLinux) {
    platform = Platform.linux;
  }
  return platform ?? Platform.windows;
}

class PlatformInfo {
  final String name;
  final String version;
  final List<(String, String)> downloadUrl;

  const PlatformInfo._({
    required this.name,
    required this.version,
    required this.downloadUrl,
  });
}

PlatformInfo getPlatformInfo(Platform platform) => switch (platform) {
  Platform.android => const PlatformInfo._(
    name: 'Android',
    version: '1.0.0',
    downloadUrl: [],
  ),
  Platform.windows => const PlatformInfo._(
    name: 'Windows',
    version: '1.0.1',
    downloadUrl: [
      ('exe', 'https://github.com/wlist-org/wlist-releases/releases/download/1.0.1/wlist_ui-1.0.1-windows-x86_64.exe'),
      ('msix', 'https://github.com/wlist-org/wlist-releases/releases/download/1.0.1/wlist_ui-1.0.1-windows-x86_64.msix'),
      ('zip', 'https://github.com/wlist-org/wlist-releases/releases/download/1.0.1/wlist_ui-1.0.1-windows-x86_64.zip'),
    ],
  ),
  Platform.macos => const PlatformInfo._(
    name: 'MacOS',
    version: '1.0.1',
    downloadUrl: [
      ('dmg', 'https://github.com/wlist-org/wlist-releases/releases/download/1.0.1/wlist_ui-1.0.1-macos.dmg'),
      ('pkg', 'https://github.com/wlist-org/wlist-releases/releases/download/1.0.1/wlist_ui-1.0.1-macos.pkg'),
      ('zip', 'https://github.com/wlist-org/wlist-releases/releases/download/1.0.1/wlist_ui-1.0.1-macos.zip'),
    ],
  ),
  Platform.ios => const PlatformInfo._(
    name: 'IOS',
    version: '1.0.0',
    downloadUrl: [],
  ),
  Platform.linux => const PlatformInfo._(
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

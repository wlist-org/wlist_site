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
  final String downloadUrl;

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
    downloadUrl: '',
  ),
  Platform.windows => const PlatformInfo._(
    name: 'Windows',
    version: '1.0.0',
    downloadUrl: '',
  ),
  Platform.macos => const PlatformInfo._(
    name: 'MacOS',
    version: '1.0.0',
    downloadUrl: '',
  ),
  Platform.ios => const PlatformInfo._(
    name: 'IOS',
    version: '1.0.0',
    downloadUrl: '',
  ),
  Platform.linux => const PlatformInfo._(
    name: 'Linux',
    version: '1.0.0',
    downloadUrl: '',
  ),
};

String getLatestInternalVersion() => "0.4.0";

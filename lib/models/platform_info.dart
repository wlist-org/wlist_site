import 'dart:io' as io;
import 'dart:ui_web' as web;

import 'package:flutter/foundation.dart';
import 'package:wlist_site/models/platform_info_detail.dart' deferred as detail;

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

  const PlatformInfo({
    required this.name,
    required this.version,
    required this.downloadUrl,
  });
}

Future<void> initializePlatformInfo() async {
  await detail.loadLibrary();
}

PlatformInfo getPlatformInfo(Platform platform) {
  return detail.getPlatformInfo(platform);
}

String getLatestInternalVersion() {
  return detail.getLatestInternalVersion();
}

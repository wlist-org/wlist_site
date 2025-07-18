import 'dart:convert';
import 'dart:io' as io;
import 'dart:ui_web' as web;

import 'package:flutter/foundation.dart';
import 'package:http/browser_client.dart';
import 'package:http/io_client.dart';

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

String _latestVersion = "";
Map<Platform, PlatformInfo> _infos = {};

Future<void> initializePlatformInfo() async {
  assert (kIsWeb);
  final url = 'latest_info.json?t=${DateTime.now().millisecondsSinceEpoch}';
  final response = await BrowserClient().get(Uri.parse(url));
  if (response.statusCode != 200) {
    throw Exception('Unable to get version info. ${response.statusCode} [${response.reasonPhrase}]');
  }
  final json = jsonDecode(response.body);
  _latestVersion = json['latestInternalVersion'];
  for (final (key, platform) in [
    ('android', Platform.android),
    ('windows', Platform.windows),
    ('macos', Platform.macos),
    ('ios', Platform.ios),
    ('linux', Platform.linux),
  ]) {
    final info = json['platforms'][key];
    _infos[platform] = PlatformInfo(
      name: info['name'],
      version: info['version'],
      downloadUrl: [
        for (final url in info['downloadUrl'])
          (url['type'], url['url']),
      ]
    );
  }
}

PlatformInfo getPlatformInfo(Platform platform) {
  return _infos[platform]!;
}

String getLatestInternalVersion() {
  return _latestVersion;
}

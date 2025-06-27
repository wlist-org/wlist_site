import 'package:wlist_site/models/platform_info.dart';

class Assets {
  static const logo = 'assets/logo.svg';

}

extension PlatformInfoSvgAssets on Platform {
  String get logo => switch (this) {
    Platform.android => 'assets/platforms/android.svg',
    Platform.windows => 'assets/platforms/windows.svg',
    Platform.macos => 'assets/platforms/macos.svg',
    Platform.ios => 'assets/platforms/ios.svg',
    Platform.linux => 'assets/platforms/linux.svg',
  };
}

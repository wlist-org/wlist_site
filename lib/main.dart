import 'package:flutter/material.dart';
import 'package:wlist_site/app.dart';
import 'package:wlist_site/models/platform_info.dart';

void main() async {
  await initializePlatformInfo();
  runApp(App());
}

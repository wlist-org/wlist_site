import 'package:flutter/material.dart';
import 'package:wlist_site/app.dart' deferred as app;
import 'package:wlist_site/models/platform_info.dart';

void main() async {
  await Future.wait([
    app.loadLibrary(),
    initializePlatformInfo(),
  ]);
  runApp(app.App());
}

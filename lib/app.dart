import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:wlist_site/generated/l10n.dart';
import 'package:wlist_site/pages/main_page.dart';
import 'package:wlist_site/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: CustomColors.primaryBlue,
            brightness: MediaQuery.platformBrightnessOf(context),
          ),
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.white,
        ),
        localizationsDelegates: const [
          S.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        onGenerateTitle: (context) => S.of(context).title,
        home: const MainPage(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:wlist_site/utils/background.dart';
import 'package:wlist_site/utils/gap.dart';
import 'package:wlist_site/widgets/app_description.dart';
import 'package:wlist_site/widgets/download_section.dart';
import 'package:wlist_site/widgets/footer.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SizedBox.expand(
        child: Stack(
          children: [
            BackgroundWithBubbles(),
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppDescription(),
                    Gap.v(40),
                    DownloadSection(),
                    Gap.v(40),
                    Footer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

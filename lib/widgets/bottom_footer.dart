import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:wlist_site/theme.dart';
import 'package:wlist_site/utils/gap.dart';

class BottomFooter extends StatelessWidget {
  const BottomFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '当前版本：0.3.0',
            style: mergeTextStyleColor(
              Theme.of(context).textTheme.bodySmall,
              CustomColors.lightGray,
            ),
          ),

          const Gap.h(24),

          InkWell(
            onTap: () => launchUrlString("https://beian.miit.gov.cn"),
            borderRadius: BorderRadius.circular(4),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                '浙ICP备 2024126116号',
                style: mergeTextStyleColor(
                  Theme.of(context).textTheme.bodySmall,
                  CustomColors.lightGray,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

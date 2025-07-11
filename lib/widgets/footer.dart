import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:wlist_site/generated/l10n.dart';
import 'package:wlist_site/models/platform_info.dart';
import 'package:wlist_site/theme.dart';
import 'package:wlist_site/utils/gap.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  void _onUserAgreement() {
    // TODO
  }

  void _onPrivacyPolicy() {
    // TODO
  }

  void _onContactUs() {
    launchUrlString("https://github.com/wlist-org/wlist-issue-collector/issues/new");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLink(context, S.of(context).footer_user_agreement, _onUserAgreement),
            _buildSplit(context),
            _buildLink(context, S.of(context).footer_privacy_policy, _onPrivacyPolicy),
            _buildSplit(context),
            _buildLink(context, S.of(context).footer_contact_us, _onContactUs),
          ],
        ),

        const Gap.v(40),

        SizedBox(
          width: double.infinity,
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                S.of(context).latest_internal_version(getLatestInternalVersion()),
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
        ),
      ],
    );
  }

  Widget _buildSplit(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        '|',
        style: TextStyle(
          color: CustomColors.lightGray,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildLink(BuildContext context, String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      hoverColor: CustomColors.lightGray.withValues(alpha: 0.1),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(
          text,
          style: mergeTextStyleColor(
            Theme.of(context).textTheme.bodyMedium,
            CustomColors.lightGray,
            // ).copyWith(
            //   decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:wlist_site/generated/l10n.dart';
import 'package:wlist_site/theme.dart';

class LinkFooter extends StatelessWidget {
  const LinkFooter({super.key});

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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLink(context, S.of(context).footer_user_agreement, _onUserAgreement),
        _buildSplit(context),
        _buildLink(context, S.of(context).footer_privacy_policy, _onPrivacyPolicy),
        _buildSplit(context),
        _buildLink(context, S.of(context).footer_contact_us, _onContactUs),
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

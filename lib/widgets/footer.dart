import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:wlist_site/generated/l10n.dart';
import 'package:wlist_site/models/platform_info.dart';
import 'package:wlist_site/theme.dart';
import 'package:wlist_site/utils/gap.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  void _onUserAgreement(BuildContext context) {
    _onDialog(context, S.of(context).footer_user_agreement, S.of(context).user_agreement_file);
  }

  void _onPrivacyPolicy(BuildContext context) {
    _onDialog(context, S.of(context).footer_privacy_policy, S.of(context).privacy_policy_file);
  }

  void _onContactUs() {
    launchUrlString("mailto:mail@wlist.top");
  }

  void _onDialog(BuildContext context, String title, String contentPath) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.6,
          height: MediaQuery.sizeOf(context).height * 0.6,
          child: FutureBuilder(
            future: rootBundle.loadString(contentPath),
            builder: (context, state) {
              if (state.hasData) {
                return Markdown(
                  data: state.data!,
                  selectable: true,
                  onTapLink: (text, href, title) => launchUrlString(href ?? text),
                );
              }
              if (state.hasError) {
                return Center(
                  child: Text(
                    state.error.toString(),
                  ),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(S.of(context).confirm),
          ),
        ],
      ),
    );
  }

  void _onLatestInternalVersion() {
    launchUrlString("https://github.com/wlist-org/wlist-releases/releases");
  }

  void _onBeiAn() {
    launchUrlString("https://beian.miit.gov.cn");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLink(context, S.of(context).footer_user_agreement, () => _onUserAgreement(context)),
            _buildSplit(context),
            _buildLink(context, S.of(context).footer_privacy_policy, () => _onPrivacyPolicy(context)),
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
              _buildTapable(context, S.of(context).latest_internal_version(getLatestInternalVersion()), _onLatestInternalVersion),
              const Gap.h(24),
              _buildTapable(context, '浙ICP备 2024126116号', _onBeiAn),
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

  Widget _buildTapable(BuildContext context, String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(
          text,
          style: mergeTextStyleColor(
            Theme.of(context).textTheme.bodySmall,
            CustomColors.lightGray,
          ),
        ),
      ),
    );
  }
}

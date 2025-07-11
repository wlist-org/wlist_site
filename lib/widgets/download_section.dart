import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:wlist_site/assets.dart';
import 'package:wlist_site/generated/l10n.dart';
import 'package:wlist_site/models/platform_info.dart';
import 'package:wlist_site/theme.dart';
import 'package:wlist_site/utils/gap.dart';

class DownloadSection extends StatefulWidget {
  const DownloadSection({super.key});

  @override
  State<DownloadSection> createState() => _DownloadSectionState();
}

class _DownloadSectionState extends State<DownloadSection> {
  Platform selectedPlatform = getSatisfiedPlatform();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.sizeOf(context).width * 0.05,
      ),
      child: Column(
        children: [
          _PlatformChooser(
            selectedPlatform: selectedPlatform,
            onPlatformSelected: (platform) => setState(() => selectedPlatform = platform),
          ),

          const Gap.v(32),

          _PlatformInfoBox(
            key: ValueKey(selectedPlatform),
            platform: selectedPlatform,
          ),
        ],
      ),
    );
  }
}


class _PlatformChooser extends StatefulWidget {
  final Platform selectedPlatform;
  final Function(Platform) onPlatformSelected;

  const _PlatformChooser({
    required this.selectedPlatform,
    required this.onPlatformSelected,
  });

  @override
  State<_PlatformChooser> createState() => _PlatformChooserState();
}

class _PlatformChooserState extends State<_PlatformChooser> {
  Platform? hoveredPlatform;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final height = min(size.height * 0.1, 120.0);
    final width = min(size.width * 0.1, 120.0);
    final square = min(height, width);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: Platform.values.map((platform) {
        final info = getPlatformInfo(platform);
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GestureDetector(
              onTap: () => widget.onPlatformSelected(platform),
              child: MouseRegion(
                onEnter: (_) => setState(() => hoveredPlatform = platform),
                onExit: (_) => setState(() => hoveredPlatform = null),
                child: Column(
                  children: [
                    Container(
                      width: square,
                      height: square,
                      decoration: BoxDecoration(
                        color: widget.selectedPlatform == platform
                          ? CustomColors.primaryBlue
                          : hoveredPlatform == platform
                            ? CustomColors.hoverBlue
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        border: widget.selectedPlatform != platform && hoveredPlatform != platform
                          ? Border.all(
                            color: Colors.grey,
                            width: 1,
                          )
                          : null,
                      ),
                      child: FractionallySizedBox(
                        widthFactor: 0.5,
                        child: SvgPicture.asset(
                          platform.logo,
                          fit: BoxFit.scaleDown,
                          colorFilter: ColorFilter.mode(
                            widget.selectedPlatform == platform || hoveredPlatform == platform
                              ? Colors.white
                              : CustomColors.textGray,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),

                    const Gap.v(12),

                    Text(
                      info.name,
                      style: mergeTextStyleColor(
                        Theme.of(context).textTheme.labelLarge,
                        widget.selectedPlatform == platform
                          ? CustomColors.primaryBlue
                          : CustomColors.darkText,
                      ).copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(growable: false),
    );
  }
}


class _PlatformInfoBox extends StatelessWidget {
  final Platform platform;
  final PlatformInfo info;

  _PlatformInfoBox({
    super.key,
    required this.platform,
  }): info = getPlatformInfo(platform);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: MediaQuery.sizeOf(context).aspectRatio > 1
        ? Row(
          children: [
            Expanded(
              flex: 2,
              child: _buildInfo(context),
            ),
            const Gap.h(40),
            Expanded(
              flex: 1,
              child: _buildDownload(context),
            ),
          ],
        )
        : Column(
          children: [
            _buildInfo(context),
            const Gap.v(40),
            _buildDownload(context),
          ],
        ),
    );
  }

  Widget _buildInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          S.of(context).platform_download(info.name),
          style: mergeTextStyleColor(
            Theme.of(context).textTheme.headlineMedium,
            CustomColors.darkText,
          ).copyWith(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),

        const Gap.v(16),

        Text(
          S.of(context).platform_download_version(info.version),
          style: mergeTextStyleColor(
            Theme.of(context).textTheme.bodyLarge,
            CustomColors.textGray,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildDownload(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: info.downloadUrl.isEmpty
        ? [
          _buildButton(context, null, null),
        ]
        : [
          for (final (suffix, url) in info.downloadUrl)
            _buildButton(context, suffix, url)
        ],
    );
  }

  Widget _buildButton(BuildContext context, String? suffix, String? url) {
    return FractionallySizedBox(
      widthFactor: 0.6,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: ElevatedButton(
          onPressed: () { if (url != null) launchUrlString(url); },
          style: ElevatedButton.styleFrom(
            backgroundColor: CustomColors.buttonBlue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 16,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 2,
            overlayColor: CustomColors.buttonHoverBlue.withValues(alpha: 0.1),
          ),
          child: Text(
            suffix == null
              ? S.of(context).platform_download_in_beta
              : S.of(context).platform_download_now(suffix),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

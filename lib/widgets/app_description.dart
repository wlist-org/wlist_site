import 'package:flutter/material.dart';
import 'package:wlist_site/generated/l10n.dart';
import 'package:wlist_site/theme.dart';
import 'package:wlist_site/utils/gap.dart';
import 'package:wlist_site/utils/logo.dart';

class AppDescription extends StatelessWidget {
  const AppDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          flex: 2,
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: CustomColors.primaryBlue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Logo(),
          ),
        ),
        
        const Gap.h(40),

        Flexible(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                S.of(context).title,
                style: mergeTextStyleColor(
                  Theme.of(context).textTheme.headlineLarge,
                  CustomColors.darkText,
                ).copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              const Gap.v(16),
              
              Text(
                S.of(context).description,
                style: mergeTextStyleColor(
                  Theme.of(context).textTheme.titleLarge,
                  CustomColors.textGray,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

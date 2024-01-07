import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vpm/app/extensions/space.dart';
import 'package:vpm/app/util/constants.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_text.dart';

class SocialButton extends StatelessWidget {
  final String svgName;
  final String text;
  final VoidCallback onTap;

  const SocialButton({
    super.key,
    required this.svgName,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 36),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kRadius),
        border: Border.all(
          color: Theme.of(context).dividerColor,
          width: 1,
        ),
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24),
        child: Row(
          children: [
            SvgPicture.asset(svgName),
            20.pw,
            AppText(
              text,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ],
        ),
      ),
    );
  }
}

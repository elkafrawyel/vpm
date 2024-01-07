import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vpm/app/extensions/space.dart';

import '../../../app/config/app_color.dart';
import '../../../app/res/res.dart';
import '../app_widgets/app_text.dart';

class ApiEmptyView extends StatelessWidget {
  final String emptyText;
  final Function()? retry;

  const ApiEmptyView({Key? key, required this.emptyText, this.retry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(Res.animApiEmpty),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: AppText(
                  emptyText,
                  color: hintColor,
                  fontSize: 18,
                  maxLines: 3,
                  centerText: true,
                ),
              ),
            ),
            30.ph,
            ElevatedButton(
              onPressed: retry,
              style: ElevatedButton.styleFrom(
                backgroundColor: hintColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 48.0, vertical: 12.0),
                child: AppText('Try Again'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

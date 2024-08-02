import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_text.dart';

void scaleDialog({
  required BuildContext context,
  required Widget content,
  String? title,
  String? confirmText,
  String? cancelText,
  VoidCallback? onConfirmClick,
  VoidCallback? onCancelClick,
  bool barrierDismissible = false,
  Color? backgroundColor,
  double? height,
  double radius = 12.0,
  EdgeInsets contentPadding = const EdgeInsets.all(12.0),
  int animationDuration = 400,
  EdgeInsets insetPadding = const EdgeInsets.symmetric(
    horizontal: 12.0,
    vertical: 12.0,
  ),
}) {
  showGeneralDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierLabel: 'dialog',
    pageBuilder: (ctx, a1, a2) => Container(),
    transitionDuration: Duration(milliseconds: animationDuration),
    transitionBuilder: (ctx, a1, a2, child) {
      var curve = Curves.easeInOut.transform(a1.value);
      return Transform.scale(
        scale: curve,
        child: AlertDialog(
          backgroundColor:
              backgroundColor ?? Theme.of(ctx).scaffoldBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          insetPadding: insetPadding,
          contentPadding: contentPadding,
          actions: onConfirmClick == null && onCancelClick == null
              ? null
              : <Widget>[
                  Offstage(
                    offstage: onConfirmClick == null,
                    child: TextButton(
                      onPressed: () => onConfirmClick,
                      child: Text(
                        confirmText ?? "Confirm",
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Offstage(
                    offstage: onCancelClick == null,
                    child: TextButton(
                      onPressed: Get.back,
                      child: Text(
                        cancelText ?? "Cancel",
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  )
                ],
          content: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                color: backgroundColor ?? Theme.of(ctx).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(radius),
              ),
              padding: EdgeInsets.zero,
              height: height,
              width: MediaQuery.of(ctx).size.width,
              child: content,
            ),
          ),
        ),
      );
    },
  );
}

void scaleAlertDialog({
  required BuildContext context,
  required String title,
  required String body,
  String? confirmText,
  String? cancelText,
  VoidCallback? onConfirmClick,
  VoidCallback? onCancelClick,
  bool barrierDismissible = false,
  int animationDuration = 400,
}) {
  showGeneralDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierLabel: title,
    pageBuilder: (ctx, a1, a2) => Container(),
    transitionDuration: Duration(milliseconds: animationDuration),
    transitionBuilder: (ctx, a1, a2, child) {
      var curve = Curves.easeInOut.transform(a1.value);
      return Transform.scale(
        scale: curve,
        child: GetPlatform.isIOS
            ? CupertinoAlertDialog(
                title: AppText(
                  title,
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                ),
                content: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppText(
                    body,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                actions: [
                  if (onConfirmClick != null)
                    TextButton(
                      onPressed: onConfirmClick,
                      child: Text(
                        confirmText ?? "Confirm",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  if (onCancelClick != null)
                    TextButton(
                      onPressed: onCancelClick,
                      child: Text(
                        cancelText ?? "Cancel",
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                ],
              )
            : AlertDialog(
                title: AppText(
                  title,
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                ),
                content: AppText(
                  body,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
                backgroundColor: Theme.of(ctx).scaffoldBackgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                actions: <Widget>[
                  if (onConfirmClick != null)
                    TextButton(
                      onPressed: onConfirmClick,
                      child: Text(
                        confirmText ?? "Confirm",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  if (onCancelClick != null)
                    TextButton(
                      onPressed: onCancelClick,
                      child: Text(
                        cancelText ?? "Cancel",
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    )
                ],
              ),
      );
    },
  );
}

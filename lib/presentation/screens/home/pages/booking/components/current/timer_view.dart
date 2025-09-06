import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:vpm/app/extensions/space.dart';
import 'package:vpm/app/util/util.dart';
import 'package:vpm/presentation/controller/booking_controller.dart';
import 'package:vpm/presentation/controller/home_screen_controller/home_screen_controller.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_text.dart';

import '../../../../../../../app/config/app_color.dart';
import '../../../../../../../app/res/res.dart';

class TimerView extends StatefulWidget {
  final String startTime;
  final num freeHours;
  final num perHour;

  const TimerView({
    super.key,
    required this.startTime,
    required this.freeHours,
    required this.perHour,
  });

  @override
  State<TimerView> createState() => _TimerViewState();
}

class _TimerViewState extends State<TimerView> {
  Timer? _timer;
  double totalCost = 0.0;

  String replaceFarsiNumber(String input) {
    if (Get.locale?.languageCode == "en") {
      return input;
    }
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const farsi = ['۰', '۱', '۲', '۳', '٤', '٥', '٦', '٧', '۸', '۹'];

    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(english[i], farsi[i]);
    }

    return input;
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        // if i leave the booking tab stop timer
        if (Get.find<HomeScreenController>().currentIndex.value == 1 &&
            Get.find<BookingController>().selectedIndex.value == 0) {
          Utils.logMessage('Timer view is active');
          setState(() {});
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    Color? textColor;

    DateTime a = DateTime.parse(widget.startTime);
    DateTime b = DateTime.now();

    Duration difference = b.difference(a);

    String days = difference.inDays == 0
        ? ''
        : difference.inDays.toString().padLeft(2, '0');
    String hours = (difference.inHours % 24).toString().padLeft(2, '0');
    String minutes = (difference.inMinutes % 60).toString().padLeft(2, '0');
    String seconds = (difference.inSeconds % 60).toString().padLeft(2, '0');

    if (widget.freeHours > 0 && difference.inMinutes < widget.freeHours * 60) {
      textColor = Colors.green;
      totalCost = 0.0;
    } else {
      textColor = Theme.of(context).primaryColor;
      totalCost =
          (((difference.inMinutes / 60) - widget.freeHours) * widget.perHour)
              .toDouble();
    }

    int totalHours = ((difference.inMinutes / 60) - widget.freeHours).ceil();

    totalHours = totalHours < 0 ? 0 : totalHours;
    String time =
        "${days.isEmpty ? '' : '${replaceFarsiNumber(days)} ${'day'.tr} ,'} ${replaceFarsiNumber(hours)} : ${replaceFarsiNumber(minutes)} : ${replaceFarsiNumber(seconds)}";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: AppText(
                'total_cost'.tr,
                color: hintColor,
              ),
            ),
            Expanded(
              flex: 2,
              child: AppText(
                totalCost == 0
                    ? 'free'.tr
                    : Utils().formatNumbers(
                        totalCost.toString(),
                      ),
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: totalCost == 0
                    ? Colors.green
                    : Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                Res.animClock,
                width: 30,
                height: 30,
              ),
              10.pw,
              AppText(
                time,
                fontSize: 28,
                color: textColor,
                maxLines: 2,
              ),
              // Row(
              //   children: [
              //     5.pw,
              //     AppText(
              //       '=',
              //       fontSize: 30,
              //       color: textColor,
              //     ),
              //     5.pw,
              //     AppText(
              //       replaceFarsiNumber(totalHours.toString()),
              //       color: textColor,
              //       fontSize: 24,
              //       fontWeight: FontWeight.bold,
              //     ),
              //     5.pw,
              //     AppText(
              //       'hours'.tr,
              //       color: textColor,
              //     )
              //   ],
              // ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:vpm/app/config/app_color.dart';
import 'package:vpm/app/res/res.dart';
import 'package:vpm/app/util/util.dart';
import 'package:vpm/data/providers/storage/local_provider.dart';
import 'package:vpm/presentation/controller/booking_controller/booking_controller.dart';
import 'package:vpm/presentation/controller/home_screen_controller/home_screen_controller.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_text.dart';

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

  String totalCost = '';

  Widget getTimerView() {
    Color textColor = Theme.of(context).primaryColor;

    DateTime a = DateTime.parse(widget.startTime);
    DateTime b = DateTime.now();

    Duration difference = b.difference(a);

    String days = difference.inDays == 0
        ? ''
        : difference.inDays.toString().padLeft(2, '0');
    String hours = (difference.inHours % 24).toString().padLeft(2, '0');
    String minutes = (difference.inMinutes % 60).toString().padLeft(2, '0');
    String seconds = (difference.inSeconds % 60).toString().padLeft(2, '0');

    if (difference.inHours % 24 <= widget.freeHours && widget.freeHours > 0) {
      textColor = Colors.green;
    }
    totalCost = (difference.inHours * widget.perHour).toString();
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: AppText(
        LocalProvider().isAr()
            ? "${days.isEmpty ? '' : '${replaceFarsiNumber(days)} :'} ${replaceFarsiNumber(hours)} : ${replaceFarsiNumber(minutes)} : ${replaceFarsiNumber(seconds)}"
            : "${days.isEmpty ? '' : '${(days)} ${'day'.tr},'} $hours : $minutes : $seconds",
        fontSize: 18,
        color: textColor,
        fontWeight: FontWeight.bold,
        maxLines: 2,
      ),
    );
  }

  String replaceFarsiNumber(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const farsi = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];

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
        if (Get.find<HomeScreenController>().selectedTabIndex == 3 &&
            Get.find<BookingController>().selectedIndex == 0) {
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
    return Column(
      children: [
        Row(
          children: [
            Lottie.asset(
              Res.animClock,
              width: 70,
              height: 70,
            ),
            Expanded(
              flex: 2,
              child: getTimerView(),
            ),
          ],
        ),
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
                Utils().formatNumbers(
                  totalCost,
                ),
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

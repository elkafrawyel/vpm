import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpm/app/types/booking_tabs_type.dart';
import 'package:vpm/app/util/constants.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_text.dart';

import '../../../../../app/types/booking_filter_type.dart';
import '../../../../controller/booking_controller/booking_controller.dart';
import '../../../../widgets/app_selector.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingController>(
      init: BookingController(),
      builder: (bookingController) => Scaffold(
        appBar: AppBar(
          title: Text('booking'.tr),
          actions: [
            TextButton(
              onPressed: () {
                showAppSelectorDialog<BookingFilterType>(
                  context: context,
                  items: BookingFilterType.values,
                  onItemSelected: (BookingFilterType bookingFilterType) {
                    bookingController.bookingFilterType = bookingFilterType;
                  },
                );
              },
              child: AppText(
                bookingController.bookingFilterType.title,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
        body: Row(
          children: BookingTabsType.values.map(
            (e) {
              bool selected = bookingController.selectedIndex ==
                  BookingTabsType.values.indexOf(e);
              return GestureDetector(
                onTap: () {
                  bookingController.selectedIndex =
                      BookingTabsType.values.indexOf(e);
                },
                child: Container(
                  width: 100,
                  height: 40,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: selected
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(kRadius),
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                      width: 2.0,
                    ),
                  ),
                  child: Center(
                    child: AppText(
                      e.title,
                      color: selected
                          ? Theme.of(context).scaffoldBackgroundColor
                          : Theme.of(context).primaryColor,
                      fontWeight: selected ? FontWeight.w700 : FontWeight.w300,
                    ),
                  ),
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}

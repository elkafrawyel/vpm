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
  final BookingController bookingController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingController>(
      builder: (_) => DefaultTabController(
        length: bookingController.pages.length,
        initialIndex: bookingController.selectedIndex,
        child: Scaffold(
          appBar: AppBar(
            title: Text('booking'.tr),
            actions: [
              GetBuilder<BookingController>(builder: (_) {
                return TextButton(
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
                );
              }),
            ],
            bottom: TabBar(
              tabAlignment: TabAlignment.center,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 1,
              indicatorColor: Colors.transparent,
              labelStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).primaryColor,
              ),
              onTap: (int index) {
                bookingController.selectedIndex = index;
              },
              tabs: BookingTabsType.values
                  .map(
                    (e) => Container(
                      decoration: BoxDecoration(
                        color: bookingController.selectedIndex ==
                                BookingTabsType.values.indexOf(e)
                            ? Theme.of(context).primaryColor
                            : Colors.white,
                        border: Border.all(
                            color: bookingController.selectedIndex ==
                                    BookingTabsType.values.indexOf(e)
                                ? Colors.transparent
                                : Theme.of(context).primaryColor,
                            width: 3),
                        borderRadius: BorderRadius.circular(kRadius),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Tab(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 18.0),
                            child: Text(
                              e.title,
                              style: TextStyle(
                                color: bookingController.selectedIndex ==
                                        BookingTabsType.values.indexOf(e)
                                    ? Colors.white
                                    : Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          body: bookingController.pages[bookingController.selectedIndex],
        ),
      ),
    );
  }
}

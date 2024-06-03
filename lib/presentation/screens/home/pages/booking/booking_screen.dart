import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpm/app/config/app_color.dart';
import 'package:vpm/app/types/booking_tabs_type.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_text.dart';

import '../../../../../app/types/booking_filter_type.dart';
import '../../../../controller/booking_controller.dart';
import '../../../../widgets/app_selector.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen>
    with AutomaticKeepAliveClientMixin {
  final BookingController bookingController = Get.find();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Obx(
      () => DefaultTabController(
        length: bookingController.pages.length,
        initialIndex: bookingController.selectedIndex.value,
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
                        bookingController.bookingFilterType.value =
                            bookingFilterType;
                      },
                    );
                  },
                  child: AppText(
                    bookingController.bookingFilterType.value.title,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).primaryColor,
                  ),
                );
              }),
            ],
            bottom: TabBar(
              tabAlignment: TabAlignment.fill,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 2,
              labelStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).primaryColor,
                  ),
              unselectedLabelStyle:
                  Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: hintColor,
                      ),
              onTap: (int index) {
                bookingController.selectedIndex.value = index;
              },
              tabs: BookingTabsType.values
                  .map(
                    (e) => Tab(
                      text: e.title,
                    ),
                  )
                  .toList(),
            ),
          ),
          body: bookingController.pages[bookingController.selectedIndex.value],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

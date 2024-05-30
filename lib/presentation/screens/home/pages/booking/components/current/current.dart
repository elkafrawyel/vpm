import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpm/app/extensions/space.dart';
import 'package:vpm/presentation/controller/booking_controller.dart';
import 'package:vpm/presentation/screens/home/pages/booking/components/current/current_card.dart';
import 'package:vpm/presentation/screens/home/pages/booking/components/current/current_shimmer_card.dart';
import 'package:vpm/presentation/widgets/api_state_views/handel_api_state.dart';
import 'package:vpm/presentation/widgets/api_state_views/pagination_view.dart';

import '../../../../../../widgets/app_widgets/app_text.dart';

class CurrentBooking extends StatelessWidget {
  const CurrentBooking({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingController>(
      builder: (bookingController) {
        return HandleApiState.controller(
          generalController: bookingController,
          shimmerLoader: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18.0),
            child: ListView.separated(
              itemBuilder: (context, index) => const CurrentShimmerCard(),
              separatorBuilder: (context, index) => 5.ph,
              itemCount: 10,
            ),
          ),
          emptyView: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.calendar_month,
                  size: 200,
                  color: Colors.black54,
                ),
                20.ph,
                AppText(
                  'empty_requests'.tr,
                  fontSize: 16,
                ),
                40.ph,
                ElevatedButton(
                  onPressed: () {
                    bookingController.refreshApiCall();
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 38.0),
                    child: AppText(
                      'refresh'.tr,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18.0),
            child: PaginationView(
              showLoadMoreWidget: bookingController.currentLoadingMore,
              showLoadMoreEndWidget: bookingController.currentLoadingMoreEnd,
              loadMoreData: bookingController.loadMoreCurrentBookings,
              child: RefreshIndicator(
                onRefresh: bookingController.refreshApiCall,
                child: ListView.separated(
                  itemBuilder: (context, index) => CurrentCard(
                    bookingModel: bookingController.currentBookingsList[index],
                  ),
                  separatorBuilder: (context, index) => 10.ph,
                  itemCount: bookingController.currentBookingsList.length,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

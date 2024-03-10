import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:vpm/app/extensions/space.dart';
import 'package:vpm/presentation/screens/home/pages/booking/components/ended/ended_card.dart';
import 'package:vpm/presentation/screens/home/pages/booking/components/ended/ended_shimmer_card.dart';

import '../../../../../../controller/booking_controller/booking_controller.dart';
import '../../../../../../widgets/api_state_views/handel_api_state.dart';

class EndedBooking extends StatelessWidget {
  const EndedBooking({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingController>(
      builder: (bookingController) {
        return HandleApiState.controller(
          generalController: bookingController,
          shimmerLoader: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 18.0,
              horizontal: 12,
            ),
            child: ListView.separated(
              itemBuilder: (context, index) => const EndedShimmerCard(),
              separatorBuilder: (context, index) => 5.ph,
              itemCount: 10,
            ),
          ),
          child: RefreshIndicator(
            onRefresh: bookingController.refreshApiCall,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 18.0,
                horizontal: 12,
              ),
              child: ListView.separated(
                itemBuilder: (context, index) => EndedCard(
                    bookingModel: bookingController.endedBookingsList[index]),
                separatorBuilder: (context, index) => 5.ph,
                itemCount: bookingController.endedBookingsList.length,
              ),
            ),
          ),
        );
      },
    );
  }
}

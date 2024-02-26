import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpm/app/extensions/space.dart';
import 'package:vpm/presentation/controller/booking_controller/booking_controller.dart';
import 'package:vpm/presentation/screens/home/pages/booking/components/current/current_card.dart';
import 'package:vpm/presentation/widgets/api_state_views/handel_api_state.dart';

class CurrentBooking extends StatelessWidget {
  const CurrentBooking({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingController>(
      builder: (bookingController) {
        return HandleApiState.controller(
          generalController: bookingController,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18.0),
            child: RefreshIndicator(
              onRefresh: bookingController.refreshApiCall,
              child: ListView.separated(
                itemBuilder: (context, index) => CurrentCard(
                    bookingModel: bookingController.currentBookingsList[index]),
                separatorBuilder: (context, index) => 10.ph,
                itemCount: bookingController.currentBookingsList.length,
              ),
            ),
          ),
        );
      },
    );
  }
}

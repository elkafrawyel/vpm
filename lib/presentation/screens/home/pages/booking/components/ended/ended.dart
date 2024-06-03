import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:vpm/app/extensions/space.dart';
import 'package:vpm/presentation/controller/booking_controller/ended_booking_controller.dart';
import 'package:vpm/presentation/screens/home/pages/booking/components/ended/ended_card.dart';
import 'package:vpm/presentation/screens/home/pages/booking/components/ended/ended_shimmer_card.dart';
import 'package:vpm/presentation/widgets/api_state_views/pagination_view.dart';

import '../../../../../../widgets/api_state_views/handel_api_state.dart';
import '../../../../../../widgets/app_widgets/app_text.dart';

class EndedBooking extends StatefulWidget {
  const EndedBooking({super.key});

  @override
  State<EndedBooking> createState() => _EndedBookingState();
}

class _EndedBookingState extends State<EndedBooking>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GetBuilder<EndedBookingController>(
      builder: (endedBookingController) {
        return HandleApiState.operation(
          operationReply: endedBookingController.operationReply,
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
                    endedBookingController.refreshApiCall();
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
          child: PaginationView(
            showLoadMoreWidget: endedBookingController.loadingMore,
            showLoadMoreEndWidget: endedBookingController.loadingMoreEnd,
            loadMoreData: endedBookingController.callMoreData,
            child: RefreshIndicator(
              onRefresh: endedBookingController.refreshApiCall,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 18.0,
                  horizontal: 12,
                ),
                child: ListView.separated(
                  itemBuilder: (context, index) => EndedCard(
                    bookingModel: endedBookingController.paginationList[index],
                  ),
                  separatorBuilder: (context, index) => 5.ph,
                  itemCount: endedBookingController.paginationList.length,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

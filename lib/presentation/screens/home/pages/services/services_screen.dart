import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpm/presentation/screens/home/pages/services/components/service_card.dart';
import 'package:vpm/presentation/screens/home/pages/services/components/services_empty_view.dart';
import 'package:vpm/presentation/widgets/api_state_views/handel_api_state.dart';

import '../../../../controller/advertisements_controller.dart';
import 'components/service_shimmer_card.dart';

class AdvertisementsScreen extends StatefulWidget {
  const AdvertisementsScreen({super.key});

  @override
  State<AdvertisementsScreen> createState() => _AdvertisementsScreenState();
}

class _AdvertisementsScreenState extends State<AdvertisementsScreen> {
  final AdvertisementsController servicesController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('services'.tr),
      ),
      body: GetBuilder<AdvertisementsController>(
        builder: (context) {
          return HandleApiState.controller(
            generalController: servicesController,
            emptyView: const ServicesEmptyView(),
            shimmerLoader: Padding(
              padding: const EdgeInsets.all(18.0),
              child: ListView.separated(
                itemBuilder: (context, index) => const ServiceShimmerCard(),
                separatorBuilder: (context, index) => Divider(
                  thickness: .5,
                  indent: 18,
                  endIndent: 18,
                  color: Colors.grey.shade700,
                ),
                itemCount: 10,
              ),
            ),
            child: RefreshIndicator(
              onRefresh: servicesController.refreshApiCall,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: ListView.separated(
                  itemBuilder: (context, index) =>
                      ServiceCard(service: servicesController.services[index]),
                  separatorBuilder: (context, index) => Divider(
                    thickness: .5,
                    indent: 18,
                    endIndent: 18,
                    color: Colors.grey.shade700,
                  ),
                  itemCount: servicesController.services.length,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

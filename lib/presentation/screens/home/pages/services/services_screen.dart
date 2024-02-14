import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpm/presentation/controller/services_controller/services_controller.dart';
import 'package:vpm/presentation/screens/home/pages/services/components/service_card.dart';
import 'package:vpm/presentation/widgets/api_state_views/handel_api_state.dart';

import 'components/service_shimmer_card.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  final ServicesController servicesController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('services'.tr),
      ),
      body: GetBuilder<ServicesController>(
        builder: (context) {
          return HandleApiState.controller(
            generalController: servicesController,
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
                  itemBuilder: (context, index) => const ServiceCard(),
                  separatorBuilder: (context, index) => Divider(
                    thickness: .5,
                    indent: 18,
                    endIndent: 18,
                    color: Colors.grey.shade700,
                  ),
                  itemCount: 10,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

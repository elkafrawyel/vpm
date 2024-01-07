import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:vpm/app/extensions/space.dart';
import 'package:vpm/presentation/controller/my_cars_controller/my_cars_controller.dart';
import 'package:vpm/presentation/screens/add_car/add_car_screen.dart';
import 'package:vpm/presentation/screens/my_cars/components/my_car_card.dart';
import 'package:vpm/presentation/widgets/api_state_views/handel_api_state.dart';

import 'components/my_car_shimmer_card.dart';

class MyCarsScreen extends StatefulWidget {
  const MyCarsScreen({super.key});

  @override
  State<MyCarsScreen> createState() => _MyCarsScreenState();
}

class _MyCarsScreenState extends State<MyCarsScreen> {
  @override
  void dispose() {
    Get.delete<MyCarsController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('your_cars'.tr),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: const AddCarScreen(),
            withNavBar: true,
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
        },
      ),
      body: GetBuilder<MyCarsController>(
        init: MyCarsController(),
        builder: (myCarsController) {
          return HandleApiState.controller(
            generalController: myCarsController,
            shimmerLoader: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.separated(
                itemBuilder: (context, index) => const MyCarShimmerCard(),
                separatorBuilder: (context, index) => 5.ph,
                itemCount: 10,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.separated(
                itemBuilder: (context, index) => const MyCarCard(),
                separatorBuilder: (context, index) => 5.ph,
                itemCount: 10,
              ),
            ),
          );
        },
      ),
    );
  }
}

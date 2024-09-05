import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:vpm/app/extensions/space.dart';
import 'package:vpm/presentation/controller/my_cars_controller.dart';
import 'package:vpm/presentation/screens/add_car/add_car_screen.dart';
import 'package:vpm/presentation/widgets/api_state_views/handel_api_state.dart';

import 'components/car_card.dart';
import 'components/car_shimmer_card.dart';
import 'components/cars_empty_view.dart';

class CarsScreen extends StatefulWidget {
  const CarsScreen({super.key});

  @override
  State<CarsScreen> createState() => _CarsScreenState();
}

class _CarsScreenState extends State<CarsScreen> {
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
        onPressed: () async {
          await PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: const AddCarScreen(),
            withNavBar: true,
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
          Get.find<MyCarsController>().getMyCars(loading: false);
        },
      ),
      body: GetBuilder<MyCarsController>(
        init: MyCarsController(),
        builder: (myCarsController) {
          return HandleApiState.controller(
            generalController: myCarsController,
            emptyView: const CarsEmptyView(),
            shimmerLoader: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.separated(
                itemBuilder: (context, index) => const CarShimmerCard(),
                separatorBuilder: (context, index) => 5.ph,
                itemCount: 10,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: RefreshIndicator(
                onRefresh: myCarsController.refreshApiCall,
                child: ListView.separated(
                  itemBuilder: (context, index) => CarCard(
                    car: myCarsController.cars[index],
                  ),
                  separatorBuilder: (context, index) => 5.ph,
                  itemCount: myCarsController.cars.length,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

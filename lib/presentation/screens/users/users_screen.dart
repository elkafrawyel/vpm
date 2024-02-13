import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:vpm/data/repositories/users_repository.dart';
import 'package:vpm/presentation/controller/users_controller/users_controller.dart';
import 'package:vpm/presentation/screens/add_user/add_user_screen.dart';
import 'package:vpm/presentation/screens/users/components/user_card.dart';
import 'package:vpm/presentation/screens/users/components/user_shimmer_card.dart';
import 'package:vpm/presentation/widgets/api_state_views/handel_api_state.dart';

import 'components/users_empty_view.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final UsersController usersController = Get.put(
    UsersController(
      UserRepositoryImpl(),
    ),
  );

  @override
  void dispose() {
    super.dispose();
    Get.delete<UsersController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('users_management'.tr),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        child: const Icon(Icons.add),
        onPressed: () async {
          await PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: const AddUserScreen(),
            withNavBar: true,
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
          usersController.getAllContacts();
        },
      ),
      body: GetBuilder<UsersController>(
        builder: (_) {
          return HandleApiState.controller(
            generalController: usersController,
            emptyView: const UsersEmptyView(),
            shimmerLoader: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.separated(
                itemBuilder: (context, index) => const UserShimmerCard(),
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
              onRefresh: usersController.refreshApiCall,
              child: ListView.separated(
                itemBuilder: (context, index) => UserCard(
                  user: usersController.usersList[index],
                ),
                separatorBuilder: (context, index) => Divider(
                  thickness: .5,
                  indent: 18,
                  endIndent: 18,
                  color: Colors.grey.shade700,
                ),
                itemCount: usersController.usersList.length,
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:vpm/app/config/app_color.dart';
import 'package:vpm/data/repositories/users_repository.dart';
import 'package:vpm/presentation/controller/users_controller/users_controller.dart';
import 'package:vpm/presentation/screens/users/components/add_user_screen.dart';
import 'package:vpm/presentation/widgets/api_state_views/handel_api_state.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_cached_image.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_text.dart';

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
            child: RefreshIndicator(
              onRefresh: usersController.refreshApiCall,
              child: ListView.separated(
                itemBuilder: (context, index) => ListTile(
                  horizontalTitleGap: 8,
                  leading: AppCachedImage(
                    imageUrl:
                        usersController.contactsList[index].avatar?.filePath,
                    isCircular: true,
                    borderWidth: 2,
                    height: 70,
                    width: 70,
                    borderColor: Theme.of(context).primaryColor,
                  ),
                  title: AppText(
                    usersController.contactsList[index].name ?? '',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                  // subtitle: const AppText('Son'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.clear),
                        color: errorColor,
                      ),
                    ],
                  ),
                ),
                separatorBuilder: (context, index) => Divider(
                  thickness: .5,
                  indent: 18,
                  endIndent: 18,
                  color: Colors.grey.shade700,
                ),
                itemCount: usersController.contactsList.length,
              ),
            ),
          );
        },
      ),
    );
  }
}

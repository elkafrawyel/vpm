import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:vpm/app/extensions/space.dart';
import 'package:vpm/app/util/constants.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_drop_menu.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_progress_button.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_text.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_text_field/app_text_field.dart';

import '../../widgets/app_widgets/app_image_picker_dialog.dart';

class AddCarScreen extends StatefulWidget {
  const AddCarScreen({super.key});

  @override
  State<AddCarScreen> createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen> {
  File? image;
  late TextEditingController carNameController;

  @override
  void initState() {
    super.initState();
    carNameController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    carNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('add_car'.tr),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: image != null
                    ? GestureDetector(
                        onTap: () {
                          _chooseImage();
                        },
                        child: Container(
                          height: 150,
                          width: MediaQuery.sizeOf(context).width * 0.8,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(kRadius),
                            image: DecorationImage(
                              image: FileImage(image!),
                              fit: BoxFit.cover,
                            ),
                          ),
                          alignment: AlignmentDirectional.bottomEnd,
                          child: InkWell(
                            onTap: () {
                              _chooseImage();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: const Color(0xff1D80E6),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          _chooseImage();
                        },
                        child: Container(
                          height: 150,
                          width: MediaQuery.sizeOf(context).width * 0.8,
                          decoration: BoxDecoration(
                            color: const Color(0xffECECEC),
                            borderRadius: BorderRadius.circular(kRadius),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.image,
                              size: 60,
                            ),
                          ),
                        ),
                      ),
              ),
              20.ph,
              AppTextFormField(
                controller: carNameController,
                hintText: 'car_title'.tr,
              ),
              10.ph,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: AppText("choose_car_brand".tr),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppDropMenu<String>(
                  hint: 'car_brand'.tr,
                  items: const [
                    'Brand 1',
                    'Brand 2',
                    'Brand 3',
                    'Brand 4',
                  ],
                  expanded: true,
                  bordered: true,
                  onChanged: (String? brand) {
                    debugPrint(brand);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: AppText("choose_car_color".tr),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppDropMenu<String>(
                  hint: 'car_color'.tr,
                  items: const [
                    'Color 1',
                    'Color 2',
                    'Color 3',
                    'Color 4',
                  ],
                  expanded: true,
                  bordered: true,
                  onChanged: (String? brand) {
                    debugPrint(brand);
                  },
                ),
              ),
              30.ph,
              Center(
                child: AppProgressButton(
                  text: 'add_car'.tr,
                  width: MediaQuery.sizeOf(context).width * 0.8,
                  onPressed: (animationController) async {},
                ),
              ),
              200.ph,
            ],
          ),
        ),
      ),
    );
  }

  void _chooseImage() {
    showAppImageDialog(
        context: context,
        onFilePicked: (File file) {
          setState(() {
            image = file;
          });
        });
  }
}

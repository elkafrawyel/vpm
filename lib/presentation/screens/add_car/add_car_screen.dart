import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:vpm/app/extensions/space.dart';
import 'package:vpm/app/util/constants.dart';
import 'package:vpm/app/util/operation_reply.dart';
import 'package:vpm/domain/entities/models/car_model.dart';
import 'package:vpm/presentation/controller/my_cars_controller/my_cars_controller.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_cached_image.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_drop_menu.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_progress_button.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_text.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_text_field/app_text_field.dart';

import '../../../app/util/information_viewer.dart';
import '../../../data/models/car_colors_response.dart';
import '../../../data/models/car_types_response.dart';
import '../../../data/models/general_response.dart';
import '../../widgets/app_widgets/app_image_picker_dialog.dart';

class AddCarScreen extends StatefulWidget {
  final CarModel? car;

  const AddCarScreen({
    super.key,
    this.car,
  });

  @override
  State<AddCarScreen> createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen> {
  File? image;
  late TextEditingController carNameController;
  late TextEditingController carNumberController;

  final GlobalKey<AppTextFormFieldState> nameState = GlobalKey();
  final GlobalKey<AppTextFormFieldState> numberState = GlobalKey();
  final MyCarsController myCarsController = Get.find();
  CarTypeModel? selectedType;
  CarColorModel? selectedColor;

  @override
  void initState() {
    super.initState();
    carNameController = TextEditingController(text: widget.car?.name ?? '');
    carNumberController = TextEditingController(text: widget.car?.number ?? '');

    myCarsController.getCarColors().then((value) {
      selectedColor = myCarsController.carColors
          .firstWhereOrNull((element) => element.id == widget.car?.color?.id);
      myCarsController.loadingCarColors.refresh();
    });
    myCarsController.getCarTypes().then((value) {
      selectedType = myCarsController.carTypes
          .firstWhereOrNull((element) => element.id == widget.car?.type?.id);
      myCarsController.loadingCarTypes.refresh();
    });
  }

  @override
  void dispose() {
    super.dispose();
    carNameController.dispose();
    carNumberController.dispose();
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
                    ? InkWell(
                        onTap: () {
                          _chooseImage();
                        },
                        child: Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            AppCachedImage(
                              localFile: image,
                              height: 150,
                              width: MediaQuery.sizeOf(context).width * 0.8,
                              radius: 8,
                            ),
                            editIcon(),
                          ],
                        ),
                      )
                    : widget.car?.image?.filePath != null
                        ? InkWell(
                            onTap: () {
                              _chooseImage();
                            },
                            child: Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                AppCachedImage(
                                  imageUrl: widget.car?.image?.filePath,
                                  height: 150,
                                  width: MediaQuery.sizeOf(context).width * 0.8,
                                  radius: 8,
                                ),
                                editIcon(),
                              ],
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
                key: nameState,
                controller: carNameController,
                hintText: 'car_title'.tr,
              ),
              10.ph,
              AppTextFormField(
                key: numberState,
                controller: carNumberController,
                hintText: 'car_number'.tr,
              ),
              10.ph,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: AppText("choose_car_brand".tr),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(
                  () => myCarsController.loadingCarTypes.value
                      ? const Center(
                          child: CircularProgressIndicator.adaptive())
                      : AppDropMenu<CarTypeModel>(
                          hint: 'car_brand'.tr,
                          items: myCarsController.carTypes,
                          initialValue: selectedType,
                          expanded: true,
                          bordered: true,
                          onChanged: (CarTypeModel? brand) {
                            selectedType = brand;
                          },
                        ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: AppText("choose_car_color".tr),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(
                  () => myCarsController.loadingCarColors.value
                      ? const Center(
                          child: CircularProgressIndicator.adaptive())
                      : AppDropMenu<CarColorModel>(
                          hint: 'car_color'.tr,
                          items: myCarsController.carColors,
                          initialValue: selectedColor,
                          expanded: true,
                          bordered: true,
                          onChanged: (CarColorModel? color) {
                            selectedColor = color;
                          },
                        ),
                ),
              ),
              30.ph,
              Center(
                child: AppProgressButton(
                  text: 'add_car'.tr,
                  width: MediaQuery.sizeOf(context).width * 0.8,
                  onPressed: (animationController) async {
                    _addCar(animationController);
                  },
                ),
              ),
              200.ph,
            ],
          ),
        ),
      ),
    );
  }

  Widget editIcon() => InkWell(
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
      );

  void _chooseImage() {
    showAppImageDialog(
        context: context,
        onFilePicked: (File file) {
          setState(() {
            image = file;
          });
        });
  }

  void _addCar(AnimationController animationController) async {
    if (image == null && widget.car == null) {
      FocusManager.instance.primaryFocus?.unfocus();
      InformationViewer.showSnackBar('choose_car_image'.tr);
      return;
    } else if (carNameController.text.isEmpty) {
      nameState.currentState?.shake();
      return;
    } else if (carNumberController.text.isEmpty) {
      numberState.currentState?.shake();
      return;
    } else if (selectedType == null) {
      FocusManager.instance.primaryFocus?.unfocus();
      InformationViewer.showSnackBar('choose_car_brand'.tr);
      return;
    } else if (selectedColor == null) {
      FocusManager.instance.primaryFocus?.unfocus();
      InformationViewer.showSnackBar('choose_car_color'.tr);
      return;
    }

    OperationReply operationReply = await myCarsController.addCar(
      animationController: animationController,
      carId: widget.car?.id,
      name: carNameController.text,
      number: carNumberController.text,
      selectedType: selectedType!,
      selectedColor: selectedColor!,
      image: image,
      fileId: widget.car?.image?.id,
    );

    if (operationReply.isSuccess() && mounted) {
      GeneralResponse? generalResponse = operationReply.result;
      Navigator.of(context).pop();
      InformationViewer.showSnackBar(generalResponse?.message);
    } else {
      InformationViewer.showSnackBar(operationReply.message);
    }
    animationController.reverse();
  }
}

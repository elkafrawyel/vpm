import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:vpm/data/models/car_types_response.dart';
import 'package:vpm/data/repositories/cars_repository.dart';
import 'package:vpm/data/repositories/lookups_repository.dart';
import 'package:vpm/domain/entities/models/car_model.dart';
import 'package:vpm/domain/entities/requests/add_car_request.dart';
import 'package:vpm/presentation/controller/my_controllers/general_controller.dart';

import '../../app/util/information_viewer.dart';
import '../../app/util/operation_reply.dart';
import '../../data/models/car_colors_response.dart';
import '../../data/models/cars_response.dart';
import '../../data/models/general_response.dart';
import '../../data/models/upload_file_response.dart';

class MyCarsController extends GeneralController {
  final CarsRepositoryIml _carsRepositoryIml = CarsRepositoryIml();
  final LookUpsRepositoryIml _lookUpsRepositoryIml = LookUpsRepositoryIml();

  List<CarModel> cars = [];
  List<CarTypeModel> carTypes = [];
  List<CarColorModel> carColors = [];

  RxBool loadingCarTypes = false.obs;
  RxBool loadingCarColors = false.obs;

  @override
  onInit() {
    super.onInit();
    getMyCars();
  }

  Future<void> getCarTypes() async {
    loadingCarTypes.value = true;
    OperationReply operationReply = await _lookUpsRepositoryIml.getCarTypes();

    if (operationReply.isSuccess()) {
      CarTypesResponse? carTypesResponse = operationReply.result;
      carTypes = carTypesResponse?.data ?? [];
    } else {
      carTypes = [];
    }
    loadingCarTypes.value = false;
  }

  Future<void> getCarColors() async {
    loadingCarColors.value = true;

    OperationReply<CarColorsResponse> operationReply =
        await _lookUpsRepositoryIml.getCarColors();

    if (operationReply.isSuccess()) {
      CarColorsResponse? carColorsResponse = operationReply.result;
      carColors = carColorsResponse?.data ?? [];
    } else {
      carColors = [];
    }

    loadingCarColors.value = false;
  }

  Future<void> getMyCars({bool? loading = true}) async {
    if (loading ?? false) {
      operationReply = OperationReply.loading();
    }
    operationReply = await _carsRepositoryIml.getAllCars();
    if (operationReply.isSuccess()) {
      CarsResponse? carsResponse = operationReply.result;
      cars = carsResponse?.data ?? [];

      if (cars.isEmpty) {
        operationReply = OperationReply.empty();
      } else {
        operationReply = OperationReply.success();
      }
    }
  }

  @override
  Future<void> refreshApiCall() async {
    getMyCars();
  }

  Future<OperationReply> addCar({
    String? carId,
    required AnimationController animationController,
    required String name,
    required String number,
    required CarTypeModel selectedType,
    required CarColorModel selectedColor,
    File? image,
    String? fileId,
  }) async {
    OperationReply<GeneralResponse> operationReply;
    if (image != null) {
      OperationReply<UploadFileResponse> uploadOperationReply =
          await LookUpsRepositoryIml().uploadFile(
        file: image,
        onUploadProgress: (double percent) {
          EasyLoading.showProgress(
            percent,
            status: 'uploading'.tr,
          );
        },
      );
      //todo dismiss uploading view
      EasyLoading.dismiss();
      if (uploadOperationReply.isSuccess()) {
        UploadFileResponse? uploadFileResponse = uploadOperationReply.result;
        if (uploadFileResponse?.data?.id != null) {
          animationController.forward();
          operationReply = carId == null
              ? await _carsRepositoryIml.addCar(
                  addCarRequest: AddCarRequest(
                    name: name,
                    number: number,
                    fileId: uploadFileResponse?.data?.id,
                    carColorId: selectedColor.id,
                    carTypeId: selectedType.id,
                  ),
                )
              : await _carsRepositoryIml.updateCar(
                  carId: carId,
                  addCarRequest: AddCarRequest(
                    name: name,
                    number: number,
                    fileId: uploadFileResponse?.data?.id,
                    carColorId: selectedColor.id,
                    carTypeId: selectedType.id,
                  ),
                );
          return operationReply;
        } else {
          return operationReply = OperationReply.failed(
            message: uploadFileResponse?.message ?? '',
          );
        }
      } else {
        InformationViewer.showSnackBar(uploadOperationReply.message);
        return operationReply = OperationReply.failed(
          message: uploadOperationReply.message,
        );
      }
    } else {
      animationController.forward();
      operationReply = carId == null
          ? await _carsRepositoryIml.addCar(
              addCarRequest: AddCarRequest(
                name: name,
                number: number,
                fileId: fileId,
                carColorId: selectedColor.id,
                carTypeId: selectedType.id,
              ),
            )
          : await _carsRepositoryIml.updateCar(
              carId: carId,
              addCarRequest: AddCarRequest(
                name: name,
                number: number,
                fileId: fileId,
                carColorId: selectedColor.id,
                carTypeId: selectedType.id,
              ),
            );
      return operationReply;
    }
  }

  void deleteCar(CarModel car) async {
    EasyLoading.show();
    OperationReply operationReply = await _carsRepositoryIml.deleteCar(
      carId: car.id!,
    );

    EasyLoading.dismiss();

    if (operationReply.isSuccess()) {
      GeneralResponse generalResponse = operationReply.result;

      InformationViewer.showSnackBar(generalResponse.message);
      cars.remove(car);
      if (cars.isEmpty) {
        this.operationReply = OperationReply.empty();
      }
      update();
    } else {
      InformationViewer.showSnackBar(operationReply.message);
    }
  }
}

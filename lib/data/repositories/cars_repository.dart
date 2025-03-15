import 'package:vpm/app/res/res.dart';
import 'package:vpm/data/models/cars_response.dart';
import 'package:vpm/data/models/general_response.dart';
import 'package:vpm/data/providers/network/api_provider.dart';

import '../../app/util/operation_reply.dart';
import '../../domain/entities/requests/add_car_request.dart';
import '../../domain/repositories/cars_repository.dart';

class CarsRepositoryIml extends CarsRepository {
  @override
  Future<OperationReply<CarsResponse>> getAllCars() async {
    return await APIProvider.instance.get(
      endPoint: Res.apiAllCars,
      fromJson: CarsResponse.fromJson,
    );
  }

  @override
  Future<OperationReply<GeneralResponse>> addCar({
    required AddCarRequest addCarRequest,
  }) async {
    return await APIProvider.instance.post(
      endPoint: Res.apiCar,
      fromJson: GeneralResponse.fromJson,
      requestBody: addCarRequest.toJson(),
    );
  }

  @override
  Future<OperationReply<GeneralResponse>> deleteCar({
    required String carId,
  }) async {
    return await APIProvider.instance.delete<GeneralResponse>(
      endPoint: "${Res.apiCar}/$carId",
      fromJson: GeneralResponse.fromJson,
      requestBody: {},
    );
  }

  @override
  Future<OperationReply<GeneralResponse>> updateCar({
    required String carId,
    required AddCarRequest addCarRequest,
  }) async {
    return await APIProvider.instance.patch<GeneralResponse>(
      endPoint: "${Res.apiCar}/$carId",
      fromJson: GeneralResponse.fromJson,
      requestBody: addCarRequest.toJson(),
    );
  }
}

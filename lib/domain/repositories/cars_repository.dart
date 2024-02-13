import '../../app/util/operation_reply.dart';
import '../../data/models/cars_response.dart';
import '../../data/models/general_response.dart';
import '../entities/requests/add_car_request.dart';

abstract class CarsRepository {
  Future<OperationReply<CarsResponse>> getAllCars();

  Future<OperationReply<GeneralResponse>> addCar({
    required AddCarRequest addCarRequest,
  });

  Future<OperationReply<GeneralResponse>> updateCar({
    required String carId,
    required AddCarRequest addCarRequest,
  });

  Future<OperationReply<GeneralResponse>> deleteCar({
    required String carId,
  });
}

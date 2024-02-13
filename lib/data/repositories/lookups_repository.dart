import 'dart:io';

import 'package:vpm/app/res/res.dart';
import 'package:vpm/data/models/upload_file_response.dart';
import 'package:vpm/data/providers/network/api_provider.dart';

import '../../app/util/operation_reply.dart';
import '../../domain/repositories/lookups_repository.dart';
import '../models/car_colors_response.dart';
import '../models/car_types_response.dart';

class LookUpsRepositoryIml extends LookUpsRepository {
  @override
  Future<OperationReply<UploadFileResponse>> uploadFile({
    required File file,
    Function(double percentage)? onUploadProgress,
  }) async {
    return await APIProvider.instance.post(
      endPoint: Res.apiUploadFile,
      fromJson: UploadFileResponse.fromJson,
      requestBody: {},
      files: [
        MapEntry('file', file),
      ],
      onUploadProgress: onUploadProgress,
    );
  }

  @override
  Future<OperationReply<CarColorsResponse>> getCarColors() async {
    return await APIProvider.instance.get(
      endPoint: Res.apiCarColors,
      fromJson: CarColorsResponse.fromJson,
    );
  }

  @override
  Future<OperationReply<CarTypesResponse>> getCarTypes() async {
    return await APIProvider.instance.get(
      endPoint: Res.apiCarTypes,
      fromJson: CarTypesResponse.fromJson,
    );
  }
}

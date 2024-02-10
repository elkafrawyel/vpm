import 'dart:io';

import 'package:vpm/app/res/res.dart';
import 'package:vpm/data/models/upload_file_response.dart';
import 'package:vpm/data/providers/network/api_provider.dart';

import '../../app/util/operation_reply.dart';
import '../../domain/repositories/lookups_repository.dart';

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
}

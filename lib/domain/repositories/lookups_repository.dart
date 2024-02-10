import 'dart:io';

import '../../app/util/operation_reply.dart';
import '../../data/models/upload_file_response.dart';

abstract class LookUpsRepository {
  Future<OperationReply<UploadFileResponse>> uploadFile({
    required File file,
    Function(double percentage)? onUploadProgress,
  });
}

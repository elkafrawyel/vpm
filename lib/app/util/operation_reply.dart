///represents what the API replies when performing operations on server.
///fill the type if you intend to return the reply with data
class OperationReply<ReturnType> {
  OperationStatus status;
  String message;
  ReturnType? returnData;

  OperationReply(this.status, {this.message = "Some thing went wrong", this.returnData});

  bool isLoading() {
    return status == OperationStatus.loading;
  }

  bool isSuccess() {
    return status == OperationStatus.success;
  }

  bool isError() {
    return status == OperationStatus.failed;
  }

  ///casts the object to another type ONLY IF it holds no data
  as<NewType>() {
    assert(returnData == null);
    return OperationReply<NewType>(status, message: message);
  }

  factory OperationReply.init({String message = "Some thing went wrong", returnData}) {
    return OperationReply(OperationStatus.init, message: message, returnData: returnData);
  }

  factory OperationReply.loading({String message = "Some thing went wrong", returnData}) {
    return OperationReply(OperationStatus.loading, message: message, returnData: returnData);
  }

  factory OperationReply.failed({String message = "Some thing went wrong", returnData}) {
    return OperationReply(OperationStatus.failed, message: message, returnData: returnData);
  }

  factory OperationReply.connectionDown({String message = "Some thing went wrong", returnData}) {
    return OperationReply(OperationStatus.disConnected, message: message, returnData: returnData);
  }

  factory OperationReply.success({String message = "Some thing went wrong", returnData}) {
    return OperationReply(OperationStatus.success, message: message, returnData: returnData);
  }

  factory OperationReply.fromReply(OperationReply reply, {OperationStatus? status, String? message, returnData}) {
    return OperationReply(
      status ?? reply.status,
      message: message ?? reply.message,
      returnData: returnData ?? reply.returnData,
    );
  }
}

enum OperationStatus { init, loading, success, failed, disConnected }

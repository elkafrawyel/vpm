class ConfigData<T> {
  String apiEndPoint;
  String emptyListMessage = 'Empty Data';
  T Function(dynamic) fromJson;

  ConfigData({
    required this.apiEndPoint,
    required this.emptyListMessage,
    required this.fromJson,
  });
}

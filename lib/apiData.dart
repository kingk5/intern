class dataFromApi {
  final advice;

  dataFromApi({this.advice});

  factory dataFromApi.fromJson(final json) {
    return dataFromApi(advice: json["slip"]["advice"]);
  }
}

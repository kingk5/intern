class DataFromApi {
  final advice;

  DataFromApi({this.advice});

  factory DataFromApi.fromJson(final json) {
    return DataFromApi(advice: json["slip"]["advice"]);
  }
}

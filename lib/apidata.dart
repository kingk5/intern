class datafromapi{
  final advice;
  datafromapi({this.advice});
  factory datafromapi.fromjson(final json){
    return datafromapi(
      advice: json["slip"]["advice"]
    );
  }
}
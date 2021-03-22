import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:intern/apiData.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdviceProvider with ChangeNotifier {
  String advice;
  bool got;

  AdviceProvider() {
    advice = "";
    got = false;
    addData();
  }

  String get getAdvice => advice;

  bool get getGot => got;

  void setAdvice(String advi) {
    advice = "Advice = " + advi;
    print("advice" + advice);
  }

  void setGot(bool x) {
    got = x;
    notifyListeners();
  }

  addData() async {
    setGot(false);
    DataFromApi p = await getData();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool checkValue =
        prefs.containsKey('apiData'); //check if shared preferences exists
    if (checkValue) {
      List<String> value = prefs.getStringList("apiData");
      value.add(DateTime.now().toString());
      value.add(p.advice.toString());
      prefs.setStringList("apiData", value);
    } else {
      prefs.setStringList("apiData", [
        DateTime.now().toString(),
        p.advice.toString(),
      ]);
    }
    setAdvice(p.advice);
    print("advice" + p.advice);
    setGot(true);
  }

  Future<DataFromApi> getData() async {
    //fetch data from api and return the data
    final response = await http.get("https://api.adviceslip.com/advice");
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      return DataFromApi.fromJson(jsonData);
    } else {
      throw Exception();
    }
  }
}

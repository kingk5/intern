import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'apiData.dart';
import 'history.dart';

class ApiCall extends StatefulWidget {
  @override
  _ApiCallState createState() => _ApiCallState();
}

class _ApiCallState extends State<ApiCall> {
  String advi;
  bool got = false;

  void initState() {
    super.initState();
    callData();
  }

  callData() async {//get the data and to shared preferences
    setState(() {
      got = false;
    });
    DataFromApi p = await getData();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool checkValue = prefs.containsKey('apiData');//check if shared preferences exists
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

    setState(() {
      advi = p.advice;
      got = true;
      advi = "Advice = " + advi;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "Demo API APP",
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            IconButton(
              iconSize: 30,
              padding: EdgeInsets.only(right: 15),
              onPressed: () {
                callData();
              },
              icon: Icon(
                Icons.refresh,//To get the new Advice
                color: Colors.black,
              ),
            ),
            IconButton(
              iconSize: 30,
              padding: EdgeInsets.only(right: 15),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HistoryScreen(),//Calls the second screen of history
                    ));
              },
              icon: Icon(
                Icons.history,// to see the history
                color: Colors.black,
              ),
            )
          ],
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(8),
            child: got//check if advice is received
                ? Text(
                    advi,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                : CircularProgressIndicator(),
          ),
        ));
  }
}

Future<DataFromApi> getData() async {//fetch data from api and return the data
  final response = await http.get("https://api.adviceslip.com/advice");
  if (response.statusCode == 200) {
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    return DataFromApi.fromJson(jsonData);
  } else {
    throw Exception();
  }
}

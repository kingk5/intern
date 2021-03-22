import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'apidata.dart';
import 'history.dart';
import 'package:shared_preferences/shared_preferences.dart';
class apicall extends StatefulWidget {
  @override
  _apicallState createState() => _apicallState();
}

class _apicallState extends State<apicall> {
  String advi;
  bool got=false;
  void initState() {
    super.initState();
    calldata();
  }
  calldata() async {
    setState(() {
      got = false;
    });
    datafromapi p = await getdata();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool checkvalue = prefs.containsKey('apidata');
    if(checkvalue){
      List<String> value = prefs.getStringList("apidata");
      value.add(DateTime.now().toString());
      value.add(p.advice.toString());
      prefs.setStringList("apidata", value);
    }
    else{
      prefs.setStringList("apidata", [
        DateTime.now().toString(),
        p.advice.toString(),
      ]);
    }

    setState(() {
      advi = p.advice;
      got=true;
      advi = "Advice = "+advi;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Demo API APP",style: TextStyle(color: Colors.black),),
        actions: [
          IconButton(
              iconSize: 30,
              padding: EdgeInsets.only(right: 15),
              onPressed: () {
                calldata();
              },
              icon: Icon(Icons.refresh,color: Colors.black,),
          ),
          IconButton(
            iconSize: 30,
            padding: EdgeInsets.only(right: 15),
            onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(
                      builder: (context) => history(),
                    ));
            },
            icon: Icon(Icons.history,color: Colors.black,),
          )
        ],
      ),
      body:Center(
        child: Container(
          padding: EdgeInsets.all(8),
          child: got?Text(advi,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),):CircularProgressIndicator(),
        ),
      )
    );
  }
}
Future<datafromapi> getdata() async {
  final res = await http.get("https://api.adviceslip.com/advice");
  if(res.statusCode==200){
    Map<String,dynamic> jsondata = jsonDecode(res.body);
    return datafromapi.fromjson(jsondata);
  }
  else{
    throw Exception();
  }
}
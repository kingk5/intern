import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class history extends StatefulWidget {
  @override
  _historyState createState() => _historyState();
}

class _historyState extends State<history> {
  List<String> advice = [];
  List<String> timeStamp = [];
  int dataAdded = 0;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {//get data from shared preferences and Separate between timestamp and advice
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool checkValue = prefs.containsKey('apiData');//check if shared preferences exists
    if (checkValue) {
      List<String> value = prefs.getStringList("apiData");
      int i = 0;
      for (String val in value) {
        if (i % 2 == 0) {
          timeStamp.add(val);
        } else {
          advice.add(val);
        }
        i++;
      }
      setState(() {
        dataAdded = 1;
      });
    } else {
      dataAdded = 2;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "History",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          iconSize: 30,
          padding: EdgeInsets.only(right: 15),
          onPressed: () {
            Navigator.pop(context);//return to previous screen
          },
          icon: Icon(
            Icons.arrow_back_outlined,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        child: dataAdded == 1//check if data is received
            ? ListView.builder(
                itemCount: advice.length,
                itemBuilder: (BuildContext cxt, int index) {
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    child: ListTile(
                      leading: Text(
                        timeStamp[index],
                        style: TextStyle(color: Colors.black),
                      ),
                      tileColor: Colors.grey[100],
                      title: Text(
                        advice[index],
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  );
                })
            : dataAdded == 2//Check if there is data to print
                ? Text("No Data")
                : CircularProgressIndicator(),
      ),
    );
  }
}

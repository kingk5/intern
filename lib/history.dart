import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  final List<String> advice;
  final List<String> timeStamp;

  HistoryScreen({this.advice, this.timeStamp});

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
            Navigator.pop(context); //return to previous screen
          },
          icon: Icon(
            Icons.arrow_back_outlined,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
          child: ListView.builder(
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
              })),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: deprecated_member_use
import 'package:flutter_riverpod/all.dart';
import 'package:intern/provider/advice.dart';
import 'package:intern/provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'history.dart';

class ApiCall extends StatelessWidget {
  BuildContext globalContext;
  AdviceProvider adviceProvider;

  @override
  Widget build(BuildContext context) {
    globalContext = context;
    return Consumer(builder: (context, watch, child) {
      adviceProvider = watch(Providers.adviceProvider);
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
                  adviceProvider.addData();
                },
                icon: Icon(
                  Icons.refresh, //To get the new Advice
                  color: Colors.black,
                ),
              ),
              IconButton(
                iconSize: 30,
                padding: EdgeInsets.only(right: 15),
                onPressed: () async {
                  List<String> advice = [];
                  List<String> timeStamp = [];
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HistoryScreen(
                          advice: advice,
                          timeStamp: timeStamp,
                        ), //Calls the second screen of history
                      ));
                },
                icon: Icon(
                  Icons.history, // to see the history
                  color: Colors.black,
                ),
              )
            ],
          ),
          body: Center(
            child: Container(
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (adviceProvider.got) ...[
                    Text(
                      globalContext.read(Providers.adviceProvider).getAdvice,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )
                  ],
                  if (!adviceProvider.got) ...[
                    CircularProgressIndicator(),
                  ],
                ],
              ),
            ),
          ));
    });
  }
}

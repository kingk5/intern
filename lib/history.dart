import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class history extends StatefulWidget {
  @override
  _historyState createState() => _historyState();
}

class _historyState extends State<history> {
  List<String> advice=[];
  List<String> timestamp = [];
  int datadded = 0;
  @override
  void initState() {
    super.initState();
    getdata();
  }
  getdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool checkvalue = prefs.containsKey('apidata');
    if(checkvalue){
      List<String> value = prefs.getStringList("apidata");
      int i=0;
      for(String val in value) {
        if(i%2==0){
          timestamp.add(val);
        }
        else {
          advice.add(val);
        }
        i++;
      }
      setState(() {
        datadded = 1;
      });
    }
    else{
     datadded=2;
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("History",style: TextStyle(color: Colors.black),),
        leading: IconButton(
          iconSize: 30,
          padding: EdgeInsets.only(right: 15),
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_outlined,color: Colors.black,),
        ),
      ),
      body: Container(
        child: datadded==1?ListView.builder(itemCount: advice.length,
          itemBuilder:(BuildContext cxt,int index){
          return Container(
            padding: EdgeInsets.symmetric(vertical: 8,horizontal: 8),
            child:  ListTile(
              leading: Text(timestamp[index],style: TextStyle(color: Colors.black),),
              tileColor: Colors.grey[100],
              title: Text(advice[index],style: TextStyle(color: Colors.black),),
            ),
          );
          }):datadded==2?Text("No Data"):CircularProgressIndicator(),
      ),
    );
  }
}

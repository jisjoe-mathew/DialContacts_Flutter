import 'package:flutter/cupertino.dart';
import 'package:mcbs_dialcontacts/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  FirstScreen createState() => FirstScreen();
  }

class FirstScreen extends State<MainScreen> {
  String pic="http://mcbs.dialcontacts.com/global.png";
    Future getSharedPreferences() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      pic = prefs.getString("pic");
      print("PICTURE="+pic);
setState(() {

});
    }

@override
  void initState() {
    // TODO: implement initState
  getSharedPreferences();
  super.initState();
  }
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return new MaterialApp(
       home:Scaffold(body:Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("Assets/bg.jpg"),
              fit: BoxFit.cover,
            ),
          ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
              Padding(
              padding: EdgeInsets.only(top: 100),
              child:  CircleAvatar(
                backgroundImage: NetworkImage(pic),
                radius: 60.0,

              )),
                  Center(
                      child:Padding(
                          padding: EdgeInsets.only(top:85.0),
                          child:
                          new Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Stack(
                              children: <Widget>[

                          new GestureDetector(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => PhoneLogin()),
                              );
                              print("Container PHONE");
                            },
                            child:Center(child: Image(
                              image: new AssetImage("Assets/butt1.png"),
                            ),
                          )
                          ),
                          Center(
                              child: Padding(
                                  padding: EdgeInsets.all(35.0),
                                  child: Text("Generalate",
                          style:
                          new TextStyle(
                              color: Colors.white,
                              fontSize: 17.0,
                                     )
                                  )
                              )
                          ),
                              ]
                          ),

                          Stack(
                              children: <Widget>[

                                new GestureDetector(
                                    onTap: (){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => PhoneLogin()),
                                      );
                                      print("Container PHONE");
                                    },
                                    child:Center(child: Image(
                                      image: new AssetImage("Assets/btn2.png"),
                                      fit: BoxFit.fitWidth,
                                    ),
                                    )
                                ),
                                Center(
                                    child: Padding(
                                        padding: EdgeInsets.only(left:60.0,top: 35.0),
                                        child: Text("Emmaus Province",
                                            style:
                                            new TextStyle(
                                              color: Colors.white,
                                              fontSize: 17.0,
                                            )
                                        )
                                    )
                                ),
                              ]
                          ),

                          Stack(
                              children: <Widget>[

                                new GestureDetector(
                                    onTap: (){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => PhoneLogin()),
                                      );
                                      print("Container PHONE");
                                    },
                                    child:Center(child: Image(
                                      image: new AssetImage("Assets/butt1.png"),
                                    ),
                                    )
                                ),
                                Center(
                                    child: Padding(
                                        padding: EdgeInsets.only(top: 35.0,right: 15.0),
                                        child: Text("Zion Province",
                                            style:
                                            new TextStyle(
                                              color: Colors.white,
                                              fontSize: 17.0,
                                            )
                                        )
                                    )
                                ),
                              ]
                          ),

                        ],
                      )
                  )
                  )
                ],
              ),

          ),
    ))
    );
    }
}


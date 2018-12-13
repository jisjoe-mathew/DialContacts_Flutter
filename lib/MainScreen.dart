import 'package:flutter/cupertino.dart';
import 'package:mcbs_dialcontacts/Contact.dart';
import 'package:mcbs_dialcontacts/ProfileDetail.dart';
import 'package:mcbs_dialcontacts/Regions.dart';
import 'package:mcbs_dialcontacts/Search.dart';
import 'package:mcbs_dialcontacts/SpeakerProfile.dart';
import 'package:mcbs_dialcontacts/Update.dart';
import 'package:mcbs_dialcontacts/database.dart';
import 'package:mcbs_dialcontacts/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override

  FirstScreen createState() => FirstScreen();
}

class FirstScreen extends State<MainScreen> {
  String NAME;
  String pic="http://mcbs.dialcontacts.com/global.png";
  Future getSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    pic = prefs.getString("pic");
    NAME = prefs.getString("name");
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
  Future<bool> _onWillPop() {
    print("----------------------------------------------------------------------------------------");
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text('Yes'),
          ),
        ],
      ),
    ) ?? false;
  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return new MaterialApp(
        home:new WillPopScope(
        onWillPop: _onWillPop,
        child:Scaffold(
            appBar: AppBar(
              title: Text(NAME),
              backgroundColor: const Color(0xFF075e54),
              iconTheme: IconThemeData(
                color: Colors.white, //change your color here
              ),

              actions: <Widget>[Padding(padding: EdgeInsets.all(10.0),child:
              new GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Search()),
                    );
                    print("Container PHONE");
                  },
                  child:Icon(Icons.search,size: 30.0,))),
              Padding(padding: EdgeInsets.all(10.0),

                  child: new GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Update()),
                        );
                        print("Container PHONE");
                      },child:Icon(Icons.refresh,size: 30.0,))),
              ],primary: true,titleSpacing: 15.0,
            ),

            body:Container(
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
                                              MaterialPageRoute(builder: (context) => SpeakerProfile()),
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
                                              child:  new GestureDetector(
                                                  onTap: (){
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(builder: (context) => SpeakerProfile()),
                                                    );
                                                    print("Container PHONE");
                                                  },
                                                  child:Text("Generalate",
                                                      style:
                                                      new TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 17.0,
                                                      )
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
                                              MaterialPageRoute(builder: (context) => Regions("Emmaus")),
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
                                              child:   new GestureDetector(
                                                  onTap: (){
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(builder: (context) => Regions("Emmaus")),
                                                    );
                                                    print("Container PHONE");
                                                  },
                                                  child:Text("Emmaus Province",
                                                      style:
                                                      new TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 17.0,
                                                      )
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
                                              MaterialPageRoute(builder: (context) => Regions("Zion")),
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
                                              child:  new GestureDetector(
                                                  onTap: (){
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(builder: (context) => Regions("Zion")),
                                                    );
                                                    print("Container PHONE");
                                                  },
                                                  child:Text("Zion Province",
                                                      style:
                                                      new TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 17.0,
                                                      )
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
            )      ))
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
  }

  class _MyAppState extends State<MainScreen> {
    @override
    Widget build(BuildContext context) {
      return MaterialApp(
          home: FirstScreen()
      );
    }
  }
class FirstScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return new Container(

            child:
            Card(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("Authenticate",style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 20.0
                  ),),
                  Image(
                    image: new AssetImage("Assets/logo.png"),
                    height: 80.0,
                    width: 80.0,
                  ),
                  Text("DIALCONTACTS",style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 20.0
                  ),
                  ),
                  Center(
                      child:
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          new GestureDetector(
                              onTap: (){

                                print("HELLLO");

                              },
                              child:Image(
                                image: new AssetImage("Assets/email.png"),
                                height: 80.0,
                                width: 80.0,
                              )),
                          new GestureDetector(
                            onTap: (){

                              print("Container PHONE");
                            },
                            child:Image(
                              image: new AssetImage("Assets/phone.png"),
                              height: 80.0,
                              width: 80.0,
                            ),
                          ),
                        ],
                      )
                  )
                ],
              ),
            ),
          ),
    );
  }
}


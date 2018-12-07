import 'dart:async';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mcbs_dialcontacts/Constants.dart';
import 'package:mcbs_dialcontacts/FetchDetails.dart';
import 'package:shared_preferences/shared_preferences.dart';



import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
void main(){
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {runApp(MyApp());});}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}
bool id;
getSharedPreferences(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  id = prefs.getBool("login");
  print("jisjoe"+prefs.getString("id"));

  if(id==true){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FetchDetails()),
    );
  }
}

class _MyAppState extends State<MyApp> {
  @override
  
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

    // TODO: implement buil
    getSharedPreferences(context);
    print("jisjoe"+id.toString());
    return Center(
      child: Container(
        padding: EdgeInsets.only(bottom: 50.0),
        alignment: Alignment.center,
        child: Scaffold(
          body: Card(
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
                    height: 350.0,
                    width: 350.0,
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => EmailLogin()),
                                );
                              },
                              child:Image(
                                image: new AssetImage("Assets/mail.png"),
                                height: 80.0,
                                width: 80.0,
                              )),
                          new GestureDetector(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => PhoneLogin()),
                              );
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
        ),
      ),
    );
  }

}

class EmailLogin extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<EmailLogin> {
  TextEditingController username=new TextEditingController();
  void _loginapi_validate() {
    if(username.text==""){
      print("USERNAME"+username.text);

      Fluttertoast.showToast(
          msg: "Please Enter Credential to Authenticate..",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          textcolor:'#ffffff',
          bgcolor: '#FF3E4D'
      );
    }
    else
      _loginapi();
  }
  Future<Null> _loginapi() async {
          var data = {"type": "email", "username": username.text};
      var url = Constants().VERIFY;
      print((data));
      var response = await request(url, json.encode(data));
      print(response);


  }
  Future<Map> request(var url, var data) async {
    http.Response response=await http.post(url,headers:{ "Content-Type":"application/x-www-form-urlencoded" } ,
        body: { "username":username.text , "type":"email"},
        encoding: Encoding.getByName("utf-8"));
    List res=response.body.split("\n");
    print("yoo"+res[0]);
    if(res[0].toString().compareTo("<!DOCTYPE html>")==1)
    {Map dat;
    print(response.body);

    dat = json.decode(response.body);
    print(dat["count"]);
    if(dat["count"]!=0)
    {Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
    }
    else
    {
      Fluttertoast.showToast(
          msg: "Authentication Failed...Try Again...",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
        textcolor:'#ffffff',
        bgcolor: '#FF3E4D'
      );
    }
    }
    return json.decode(response.body);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: Text("Login",
          style: new TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body:   Builder(
        // Create an inner BuildContext so that the onPressed methods
        // can refer to the Scaffold with Scaffold.of().
        builder: (BuildContext context) {
      return new Container(
        color: Colors.transparent,
        alignment: Alignment.center,
        child: Card(
    child: new Container(
          padding: EdgeInsets.all(20.0),
          height: 300.0,
          width: 300.0,
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new Image(
                image: new AssetImage("Assets/logo.png"),
                height: 100.0,
                width: 100.0,
              ),
              new TextField(
                controller: username,
                decoration: new InputDecoration(
                    hintText: "Email",
                    icon: new Icon(Icons.lock)
                ),
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[

                  new RaisedButton(
                    onPressed: _loginapi_validate,
                    color: Colors.green,
                    child: new Text("Authenticate"),
                  )
                ],
              )
            ],
          ),
        ),
      )
      );
        }
        )
    );
  }
}


class PhoneLogin extends StatefulWidget {
  @override
  _LoginState_phone createState() => _LoginState_phone();
}

class _LoginState_phone extends State<PhoneLogin> {
  TextEditingController username=new TextEditingController();
  void _loginapi_validate() {
    if(username.text==""){
      print("USERNAME"+username.text);

      Fluttertoast.showToast(
          msg: "Please Enter Credential to Authenticate..",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          textcolor:'#ffffff',
          bgcolor: '#FF3E4D'
      );
    }
    else
      _loginapi();
  }
  Future<Null> _loginapi() async {
    var data = {"type": "mobile", "username": username.text};
    var url = Constants().VERIFY;
    print((data));
    var response = await request(url, json.encode(data));
    print(response);


  }
  Future<Map> request(var url, var data) async {
    http.Response response=await http.post(url,headers:{ "Content-Type":"application/x-www-form-urlencoded" } ,
        body: { "username":username.text , "type":"mobile"},
        encoding: Encoding.getByName("utf-8"));
    List res=response.body.split("\n");
    print("yoo"+res[0]);
    if(res[0].toString().compareTo("<!DOCTYPE html>")==1)
    {Map dat;
    print(response.body);

    dat = json.decode(response.body);
    print(dat["count"]);
    if(dat["count"]!=0)
    {Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
    }
    else
    {
      Fluttertoast.showToast(
          msg: "Authentication Failed...Try Again...",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          textcolor:'#ffffff',
          bgcolor: '#FF3E4D'
      );
    }
    }
    return json.decode(response.body);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: AppBar(
          title: Text("Login",
            style: new TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold
            ),
          ),
          backgroundColor: Colors.blueAccent,
        ),
        body:   Builder(
          // Create an inner BuildContext so that the onPressed methods
          // can refer to the Scaffold with Scaffold.of().
            builder: (BuildContext context) {
              return new Container(
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  child: Card(
                    child: new Container(
                      padding: EdgeInsets.all(20.0),
                      height: 300.0,
                      width: 300.0,
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          new Image(
                            image: new AssetImage("Assets/logo.png"),
                            height: 100.0,
                            width: 100.0,
                          ),
                          new TextField(
                            controller: username,
                            decoration: new InputDecoration(
                                hintText: "Phone Number with Code",
                                icon: new Icon(Icons.phone)
                            ),
                          ),
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[

                              new RaisedButton(
                                onPressed: _loginapi_validate,
                                color: Colors.green,
                                child: new Text("Authenticate"),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
              );
            }
        )
    );
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState_final createState() => _LoginState_final();
}

class _LoginState_final extends State<Login> {
  TextEditingController username=new TextEditingController();
  TextEditingController password=new TextEditingController();
  Future<Null> _loginapi() async {
    var url=Constants().LOGIN;
    var response=await request(url);
    print(response);
  }
  Future<Map> request(var url) async {
    http.Response response=await http.post(url,headers:{ "Content-Type":"application/x-www-form-urlencoded" } ,
        body: { "username":username.text ,"password":password.text },
        encoding: Encoding.getByName("utf-8"));
    List res=response.body.split("\n");
    print("yoo"+res[0]);
    if(res[0].toString().compareTo("<!DOCTYPE html>")==1)
    {Map dat;
    print(response.body);

    dat = json.decode(response.body);
    print(dat["count"]);
    if(dat["count"]!=0)
    {

      saveValues() async {
        final prefs = await SharedPreferences.getInstance();
        prefs.setString("id", dat["id"]);
        prefs.setString("name", dat["name"]);
        prefs.setString("pic", dat["pic"]);
        prefs.setBool("login", true);
        print("INSIDE SAVE"+dat["name"]);
      }
      saveValues();
      Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FetchDetails()),
    );
    }
    else
    {
      Fluttertoast.showToast(
          msg: "Authentication Failed...Try Again...",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          textcolor:'#ffffff',
          bgcolor: '#FF3E4D'
      );
    }
    }
    return json.decode(response.body);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: Text("Login",
          style: new TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body:  new Container(
          color: Colors.transparent,
          alignment: Alignment.center,
          child: Card(
            child: new Container(
              padding: EdgeInsets.all(20.0),
              height: 300.0,
              width: 300.0,
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new Image(
                    image: new AssetImage("Assets/logo.png"),
                    height: 100.0,
                    width: 100.0,
                  ),
                  new TextField(
                    controller: username,
                    decoration: new InputDecoration(
                        hintText: "Username",
                        icon: new Icon(Icons.lock)
                    ),
                  ),new TextField(
                    controller: password,
                    obscureText: true,
                    decoration: new InputDecoration(
                        hintText: "OTP",
                        icon: new Icon(Icons.person)
                    ),
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[

                      new RaisedButton(
                        onPressed: _loginapi,
                        color: Colors.green,
                        child: new Text("LOGIN"),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
      ),
    );
  }
}
_displaySnackBar(BuildContext context) {
  final snackBar = SnackBar(content: Text('Are you talkin\' to me?'));
  Scaffold.of(context).showSnackBar(snackBar);
}

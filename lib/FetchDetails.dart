import 'dart:async';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mcbs_dialcontacts/Contact.dart';
import 'package:mcbs_dialcontacts/Email.dart';
import 'package:mcbs_dialcontacts/MainScreen.dart';
import 'package:mcbs_dialcontacts/Phone.dart';
import 'database.dart';
import 'package:mcbs_dialcontacts/Constants.dart';
import 'package:mcbs_dialcontacts/MainClass.dart';
import 'package:shared_preferences/shared_preferences.dart';



import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class FetchDetails extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<FetchDetails> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: AddData()
    );

  }
}

class AddData extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<AddData> {

  String id;
  getSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString("id");
    print("JISJEPJISJIEIJSIJSIJSIJSIJSIJSJS"+id);

  }

  TextEditingController username=new TextEditingController();
  var count=DBHelper().getMainCount();

  void _loginapi_validate() async{


      await getSharedPreferences();
      if (count== 0){
        _loginapi();
      }
      else
        {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MainScreen()),
          );
          //MAIN SCREEN
        }
    }
  Future<Null> _loginapi() async {
    var data = {"id": id};
    var url = Constants().FETCH_MAIN;
    print((data));
    var response = await request(url, json.encode(data));
    print(response);
    _loginapi1();


  }
  Future<Map> request(var url, var data) async {
    http.Response response=await http.post(url,headers:{ "Content-Type":"application/x-www-form-urlencoded" } ,
        body: {"id": id},
        encoding: Encoding.getByName("utf-8"));
    List res=response.body.split("\n");
    print("yoooooooooooooooooo"+res[0]);
    if(res[0].toString().compareTo("<!DOCTYPE html>")==1)
    {var dat;
    print(response.body);
    dat = jsonDecode(response.body);
  for(int i=0;i<dat.length;i++){
    MainClass m=MainClass(dat[i]["id"],dat[i]["header"],dat[i]["name"],dat[i]["pic"]);
    DBHelper().saveMain(m);
  }

    }
    return null;
  }


  Future<Null> _loginapi1() async {
    var data = {"id": id};
    var url = Constants().FETCH_CONTACTS;
    print((data));
    var response = await request1(url, json.encode(data));
    print(response);
    _loginapi2();



  }
  Future<Map> request1(var url, var data) async {
    http.Response response=await http.post(url,headers:{ "Content-Type":"application/x-www-form-urlencoded" } ,
        body: {"id": id},
        encoding: Encoding.getByName("utf-8"));
    List res=response.body.split("\n");
    print("yoooooooooooooooooo"+res[0]);
    if(res[0].toString().compareTo("<!DOCTYPE html>")==1)
    {var dat;
    print(response.body);
    dat = jsonDecode(response.body);
    for(int i=0;i<dat.length;i++){
      Contact m=Contact(dat[i]["id"],dat[i]["name"],dat[i]["role"],dat[i]["header"],dat[i]["dept"],dat[i]["address"],dat[i]["pic"]);
      DBHelper().saveContact(m);
    }
    }
    return null;
  }

  Future<Null> _loginapi2() async {
    var data = {"id": id};
    var url = Constants().FETCH_PHONE;
    print((data));
    var response = await request2(url, json.encode(data));
    print(response);
    _loginapi3();



  }
  Future<Map> request2(var url, var data) async {
    http.Response response=await http.post(url,headers:{ "Content-Type":"application/x-www-form-urlencoded" } ,
        body: {"id": id},
        encoding: Encoding.getByName("utf-8"));
    List res=response.body.split("\n");
    print("yoooooooooooooooooo"+res[0]);
    if(res[0].toString().compareTo("<!DOCTYPE html>")==1)
    {var dat;
    print(response.body);
    dat = jsonDecode(response.body);
    for(int i=0;i<dat.length;i++){
      Phone m=Phone(dat[i]["iid"],dat[i]["id"],dat[i]["dept"],dat[i]["num"],dat[i]["type"]);
      DBHelper().savePhone(m);
    }
    }
    return null;
  }
  Future<Null> _loginapi3() async {
    var data = {"id": id};
    var url = Constants().FETCH_EMAIL;
    print((data));
    var response = await request3(url, json.encode(data));
    print(response);
    _loginapi4();



  }
  Future<Map> request3(var url, var data) async {
    http.Response response=await http.post(url,headers:{ "Content-Type":"application/x-www-form-urlencoded" } ,
        body: {"id": id},
        encoding: Encoding.getByName("utf-8"));
    List res=response.body.split("\n");
    print("yoooooooooooooooooo"+res[0]);
    if(res[0].toString().compareTo("<!DOCTYPE html>")==1)
    {var dat;
    print(response.body);
    dat = jsonDecode(response.body);
    for(int i=0;i<dat.length;i++){
      Email m=Email(dat[i]["iid"],dat[i]["id"],dat[i]["dept"],dat[i]["email"],dat[i]["type"]);
      DBHelper().saveEmail(m);
    }
    }
    return null;
  }
void _loginapi4(){

}
  @override
  Widget build(BuildContext context) {
    print(id);
    _loginapi_validate();
    // TODO: implement build
    return new Scaffold(
        appBar: AppBar(
          title: Text("Fetching Details",
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
                    child: new Scaffold(
                      body: Text("Fetching Data Please Wait..."),
                    )
                  )
              );
            }
        )
    );
  }
}

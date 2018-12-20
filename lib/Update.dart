
import 'dart:async';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mcbs_dialcontacts/Contact.dart';
import 'package:mcbs_dialcontacts/Email.dart';
import 'package:mcbs_dialcontacts/MainScreen.dart';
import 'package:mcbs_dialcontacts/Phone.dart';
import 'package:mcbs_dialcontacts/main.dart';
import 'database.dart';
import 'package:mcbs_dialcontacts/Constants.dart';
import 'package:mcbs_dialcontacts/MainClass.dart';
import 'package:shared_preferences/shared_preferences.dart';



import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class Update extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _MyAppState extends State<Update> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: AddData()
    );
  }
}
bool flag;
class AddData extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}
reload(BuildContext context) async {
  if(flag==true){
    print("-------------------------"+flag.toString());
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MainScreen()),

    );
  }
}
class _LoginState extends State<Update> {

  int count;
  BuildContext _context;
  String id;
  getSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString("id");

  }

  TextEditingController username=new TextEditingController();


  @override
  Widget build(BuildContext context) {
    print(id);
    if(flag==true){
      return MainScreen();
    }else {
      // TODO: implement build
      return MaterialApp(
          home: Scaffold(

              body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[ Container(
                      padding: EdgeInsets.all(30.0),
                      color: Colors.transparent,
                      alignment: Alignment.center,
                      child:
                      new Center(child: new CircularProgressIndicator(
                        value: null,
                        strokeWidth: 20.0,
                      ),


                      )), Text("Loading...Please Wait....")
                  ])
          )
      );
    }

  }
  void _loginapi_validate() async{
    await DBHelper().clear_Table();
    flag=false;
    await getSharedPreferences();
    await _loginapi();

  }
  Future<String> _loginapi() async {
    var data = {"id": id};
    var url = Constants().FETCH_MAIN;
    print((data));
    var response = await request(url, json.encode(data));
    print(response);



  }
  Future<String> request(var url, var data) async {
    http.Response response=await http.post(url,headers:{ "Content-Type":"application/x-www-form-urlencoded" } ,
        body: {"id": id},
        encoding: Encoding.getByName("utf-8")).then((var response){
      List res=response.body.split("\n");
      if(res[0].toString().compareTo("<!DOCTYPE html>")==1) {
        var dat;
        print(response.body);
        dat = jsonDecode(response.body);
        for (int i = 0; i < dat.length; i++) {
          MainClass m = MainClass(
              dat[i]["id"], dat[i]["header"], dat[i]["name"], dat[i]["pic"]);
          DBHelper().saveMain(m);
        }

      }
      _loginapi1();
    });
    return response.toString();
  }


  Future<String> _loginapi1() async {
    var data = {"id": id};
    var url = Constants().FETCH_CONTACTS;
    print((data));
    var response = await request1(url, json.encode(data));
    print(response);



  }
  Future<String> request1(var url, var data) async {
    http.Response response=await http.post(url,headers:{ "Content-Type":"application/x-www-form-urlencoded" } ,
        body: {"id": id},
        encoding: Encoding.getByName("utf-8")).then((var response){
      List res=response.body.split("\n");
      if(res[0].toString().compareTo("<!DOCTYPE html>")==1)
      {var dat;
      print(response.body);
      dat = jsonDecode(response.body);
      for(int i=0;i<dat.length;i++){
        Contact m=Contact(dat[i]["id"].toString(),dat[i]["name"],dat[i]["role"],dat[i]["header"],dat[i]["dept"],dat[i]["address"],dat[i]["pic"]);
        DBHelper().saveContact(m);
      }
      }
      _loginapi2();
    });
    return response.toString();
  }

  Future<String> _loginapi2() async {
    var data = {"id": id};
    var url = Constants().FETCH_PHONE;
    print((data));
    var response = await request2(url, json.encode(data));
    print(response);

  }
  Future<String> request2(var url, var data) async {
    http.Response response=await http.post(url,headers:{ "Content-Type":"application/x-www-form-urlencoded" } ,
        body: {"id": id},
        encoding: Encoding.getByName("utf-8")).then((var response){
      List res=response.body.split("\n");
      if(res[0].toString().compareTo("<!DOCTYPE html>")==1)
      {var dat,type;
      print(response.body);
      dat = jsonDecode(response.body);
      for(int i=0;i<dat.length;i++){
        if(dat[i]["type"].toString()=="0") {
          type = "Mobile";
        }
        else{
          type="Landline";
        }
        Phone m=Phone(dat[i]["iid"].toString(),dat[i]["id"].toString(),dat[i]["dept"],dat[i]["num"],type);
        DBHelper().savePhone(m);
      }
      }
      _loginapi3();

    });
    return response.toString();
  }
  Future<String> _loginapi3() async {
    var data = {"id": id};
    var url = Constants().FETCH_EMAIL;
    print((data));
    var response = await request3(url, json.encode(data));
    print(response);




  }
  Future<String> request3(var url, var data) async {
    http.Response response=await http.post(url,headers:{ "Content-Type":"application/x-www-form-urlencoded" } ,
        body: {"id": id},
        encoding: Encoding.getByName("utf-8")).then((var response){
      List res=response.body.split("\n");
      if(res[0].toString().compareTo("<!DOCTYPE html>")==1) {
        var dat, type;
        print(response.body);
        dat = jsonDecode(response.body);
        for (int i = 0; i < dat.length; i++) {
          if (dat[i]["type"].toString() == "0") {
            type = "Official";
            print("Official");
          }
          else {
            type = "Personal";
            print("Personal");
          }
          Email m = Email(
              dat[i]["iid"].toString(), dat[i]["id"].toString(), dat[i]["dept"],
              dat[i]["email"], type);
          DBHelper().saveEmail(m);
        }
      }
      _loginapi4();});
    return response.toString();
  }
  void _loginapi4()  {

    print("9090900909090909090909090");
    setState ( () {
      flag = true;

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loginapi_validate();
  }

}

import 'package:flutter/material.dart';
import 'package:mcbs_dialcontacts/Contact.dart';
import 'package:mcbs_dialcontacts/Email.dart';
import 'package:mcbs_dialcontacts/MainClass.dart';
import 'package:mcbs_dialcontacts/SpeakerProfile_Others.dart';
import 'package:mcbs_dialcontacts/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

Contact header;
class test extends StatefulWidget {

  test(Contact _header){
    header=_header;
  }
  @override
  _ListViewState createState() => new _ListViewState();
}

class _ListViewState extends State<test> {
  List<Email> items = new List();
  String NAME;
  Future getSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    NAME = prefs.getString("name");
    setState(() {

    });
  }


  @override
  void initState() {
    super.initState();
    getSharedPreferences();
    void _loginapi_validate() async {
      items = await DBHelper().getEmail(header);
      setState(() { });

      print("JIS inside init"+items.toString());
    }
    _loginapi_validate();
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
          backgroundColor: const Color(0x66075e54),
          body: Center(
              child: SafeArea(child:
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:<Widget>[

                    Padding(padding: EdgeInsets.all(10.0),child:Text("Email",style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold

                    ))),
                    Expanded(child:
                    ListView.builder(
                        itemCount: items.length,
                        padding: const EdgeInsets.all(15.0),
                        itemBuilder: (context, position) {
                          return Container(
                              child:Column(
                                children: <Widget>[
                                  Divider(height: 3.0),
                                  ListTile(
                                    title: Text(
                                      '${items[position].email}',
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.white

                                      ),
                                    ),
                                    leading: Column(
                                      children: <Widget>[
                                        Padding(padding: EdgeInsets.only(top: 0.0),
                                          child: Icon(Icons.email, color: Colors.white
                                          ),
                                        )
                                      ],
                                    ),
                                    onTap: () =>_onTapItem(items[position]),
                                  ),
                                ],
                              )
                          );
                        }),)
                  ]),
              )
          )

      );
  }

  void _onTapItem( Email Contact) {
    Scaffold
        .of(context)
        .showSnackBar(new SnackBar(
        content: new Text(Contact.id.toString() + ' - ' + Contact.email)));
  }
}

import 'package:flutter/material.dart';
import 'package:mcbs_dialcontacts/Contact.dart';
import 'package:mcbs_dialcontacts/Email.dart';
import 'package:mcbs_dialcontacts/MainClass.dart';
import 'package:mcbs_dialcontacts/Phone.dart';
import 'package:mcbs_dialcontacts/database.dart';
import 'package:mcbs_dialcontacts/test.dart';
import 'package:mcbs_dialcontacts/test_num.dart';
import 'package:shared_preferences/shared_preferences.dart';

Contact m;
class ProfileDetail extends StatefulWidget {
  @override
  ProfileDetail(Contact mm){
    m=mm;
  }
  _ListViewState createState() => new _ListViewState();
}

class _ListViewState extends State<ProfileDetail> {
  List<Contact> items = new List();
  List<Phone> item1 = new List();
  List<Email> item2 = new List();
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
      items = await DBHelper().getContacts_details(m.header,m.name,m.dept);
      item1 = await DBHelper().getPhone(m);
      item2 = await DBHelper().getEmail(m);
      setState(() { });

    }
    _loginapi_validate();
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
    double c_width = MediaQuery.of(context).size.width*0.6;

    print("ITEM 1 LENGTH="+item1.length.toString());
    return new WillPopScope(
        onWillPop:() async => false,
        child:MaterialApp(
        home:  SafeArea(
            bottom: true,
            child: Scaffold(
            appBar: AppBar(
                title: Text(NAME),
                backgroundColor: const Color(0xFF075e54),
                iconTheme: IconThemeData(
                  color: Colors.white, //change your color here
                ),
                leading: new IconButton(
                  icon: new Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                )
            ),
            body:
            new SingleChildScrollView(
              child:Container(
            child:
              Column(
                  children:<Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: <Widget>[
                        Padding(
              padding:EdgeInsets.only(top: 0.0),

                 child:FadeInImage
                    (
                      placeholder: AssetImage("Assets/logo.png"),
                      image: NetworkImage(m.pic),
                    height: 500,fit: BoxFit.fill,
                  )



                        ),
                        Container(
                            alignment: Alignment.center,
                            decoration:new BoxDecoration( color: const Color(0x99075e54)),
                            child:
                        Padding(
                            padding: EdgeInsets.all(10.0),
                            child:Text(m.name,style: TextStyle(
                            fontSize: 25.0,
                            color: Colors.white,
                              fontWeight: FontWeight.bold


                        ))
                        )
                        )
                      ],
                    )
                    ,Container(
                        decoration: new BoxDecoration(color: const Color(0x99075e54)),

                        height: item1.length*140.0,
                      padding: EdgeInsets.all(10.0),
                      alignment: Alignment.center ,
                      child:test_num(m)

                    ),Container(
                        decoration: new BoxDecoration(color: const Color(0x99075e54)),

                        height: (item2.length)*140.0,
                        padding: EdgeInsets.all(10.0),
                        alignment: Alignment.center ,
                        child: test(m)

                    ),Container(
                        decoration: new BoxDecoration(color: const Color(0xFF075e54)),

                        height: c_width,
                        padding: EdgeInsets.all(20.0),
                        alignment: Alignment.center ,
                        child:  Scaffold(
                          backgroundColor: const Color(0xFF075e54),
                          body:Center(
                            child:Container(
                              padding: EdgeInsets.all(10.0),
                              decoration: new BoxDecoration(color: const Color(0xFF075e54)),
                              child:Column(
                                children: <Widget>[
                                  Padding(padding:EdgeInsets.only(bottom: 20.0),
                              child:Text("Address",style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold

                              ))),
                            Text(m.adddress,style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white
                            )
                        ),]
                              )  )
                          )
                        )

                    )


                  ]
              ),
              )
            )
        )  ))
    );
  }

  void _onTapItem(BuildContext context, Phone Contact) {
    Scaffold
        .of(context)
        .showSnackBar(new SnackBar(
        content: new Text(Contact.id.toString() + ' - ' + Contact.num)));
  }
}

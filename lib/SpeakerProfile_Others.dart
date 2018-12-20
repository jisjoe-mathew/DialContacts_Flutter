import 'package:flutter/material.dart';
import 'package:mcbs_dialcontacts/Contact.dart';
import 'package:mcbs_dialcontacts/MainClass.dart';
import 'package:mcbs_dialcontacts/ProfileDetail.dart';
import 'package:mcbs_dialcontacts/database.dart';
import 'package:mcbs_dialcontacts/test.dart';
import 'package:shared_preferences/shared_preferences.dart';

MainClass m;
class SpeakerProfile_Others extends StatefulWidget {
  @override
  SpeakerProfile_Others(MainClass mm){
    m=mm;
  }
  _ListViewState createState() => new _ListViewState();
}

class _ListViewState extends State<SpeakerProfile_Others> {
  List<Contact> items = new List();
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
        items = await DBHelper().getContacts_dept_header(m.header,m.name);
        setState(() { });

        print("JIS inside init"+items.toString());
      }
      _loginapi_validate();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
        body: Center(
          child: SafeArea(child: ListView.builder(
              itemCount: items.length,
              padding: const EdgeInsets.all(15.0),
              itemBuilder: (context, position) {
                return Column(
                  children: <Widget>[
                    Divider(height: 5.0),
                    ListTile(
                      title: Text(
                        '${items[position].name}',
                        style: TextStyle(
                          fontSize: 20.0,

                        ),
                      ),
                      subtitle: Text(
                        '${items[position].role}',
                        style: new TextStyle(
                          fontSize: 16.0,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      leading: Column(
                        children: <Widget>[
                          Padding(padding: EdgeInsets.only(top: 0.0),
                            child: GestureDetector(
                                onTap: (){
                                  showDialog<void>(
                                    context: context,
                                    barrierDismissible: true, // user must tap button!
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(items[position].name,style:TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold

                                        ),
                                        ),
                                        content: new Image(
                                            image: NetworkImage(items[position].pic)),
                                      );
                                    },
                                  );
                                  }
                                  ,
                                child:CircleAvatar(
                            backgroundImage: NetworkImage(items[position].pic),

                            radius: 25.0,


                                )
                            )
                          ),
                        ],
                      ),
                      onTap: () => _onTapItem(items[position]),
                    ),
                  ],
                );
              }),
        ),)
      ),
    );
  }

  void _onTapItem(Contact Contact) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfileDetail(Contact)),
    );
  }

}

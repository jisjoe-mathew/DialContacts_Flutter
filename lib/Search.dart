import 'package:flutter/material.dart';
import 'package:mcbs_dialcontacts/Contact.dart';
import 'package:mcbs_dialcontacts/MainScreen.dart';
import 'package:mcbs_dialcontacts/ProfileDetail.dart';
import 'package:mcbs_dialcontacts/database.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Retrieve Text Input',
      home: MyCustomForm(),
    );
  }
}

// Define a Custom Form Widget
class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

// Define a corresponding State class. This class will hold the data related to
// our Form.
class _MyCustomFormState extends State<MyCustomForm> {
  // Create a text controller. We will use it to retrieve the current value
  // of the TextField!
  List<Contact> items = new List();
  String NAME;

  Future getSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    NAME = prefs.getString("name");
    setState(() {

    });
  }

  final myController = TextEditingController();
  String text="jis";
  @override
  void initState() {
    super.initState();

    myController.addListener(_printLatestValue);
    getSharedPreferences();
    void _loginapi_validate() async {
      items = await DBHelper().search(myController.text);
      setState(() { });

      print("JIS inside init"+items.toString());
    }
    _loginapi_validate();
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    // This also removes the _printLatestValue listener
    myController.dispose();
    super.dispose();
  }

  _printLatestValue() async {
    print("Second text field: ${myController.text}");
    text=myController.text;
    items = await DBHelper().search(myController.text);

    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(NAME),
          backgroundColor: const Color(0xFF075e54),
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MainScreen()),
            ),
          )
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[

            TextField(
              controller: myController,
            ), Expanded(child:ListView.builder(
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
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(items[position].pic),
                                    radius: 25.0,

                                  )

                              ),
                            ],
                          ),
                          onTap: () => _onTapItem(items[position]),
                        ),
                      ],
                    );
                  },
              )
            )],
        ),
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
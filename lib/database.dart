import 'dart:async';
import 'dart:io' as io;
import 'package:mcbs_dialcontacts/Contact.dart';
import 'package:mcbs_dialcontacts/Email.dart';
import 'package:mcbs_dialcontacts/MainClass.dart';
import 'package:mcbs_dialcontacts/Phone.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper{

  static Database _db;

  Future<Database> get db async {
    if(_db != null)
      return _db;
    _db = await initDb();
    return _db;
  }

  //Creating a database with name test.dn in your directory
  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "test.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  // Creating a table name Contact with fields
  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute("CREATE TABLE main (id TEXT, header TEXT,name TEXT,pic TEXT)");
    await db.execute("CREATE TABLE contacts (id TEXT, name TEXT, role TEXT, header TEXT, dept TEXT,address TEXT, pic TEXT)");
    await db.execute("CREATE TABLE phone (iid TEXT, id TEXT, dept TEXT, num TEXT, type TEXT)");
    await db.execute("CREATE TABLE email (iid TEXT, id TEXT, dept TEXT, email TEXT, type TEXT)");
    await db.execute("CREATE TABLE upd (datetim TEXT)");
    await db.execute("CREATE TABLE latln (id TEXT, lat TEXT, lng TEXT)");
    await db.execute("CREATE TABLE news (id TEXT, name TEXT, msg TEXT,date TEXT)");
    print("Created tables");
  }

  // Retrieving Contacts from Contact Tables
  Future<List<Contact>> getContacts() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM contacts');
    print("LIST LENGTH+"+list.length.toString());
    List<Contact> Contacts = new List();
    for (int i = 0; i < list.length; i++) {
      Contacts.add(new Contact(list[i]["id"].toString(), list[i]["name"], list[i]["role"], list[i]["header"], list[i]["dept"], list[i]["address"], list[i]["pic"]));
    }
    print("LEN---------------"+Contacts.length.toString());
    return Contacts;
  }

  Future<List<Contact>> getContacts_dept(String dept) async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery("SELECT * FROM contacts where header='"+dept+"'");
    print("LIST LENGTH+"+list.length.toString());
    List<Contact> Contacts = new List();
    for (int i = 0; i < list.length; i++) {
      if(!(list[i]["name"]  ==("Test User Admin") || list[i]["name"]==("Test2 (t2)") || list[i]["name"]==("Test3 (t3)")))
      Contacts.add(new Contact(list[i]["id"].toString(), list[i]["name"], list[i]["role"], list[i]["header"], list[i]["dept"], list[i]["address"], list[i]["pic"]));
    }
    print("LEN---------------"+Contacts.length.toString());
    return Contacts;
  }

  void saveContact(Contact Contact) async {
    var dbClient = await db;
    await dbClient.transaction((txn) async {
      return await txn.rawInsert(
          "INSERT INTO contacts(id, name, role, header, dept, address, pic ) VALUES(" +
              '\'' +
              Contact.id.toString() +
              '\'' +
              ',' +
              '\'' +
              Contact.name +
              '\'' +
              ',' +
              '\'' +
              Contact.role +
              '\'' +
              ',' +
              '\'' +
              Contact.header +
              '\'' +
              ',' +
              '\'' +
              Contact.dept +
              '\'' +
              ',' +
              '\'' +
              Contact.adddress +
              '\'' +
              ',' +
              '\'' +
              Contact.pic +
              '\'' +
              ')');
    });
  }

  Future<List<MainClass>> getMain(String header) async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery("SELECT * FROM main where header='"+header+"' order by name");
    List<MainClass> Contacts = new List();
    for (int i = 0; i < list.length; i++) {
      Contacts.add(new MainClass(list[i]["id"].toString(), list[i]["header"], list[i]["name"], list[i]["pic"]));
    }
    print("Lengthhhhhhhhhhhhhhh"+Contacts.length.toString());
    return Contacts;
  }
  Future<int> getMainCount() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM main');
    List<MainClass> Contacts = new List();
    for (int i = 0; i < list.length; i++) {
      Contacts.add(new MainClass(list[i]["id"].toString(), list[i]["header"], list[i]["name"], list[i]["pic"]));
    }
    print(Contacts.length);
    return Contacts.length;
  }

  void saveMain(MainClass Contact) async {
    var dbClient = await db;
    await dbClient.transaction((txn) async {
      return await txn.rawInsert(
          'INSERT INTO main(id, header, name,  pic ) VALUES(' +
              '\'' +
              Contact.id.toString() +
              '\'' +
              ',' +
              '\'' +
              Contact.header +
              '\'' +
              ',' +
              '\'' +
               Contact.name +
              '\'' +
              ',' +
              '\'' +
              Contact.pic +
              '\'' +
              ')');
    });
  }

  Future<List<Phone>> getPhone() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM phone');
    List<Phone> Contacts = new List();
    for (int i = 0; i < list.length; i++) {
      Contacts.add(new Phone(list[i]["iid"].toString(), list[i]["id"].toString(), list[i]["dept"], list[i]["num"], list[i]["type"]));
    }
    print(Contacts.length);
    return Contacts;
  }

  void savePhone(Phone Contact) async {
    var dbClient = await db;
    await dbClient.transaction((txn) async {
      return await txn.rawInsert(
          'INSERT INTO phone(iid, id, dept, num, type ) VALUES(' +
              '\'' +
              Contact.iid.toString() +
              '\'' +
              ',' +
              '\'' +
              Contact.id.toString() +
              '\'' +
              ',' +
              '\'' +
              Contact.dept +
              '\'' +
              ',' +
              '\'' +
              Contact.num +
              '\'' +
              ',' +
              '\'' +
              Contact.type.toString() +
              '\'' +
              ')');
    });
  }

  Future<List<Email>> getEmail() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM email');
    List<Email> Contacts = new List();
    for (int i = 0; i < list.length; i++) {
      Contacts.add(new Email(list[i]["iid"], list[i]["id"], list[i]["dept"], list[i]["email"], list[i]["type"]));
    }
    print(Contacts.length);
    return Contacts;
  }

  void saveEmail(Email Contact) async {
    var dbClient = await db;
    await dbClient.transaction((txn) async {
      return await txn.rawInsert(
          'INSERT INTO email(iid, id, dept, email, type ) VALUES(' +
              '\'' +
              Contact.iid.toString() +
              '\'' +
              ',' +
              '\'' +
              Contact.id.toString() +
              '\'' +
              ',' +
              '\'' +
              Contact.dept +
              '\'' +
              ',' +
              '\'' +
              Contact.email +
              '\'' +
              ',' +
              '\'' +
              Contact.type.toString() +
              '\'' +
              ')');
    });
  }
}
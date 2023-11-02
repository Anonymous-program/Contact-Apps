import 'package:contact_app/models/contact_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as Path;

class SqliteHelper {
  static const String _createTableContact = '''
  create table $tblContact(
  $tblContactColId integer primary key autoincrement,
  $tblContactColName text not null,
  $tblContactColCompanyName text not null,
  $tblContactColDesignation text not null,
  $tblContactColAddress text not null,
  $tblContactColMobile text not null,
  $tblContactColEmail text not null,
  $tblContactColWebsite text not null,
  $tblContactColFavorite integer not null
  )''';
  static Future<Database> _open() async {
    final rootPath = await getDatabasesPath();
    final dbPath = Path.join(rootPath, 'contact.db');
    return openDatabase(dbPath, version: 1, onCreate: (db, version) async {
      db.execute(_createTableContact);
    });
  }

  static Future<int> insertNewContact(ContactModel contactModel) async {
    final db = await _open();
    return db.insert(tblContact, contactModel.toMap());
  }

  static Future<List<ContactModel>> getAllContacts() async {
    final db = await _open();
    final mapList = await db.query(tblContact);
    return List.generate(
        mapList.length, (index) => ContactModel.fromMap(mapList[index]));
  }

  static Future<ContactModel> getContactById(int id) async {
    final db = await _open();
    final mapList = await db
        .query(tblContact, where: '$tblContactColId=?', whereArgs: [id]);
    return ContactModel.fromMap(mapList.first);
  }
}

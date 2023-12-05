import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class dbclass {
  Future<Database> db() async {
    var database;
    // Sqf
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'dbcrud1');
    database = await openDatabase(path, version: 1, onCreate: _oncreatedb);
    return database;
  }

  Future<void> _oncreatedb(Database database, int version) async {
    String s =
        "CREATE TABLE users (id INTEGER PRIMARY KEY,name TEXT,description TEXT,date TEXT);";
    await database.execute(s);
  }
}

import 'package:sqflite/sqflite.dart';
import 'package:sqliteflutter/dbclass.dart';

class repository {
  late dbclass connection;
  repository() {
    connection = dbclass();
  }
  static Database? connection1;
  Future<Database?> get database async {
    if (connection1 != null) {
      return connection1;
    } else {
      connection1 = await connection.db();
      return connection1;
    }
  }

  InsertData(table, data) async {
    var conn = await database;
    return await conn?.insert(table, data);
  }

  ReadAll(table) async {
    var conn = await database;
    return await conn?.query(table);
  }

  ReadSingleData(table, id) async {
    var conn = await database;
    return await conn?.query(table, where: 'id=?', whereArgs: [id]);
  }

  UpdateData(table, data) async {
    var conn = await database;
    return await conn
        ?.update(table, data, where: 'id=?', whereArgs: [data['id']]);
  }

  DeleteData(table, id) async {
    var conn = await database;
    return await conn?.rawDelete("delete from $table where id=$id");
  }
}

import 'package:sqflite/sqflite.dart';

import 'dataBase_connection.dart';

class Repository {
  DatabaseConnection? _databaseConnection;

  Repository() {
    _databaseConnection = DatabaseConnection();
  }

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _databaseConnection!.setDatabase();
    return _database!;
  }

  insertData(table, data) async {
    var connection = await database;
    return await connection.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  readData(table) async {
    var connection = await database;
    return await connection.query(table);
  }

  readDataId(table, itemId) async {
    var connection = await database;
    return await connection.query(table, where: 'id=?', whereArgs: [itemId]);
  }

  updateData(table, data) async {
    var connection = await database;
    return await connection.rawUpdate('UPDATE $table WHERE id = ?', [
      data['id'],
    ]);
  }

  deleteData(table, itemId) async {
    var connection = await database;
    return await connection.rawDelete("DELETE FROM $table WHERE id=$itemId");
  }

  deleteAllData(table) async {
    var connection = await database;
    return await connection.rawDelete("DELETE FROM $table");
  }
}

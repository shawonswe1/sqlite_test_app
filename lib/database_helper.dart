
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper{

  static const _dbName = 'myDatabase.db';
  static const _dbVersion = 1;
  static const _tableName = 'myTable';

  static const colId = '_id';
  static const colName = 'Name';

  static Future<Database> initDB()async{
    var dbPath = await getDatabasesPath();
    String path = join(dbPath,_dbName);
    return await openDatabase(path,version: _dbVersion,onCreate: _onCreate);
  }

 //  //making it a singleton class
 //  DatabaseHelper._privateConstructor();
 //  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
 //
 //  static late final Database _database;
 //  Future<Database> get database async{
 //    _database = await _initiateDatabase();
 // return _database;
 //    _database = await _initiateDatabase();
 //    return _database;
 //  }
 //
 //  _initiateDatabase() async{
 //    Directory directory = await getApplicationDocumentsDirectory();
 //    String path = join(directory.path,_dbName);
 //    // String path = directory.path;
 //    await openDatabase(path,version: _dbVersion,onCreate: _onCreate);
 //
 //  }

  static Future _onCreate(Database db,int version) async{
    await db.execute(
      '''
       CREATE TABLE $_tableName(
       $colId INTEGER PRIMARY KEY,
       $colName TEXT
       )
      '''

    );
  }

  // Future<int> insert(Map<String,dynamic> row) async{
  //   Database db = await instance.database;
  //   return await db.insert(_tableName, row);
  // }
  static Future<int?> insert(String title,) async{
    // Database db = await instance.database;
    Database db = await DatabaseHelper.initDB();
    final data = {'Name':title};
    return await db.insert(_tableName, data);
  }

  static Future<List<Map<String,dynamic>>> queryAll() async{
    // Database db = await instance.database;
    Database db = await DatabaseHelper.initDB();
    return await db.query(_tableName);
  }

  Future<int> update(Map<String,dynamic> row) async{
    // Database db = await instance.database;
    Database db = await DatabaseHelper.initDB();
    int id = row[colId];
    return await db.update(_tableName, row,where: '$colId = ?',whereArgs: [id]);
  }

  Future<int> delete(id) async{
    // Database db = await instance.database;
    Database db = await DatabaseHelper.initDB();
    return await db.delete(_tableName,where: '$colId = ?',whereArgs: [id]);
  }


}
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'Data.dart' as data;
import 'dart:async';
import 'dart:io' as io;

class SqliteDB {
  static final SqliteDB _instance = new SqliteDB.internal();
  static Database _db;
  factory SqliteDB() => _instance;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDB();
    return _db;
  }

  SqliteDB.internal();

  initDB() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "MMDB.db");
    var taskDB = openDatabase(path, version: 1);
    return taskDB;
  }

  Future countTable() async {
    var dbClient = await db;
    var res =
        await dbClient.rawQuery("""SELECT count(*) as count FROM sqlite_master
         WHERE type = 'table' 
         AND name != 'android_metadata' 
         AND name != 'sqlite_sequence';""");
    return res[0]['count'];
  }
}

Future createTable() async {
  var dbClient = await SqliteDB().db;
  var res = await dbClient.execute(""" 
  CREATE TABLE TransactionsBase(
    id INTEGER,
    note TEXT,
    price INTEGER,
    destenationAccount TEXT,
    extraNote TEXT,
    originAccount TEXT,
    day INTEGER,
    month INTEGER,
    year INTEGER,
    hour INTEGER,
    minute INTEGER,
    transactionType TEXT)""");
  return res;
}

Future checkTableExist()async{
    // ignore: unused_local_variable
    var creator;
    int tableCounter;
    try {
      final db = SqliteDB();
      tableCounter = await db.countTable();
    } catch (e) {
      print('Error1: $e');
    }

    if (tableCounter == 0) {
      try {
        creator = await createTable();
      } catch (e) {
        print('Error2: $e');
      }
    }
}

Future insertTranscation(data.Transaction transaction) async {
  dynamic temp = transaction.toMap();
  print(temp);
  // var a = DateTime.parse('2020-09-20 23:56');
  // print('a = $a');
  final dbClient = await SqliteDB().db;
  final res = await dbClient.insert("TransactionsBase", temp);
  return res;
}

Future readSQL() async {
  var dbClient = await SqliteDB().db;
  final res = dbClient.rawQuery("SELECT * FROM TransactionsBase");
  return res;
}

Future getNumberOfRows() async {
  var dbClient = await SqliteDB().db;
  final res = dbClient.rawQuery("SELECT COUNT(*) FROM TransactionsBase");
  return res;
}

Future deleteDataBaseFile() async {
  io.Directory documentDirectory = await getApplicationDocumentsDirectory();
  String path = join(documentDirectory.path, "MMDB.db");
  final file = io.File(path);
  try {
    file.delete();
  } catch (e) {
    print('Delete Error : $e');
  }
}

import 'dart:async';
import 'dart:io';

import 'package:flutter_application_3/assets/models/Fav_Model.dart';
import 'package:flutter_application_3/assets/models/task_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class AgendaDB {
  static final nameDB = 'AGENDADB';
  static final versionDB = 1;

  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database!;
    return _database = await _initDatabase();
  }

  Future<Database?> _initDatabase() async {
    Directory folder = await getApplicationDocumentsDirectory();
    String pathDB = join(folder.path, nameDB);
    return openDatabase(pathDB, version: versionDB, onCreate: _createTables);
  }

  FutureOr<void> _createTables(Database db, int version) {
    String query = '''CREATE TABLE tblTareas( 
      idTask INTEGER PRIMARY KEY,
      nameTask VARCHAR(50),
      dscTask VARCHAR(50),
      sttTask BYTE
    );''';
    String query2 = '''CREATE TABLE tblFav(
      idApi INT PRIMARY KEY,
      originalTitle TEXT,
      overview TEXT,
      posterPath TEXT,
      releaseDate TEXT,
      title TEXT,
      voteAverage DOUBLE
    );''';
    db.execute(query);
    db.execute(query2);
  }

  Future<int> INSERT(String tblName, Map<String, dynamic> data) async {
    var conexion = await database;
    return conexion!.insert(tblName, data);
  }

  Future<int> UPDATE(String tblName, Map<String, dynamic> data) async {
    var conexion = await database;
    return conexion!.update(tblName, data,
        where: 'idTask = ?', whereArgs: [data['idTask']]);
  }

  Future<int> DELETE(String tblName, int idTask) async {
    var conexion = await database;
    return conexion!.delete(tblName, where: 'idTask = ?', whereArgs: [idTask]);
  }

  Future<List<TaskModel>> GETALLTASK() async {
    var conexion = await database;
    var result = await conexion!.query('tblTareas');
    return result.map((task) => TaskModel.fromMap(task)).toList();
  }

//
//
//
//
//
//
  Future<int> INSERT_Fav(String tblName, Map<String, dynamic> data) async {
    var conexion = await database;
    return conexion!.insert(tblName, data);
  }

  Future<int> DELETE_Fav(String tblName, int idApi) async {
    var conexion = await database;
    return conexion!.delete(tblName, where: 'idApi = ?', whereArgs: [idApi]);
  }

  Future<List<FavModel>> GETALLMovies() async {
    var conexion = await database;
    var result = await conexion!.query('tblFav');
    return result.map((task) => FavModel.fromMap(task)).toList();
  }

  Future<bool> checkIfMovieExists(int movieId) async {
    var conexion = await database;
    var result = await conexion!.query(
      'tblFav',
      where: 'idApi = ?',
      whereArgs: [movieId],
    );
    return result.isNotEmpty;
  }
}

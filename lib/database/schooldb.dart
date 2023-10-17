import 'dart:async';
import 'dart:io';

import 'package:flutter_application_3/assets/models/Carrera_model.dart';
import 'package:flutter_application_3/assets/models/Profesor_model.dart';
import 'package:flutter_application_3/assets/models/Tarea_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class SchoolDB {
  static final nameDB = 'SCHOOLDB';
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
    String query = '''CREATE TABLE tblCarrera( 
      idCarrera INTEGER PRIMARY KEY,
      nomCarrera VARCHAR(50));
      ''';
    String query2 = '''CREATE TABLE tblProfesor(
      idProfesor INTEGER PRIMARY KEY,
      nomProfesor VARCHAR(50),
      idCarrera INTEGER,
      email VARCHAR(50),
      FOREIGN KEY (idCarrera) REFERENCES tblCarrera(idCarrera));
      ''';

    String query3 = '''CREATE TABLE tblTarea(
      idTarea INTEGER PRIMARY KEY,
      nomTarea VARCHAR(50),
      fecExpiracion String,
      fecRecordatorio String,
      desTarea VARCHAR(250),
      nomRealizada String,
      idProfesor INTEGER,
      FOREIGN KEY (idProfesor) REFERENCES tblProfesor(idProfesor));
      ''';
    db.execute(query);
    db.execute(query2);
    db.execute(query3);
  }

  Future<int> INSERT_Carrera(String tblName, Map<String, dynamic> data) async {
    var conexion = await database;
    return conexion!.insert(tblName, data);
  }

  Future<int> UPDATE_Carrera(String tblName, Map<String, dynamic> data) async {
    var conexion = await database;
    return conexion!.update(tblName, data,
        where: 'idCarrera = ?', whereArgs: [data['idCarrera']]);
  }

  Future<int> DELETE_Carrera(String tblName, int idCarrera) async {
    var conexion = await database;
    return conexion!
        .delete(tblName, where: 'idCarrera = ?', whereArgs: [idCarrera]);
  }

  Future<List<CarreraModel>> GETALLTASK() async {
    var conexion = await database;
    var result = await conexion!.query('tblCarrera');
    return result.map((task) => CarreraModel.fromMap(task)).toList();
  }

  Future<List<CarreraModel>> GET_CareerByName(String name) async {
    var conexion = await database;
    var result = await conexion!
        .query('tblCarrera', where: 'nomCarrera = ?', whereArgs: [name]);
    return result.map((task) => CarreraModel.fromMap(task)).toList();
  }

//
//
//
//
//
//
  Future<int> INSERT_Profesor(String tblName, Map<String, dynamic> data) async {
    var conexion = await database;
    return conexion!.insert(tblName, data);
  }

  Future<int> UPDATE_Profesor(String tblName, Map<String, dynamic> data) async {
    var conexion = await database;
    return conexion!.update(tblName, data,
        where: 'idProfesor = ?', whereArgs: [data['idProfesor']]);
  }

  Future<int> DELETE_Profesor(String tblName, int idProfesor) async {
    var conexion = await database;
    return conexion!
        .delete(tblName, where: 'idProfesor = ?', whereArgs: [idProfesor]);
  }

  Future<List<ProfesorModel>> GETALLTASK2() async {
    var conexion = await database;
    var result = await conexion!.query('tblProfesor');
    return result.map((task) => ProfesorModel.fromMap(task)).toList();
  }

  Future<List<ProfesorModel>> GET_ProfesorByName(String name) async {
    var conexion = await database;
    var result = await conexion!
        .query('tblProfesor', where: 'nomProfesor = ?', whereArgs: [name]);
    return result.map((task) => ProfesorModel.fromMap(task)).toList();
  }

  Future<List<int>> getCarreraIdsFromDatabase() async {
    var conexion = await database;
    var result = await conexion!.query('tblCarrera', columns: ['idCarrera']);
    return result.map<int>((map) => map['idCarrera'] as int).toList();
  }

  Future<List<String>> getCarreraNameFromDatabase() async {
    var conexion = await database;
    var result = await conexion!.query('tblCarrera', columns: ['nomCarrera']);
    return result.map<String>((map) => map['nomCarrera'] as String).toList();
  }

  //
//
//
//
//
//



  Future<int> INSERT_Tarea(String tblName, Map<String, dynamic> data) async {
    var conexion = await database;
    return conexion!.insert(tblName, data);
  }

 Future<int> updateTareaCompletion(int idTarea, bool isCompleted) async {
    var conexion = await database;
    return await conexion!.update(
      'tblTarea',
      {'nomRealizada': isCompleted ? 'Completado' : 'Pendiente'},
      where: 'idTarea = ?',
      whereArgs: [idTarea],
    );
  }


  Future<int> UPDATE_Tarea(String tblName, Map<String, dynamic> data) async {
    var conexion = await database;
    return conexion!.update(tblName, data,
        where: 'idTarea = ?', whereArgs: [data['idTarea']]);
  }

  Future<int> DELETE_Tarea(String tblName, int idTarea) async {
    var conexion = await database;
    return conexion!
        .delete(tblName, where: 'idTarea = ?', whereArgs: [idTarea]);
  }

  Future<List<TareaModel>> GETALLTASK3() async {
    var conexion = await database;
    var result = await conexion!.query('tblTarea');
    return result.map((task) => TareaModel.fromMap(task)).toList();
  }

  Future<List<TareaModel>> GET_TareaByName(String name) async {
    var conexion = await database;
    var result = await conexion!
        .query('tblTarea', where: 'nomTarea = ?', whereArgs: [name]);
    return result.map((task) => TareaModel.fromMap(task)).toList();
  }

  Future<List<TareaModel>> GET_TareaByEstado(String Estado) async {
    var conexion = await database;
    var result = await conexion!
        .query('tblTarea', where: 'nomRealizada = ?', whereArgs: [Estado]);
    return result.map((task) => TareaModel.fromMap(task)).toList();
  }

  Future<List<TareaModel>> GET_TareaByNameandEstado(String name, String Estado) async {
  var conexion = await database;
  var result = await conexion!.query('tblTarea', where: 'nomTarea = ? AND nomRealizada = ?', whereArgs: [name, Estado]);
  return result.map((task) => TareaModel.fromMap(task)).toList();
}


  Future<List<int>> getProfesorIdsFromDatabase() async {
    var conexion = await database;
    var result = await conexion!.query('tblProfesor', columns: ['idProfesor']);
    return result.map<int>((map) => map['idProfesor'] as int).toList();
  }

Future<String?> getProfesorNameById(int idProfesor) async {
  var conexion = await database;
  var result = await conexion!.query(
    'tblProfesor',
    columns: ['nomProfesor'],
    where: 'idProfesor = ?',
    whereArgs: [idProfesor],
  );

  if (result.isNotEmpty) {
    return result.first['nomProfesor'] as String?;
  }

  return null;
}



  Future<List<String>> getProfesorNameFromDatabase() async {
    var conexion = await database;
    var result = await conexion!.query('tblProfesor', columns: ['nomProfesor']);
    return result.map<String>((map) => map['nomProfesor'] as String).toList();
  }
}

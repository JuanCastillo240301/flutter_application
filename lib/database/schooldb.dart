import 'dart:async';
import 'dart:io';

import 'package:flutter_application_3/assets/models/Carrera_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class SchoolDB {

  static final nameDB = 'SCHOOLDB';
  static final versionDB = 1;

  static Database? _database;
  Future<Database?> get database async {
    if( _database != null ) return _database!;
    return _database = await _initDatabase();
  }
  
  Future<Database?> _initDatabase() async {
    Directory folder = await getApplicationDocumentsDirectory();
    String pathDB = join(folder.path,nameDB);
    return openDatabase(
      pathDB,
      version: versionDB,
      onCreate: _createTables
    );
  }

  FutureOr<void> _createTables(Database db, int version) {
    String query = '''CREATE TABLE tblCarrera( 
      idCarrera INTEGER PRIMARY KEY,
      nomCarrera VARCHAR(50));''';
    db.execute(query);
  }

  Future<int> INSERT_Carrera(String tblName, Map<String,dynamic> data) async {
    var  conexion = await database;
    return conexion!.insert(tblName, data);
  }

  Future<int> UPDATE_Carrera(String tblName, Map<String,dynamic> data) async {
    var  conexion = await database;
    return conexion!.update(tblName, data, 
    where: 'idCarrera = ?', 
    whereArgs: [data['idCarrera']]);
  }



  Future<int> DELETE_Carrera(String tblName, int idCarrera) async {
    var  conexion = await database;
    return conexion!.delete(tblName, 
      where: 'idCarrera = ?',
      whereArgs: [idCarrera]);
  }

  Future<List<CarreraModel>> GETALLTASK() async{
    var conexion = await database;
    var result = await conexion!.query('tblCarrera');
    return result.map((task)=>CarreraModel.fromMap(task)).toList();
  }

  Future<List<CarreraModel>> GET_CareerByName(String name) async {
  var conexion = await database;
  var result = await conexion!.query('tblCarrera', where: 'nomCarrera = ?', whereArgs: [name]);
  return result.map((task) => CarreraModel.fromMap(task)).toList();
}


}

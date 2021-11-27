import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final _databaseName = 'exemploDB.db';
  static final _databaseVersion = 1;

  static final table = 'contato';
  static final columnId = '_id';
  static final columnName = 'nome';
  static final columnIdade = 'idade';

  //Singleton
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  //Criando referencia exclusiva do banco
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;

    //instancia na primeira vez q o banco for acessado
    _database = await _initDatabase();
    return _database;
  }

  //abrir o banco de dados
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  //SQL para a criacao do banco e das tabelas
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY,
        $columnName TEXT NOT NULL,
        $columnIdade INTEGER NOT NULL
      )
      ''');
  }

  //Métodos do CRUD
  //insert
  Future<int> insert(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert(table, row);
  }

  //consulta iD
  //retorno: map
  Future<List<Map<String, dynamic>>> queryAlliD() async {
    Database? db = await instance.database;
    return await db!.query(table); //Select * from contato
  }

  //consulta A-Z
  //retorno: map
  Future<List<Map<String, dynamic>>> queryAllCrescente() async {
    Database? db = await instance.database;
    return await db!.query(table + "ORDER BY nome ASC"); //Select * from contato
  }

  //consulta Z-A
  //retorno: map
  Future<List<Map<String, dynamic>>> queryAllDecrescente() async {
    Database? db = await instance.database;
    return await db!
        .query(table + "ORDER BY nome DESC"); //Select * from contato
  }

  //Contador de linhas
  Future<int?> queryRowCount() async {
    Database? db = await instance.database;
    return Sqflite.firstIntValue(
        await db!.rawQuery("SELECT COUNT(*) FROM $table"));
  }

  //update
  Future<int> update(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    int id = row[columnId];
    return await db!
        .update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  //delete
  Future<int> delete(int id) async {
    Database? db = await instance.database;
    return await db!.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}

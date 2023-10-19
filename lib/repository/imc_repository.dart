import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:imc_calculator/model/imc_model.dart';

class ImcRepository {
  static final ImcRepository _instance = ImcRepository.internal();
  factory ImcRepository() => _instance;
  ImcRepository.internal();

  Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    final dataBasePath = await getDatabasesPath();
    final path = join(dataBasePath, "imc.db");

    return openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute("CREATE TABLE imc("
          "id INTEGER PRIMARY KEY,"
          "valor REAL, "
          "categoria TEXT, "
          "nome TEXT, "
          "peso REAL, "
          "altura REAL)");
    });
  }

  Future<int> delete(int id) async {
    Database? database = await db;
    return await database!.delete('imc', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteAll() async {
    Database? database = await db;
    return await database!.rawDelete("DELETE from imc");
  }

  Future<int> update(ImcModel imc) async {
    Database? database = await db;
    return await database!
        .update('imc', imc.toMap(), where: 'id = ?', whereArgs: [imc.id]);
  }

  Future<ImcModel> save(ImcModel imc) async {
    Database? database = await db;
    imc.id = await database!.insert('imc', imc.toMap());
    return imc;
  }

  Future<int?> getCount() async {
    Database? database = await db;
    return Sqflite.firstIntValue(
        await database!.rawQuery("SELECT COUNT(*) FROM imc"));
  }

  Future<List<ImcModel>> getAll() async {
    Database? database = await db;
    List listMap = await database!.rawQuery("SELECT * FROM imc");
    List<ImcModel> list = listMap.map((e) => ImcModel.fromMap(e)).toList();
    return list;
  }

  Future<void> close() async {
    Database? database = await db;
    database!.close();
  }
}

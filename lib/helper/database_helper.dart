import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import '../model/endemik.dart';

class DatabaseHelper {
  static const _databaseName = 'my_database.db';
  static const _databaseVersion = 1;
  static const _tableName = 'endemik';
  static const _columnId = 'id';
  static const _columnNama = 'nama';
  static const _columnNamaLatin = 'nama_latin';
  static const _columnDeskripsi = 'deskripsi';
  static const _columnAsal = 'asal';
  static const _columnFoto = 'foto';
  static const _columnStatus = 'status';

  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  static late Database _database;

  Future<Database> get database async {
    _database = await _initDatabase();
    return _database;
  }

  Future _initDatabase() async {
    final databasesPath = await
    getApplicationDocumentsDirectory();
    final path = join(databasesPath.path, _databaseName);
    return await openDatabase(path, version: _databaseVersion,
        onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $_tableName (
    $_columnId INTEGER PRIMARY KEY AUTOINCREMENT,
    $_columnNama TEXT,
    $_columnNamaLatin TEXT,
    $_columnDeskripsi TEXT,
    $_columnAsal TEXT,
    $_columnFoto TEXT,
    $_columnStatus TEXT    
    )
    ''');
  }
  Future<int> insert(Endemik object) async {
    final db = await database;

    return await db.insert(_tableName, object.toMap());
  }

  Future<List<Endemik>> getAll() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);

    return List.generate(maps.length, (i) {
      return Endemik.fromMap(maps[i]);
    });
  }

  Future<Endemik?> getById(int id) async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: '$_columnId = ?',
      whereArgs: [id],
    );

    if (maps.isEmpty) {
      return null;
    }

    return Endemik.fromMap(maps.first);
  }

  Future<int> updateEndemik(Endemik object) async {
    final db = await database;
    return await db.update(_tableName, object.toMap(), where:
    '$_columnId = ?', whereArgs: [object.id]);
  }

  Future<int> delete(int id) async {
    final db = await database;
    return await db.delete(_tableName, where: '$_columnId = ?',
        whereArgs: [id]);
  }
}
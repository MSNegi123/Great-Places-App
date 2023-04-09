import 'package:sqflite/sqflite.dart' as sqfl;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  static Future<Database> getDatabase() async {
    final dbPath = await sqfl.getDatabasesPath();
    return sqfl.openDatabase(path.join(dbPath,'user_places.db'), onCreate:(db,version){
      return db.execute("CREATE TABLE user_places(id TEXT PRIMARY_KEY, title TEXT, image TEXT, loc_lat REAL, loc_long REAL, address TEXT)");
    }, version: 1);
  }

  static Future<int> insert(String tableName, Map<String,Object> data) async {
    final db = await getDatabase();
    return db.insert(tableName, data, conflictAlgorithm: sqfl.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String tableName) async {
    final db = await getDatabase();
    return db.query(tableName);
  }
}
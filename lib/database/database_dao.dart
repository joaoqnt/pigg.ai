import 'package:sqflite/sqflite.dart';
import 'database_infra.dart';

class DatabaseDAO {
  final DatabaseInfra _infra = DatabaseInfra();

  // INSERT genérico
  Future<int> insert(String table, Map<String, dynamic> data) async {
    final db = await _infra.database;
    return await db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // UPDATE genérico
  Future<int> update(String table, Map<String, dynamic> data, String where, List<dynamic> whereArgs) async {
    final db = await _infra.database;
    return await db.update(table, data, where: where, whereArgs: whereArgs);
  }

  // DELETE genérico
  Future<int> delete(String table, String where, List<dynamic> whereArgs) async {
    final db = await _infra.database;
    return await db.delete(table, where: where, whereArgs: whereArgs);
  }

  // SELECT genérico
  Future<List<Map<String, dynamic>>> select(String table,
      {String? where,
        List<dynamic>? whereArgs,
        String? orderBy,
        int? limit,
        int? offset}) async {
    final db = await _infra.database;
    return await db.query(
      table,
      where: where,
      whereArgs: whereArgs,
      orderBy: orderBy,
      limit: limit,
      offset: offset,
    );
  }

  // SELECT com LIKE
  Future<List<Map<String, dynamic>>> selectLike(String table, String column, String value) async {
    final db = await _infra.database;
    return await db.query(
      table,
      where: "$column LIKE ?",
      whereArgs: ['%$value%'],
    );
  }

  // RAW SQL (quando precisar)
  Future<List<Map<String, dynamic>>> rawQuery(String sql, [List<dynamic>? arguments]) async {
    final db = await _infra.database;
    return await db.rawQuery(sql, arguments);
  }
}

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:task_management_app/common/models/task_model.dart';

class DBHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute(
      "CREATE TABLE tasks("
      "id INTEGER PRIMARY KEY AUTOINCREMENT,"
      "title STRING, description TEXT, date STRING,"
      "startTime STRING, endTime STRING, "
      "remind INTEGER, repeat STRING, "
      "isCompleted INTEGER)",
    );

    await database.execute("CREATE TABLE user("
        "id INTEGER PRIMARY KEY AUTOINCREMENT DEFAULT 0,"
        "isVerified INTEGER)");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('mydatabase', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

  static Future<int> createItem(Task task) async {
    final db = await DBHelper.db();

    final id = await db.insert('tasks', task.toJson(),
        conflictAlgorithm: sql.ConflictAlgorithm.replace);

    return id;
  }

  static Future<int> createUser(int isVerified) async {
    final db = await DBHelper.db();

    final data = {
      'id': 1,
      'isVerified': isVerified,
    };

    final id = await db.insert('user', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);

    return id;
  }

  static Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await DBHelper.db();
    return db.query('user', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await DBHelper.db();
    return db.query('tasks', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await DBHelper.db();
    return db.query('tasks', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateItem(int id, String title, String description,
      int isCompleted, String date, String startTime, String endTime) async {
    final db = await DBHelper.db();

    final data = {
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'date': date,
      'startTime': startTime,
      'endTime': endTime,
    };

    final results =
        await db.update('tasks', data, where: "id = ?", whereArgs: [id]);

    return results;
  }

  static Future<void> deleteItem(int id) async {
    final db = await DBHelper.db();

    try {
      db.delete('tasks', where: "id = ?", whereArgs: [id]);
    } catch (e) {
      debugPrint("Unable to delete $e");
    }
  }
}

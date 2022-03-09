import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class User {
  int? id;
  final String name;
  final String username;
  final String password;
  final String email;

  User({
    this.id,
    required this.name,
    required this.username,
    required this.password,
    required this.email,
  });

  Future<void> createUser(User user) async {
    final db = await databaseCreate();
    db.insert('User', user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'password': password
    };
  }

  Future<int> update(User user) async {
    final db = await databaseCreate();
    return await db
        .update('User', user.toMap(), where: 'id = ?', whereArgs: [user.id]);
  }
}

Future<Map<String, dynamic>> getUserById(int id) async {
  final db = await databaseCreate();
  final user = await db.query('User',
      columns: ['id', 'name', 'username', 'email'],
      where: 'id = ?',
      whereArgs: [id]);
  return user.first;
}

Future<Map<String, dynamic>?> getUserByUsername(String username) async {
  final db = await databaseCreate();
  final user =
      await db.query('User', where: 'username = ?', whereArgs: [username]);
  if (user.isEmpty) {
    return null;
  } else {
    return user.first;
  }
}

Future<void> deleteUser(int id) async {
  final db = await databaseCreate();
  db.delete('User', where: 'id = ?', whereArgs: [id]);
}

Future<Database> databaseCreate() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = openDatabase(
    join(await getDatabasesPath(), 'instagram.db'),
    version: 1,
    onOpen: (db) async {
      await db.execute(
          'CREATE TABLE IF NOT EXISTS User (id INTEGER PRIMARY KEY, name TEXT, username TEXT, password TEXT, email TEXT)');
    },
  );
  return database;
}

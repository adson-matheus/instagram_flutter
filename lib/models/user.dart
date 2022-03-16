import 'package:flutter/material.dart';
import 'package:instagram_flutter/models/profile_picture.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class User {
  final int? id;
  final String name;
  final String username;
  final String password;
  final String email;
  final int followers;
  final int following;
  final int totalPubs;

  User({
    this.id,
    this.followers = 0,
    this.following = 0,
    this.totalPubs = 0,
    required this.name,
    required this.username,
    required this.password,
    required this.email,
  });

  Future<void> createUser() async {
    final db = await databaseCreate();
    final int id = await db.insert('User', toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);

    await defaultProfilePicture(id);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'password': password,
      'followers': followers,
      'following': following,
      'totalPubs': totalPubs,
    };
  }

  Future<void> update() async {
    final db = await databaseCreate();
    await db.update('User', toMap(), where: 'id = ?', whereArgs: [id]);
  }
}

Future<Map<String, dynamic>> getUserById(int id) async {
  final db = await databaseCreate();
  final user = await db.query('User',
      columns: [
        'id',
        'name',
        'username',
        'email',
        'followers',
        'following',
        'totalPubs'
      ],
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

Future<List<Map<String, dynamic>>?> getUsers() async {
  final db = await databaseCreate();
  final users = await db.query('User', columns: [
    'id',
    'name',
    'username',
    'followers',
    'following',
    'totalPubs',
  ]);
  if (users.isNotEmpty) return users;
  return null;
}

Future<bool> checkIfUserExists(String username) async {
  final db = await databaseCreate();
  final user = await db.query('User',
      where: 'username = ?', whereArgs: [username], columns: ['username']);

  if (user.isEmpty) return false;
  return true;
}

Future<bool> checkIfEmailExists(String userEmail) async {
  final db = await databaseCreate();
  final email = await db.query('User',
      where: 'email = ?', whereArgs: [userEmail], columns: ['email']);
  if (email.isEmpty) return false;
  return true;
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
      await db.execute("""
          CREATE TABLE IF NOT EXISTS User
          (id INTEGER PRIMARY KEY,
          name TEXT,
          username TEXT,
          password TEXT,
          email TEXT,
          followers INTEGER,
          following INTEGER,
          totalPubs INTEGER,
          UNIQUE(username, email))
          """);
      await db.execute("""
          CREATE TABLE IF NOT EXISTS Picture
          (id INTEGER PRIMARY KEY,
          userId INTEGER NOT NULL,
          title TEXT,
          picture BLOB,
          FOREIGN KEY(userId) REFERENCES User(id));
          """);
    },
  );
  return database;
}

Future<void> drop() async {
  WidgetsFlutterBinding.ensureInitialized();

  openDatabase(
    join(await getDatabasesPath(), 'instagram.db'),
    version: 1,
    onOpen: (db) async {
      await db.execute("""
          DROP TABLE IF EXISTS User
          """);
    },
  );
}

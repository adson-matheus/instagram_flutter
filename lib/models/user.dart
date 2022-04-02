import 'package:flutter/material.dart';
import 'package:instagram_flutter/models/followers.dart';
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
    await defaultFollowers(id);
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

User fromMap(user) {
  return User(
    id: user['id'],
    name: user['name'],
    username: user['username'],
    password: user['password'],
    email: user['email'],
    followers: user['followers'],
    following: user['following'],
    totalPubs: user['totalPubs'],
  );
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

Future<List<Map<String, Object?>>?> getUsersAndProfilePictures(
    String search) async {
  final db = await databaseCreate();

  final List<Map<String, Object?>> list = await db.rawQuery("""
      SELECT u.id, u.name, u.username, u.followers, u.following, u.totalPubs, p.picture
      FROM User u, Picture p
      WHERE u.id = p.userId
      AND (u.username LIKE '$search%' OR u.name LIKE '$search%')
      LIMIT 5;
  """);
  if (list.isEmpty) {
    return null;
  }
  return list;
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
  await db.delete('User', where: 'id = ?', whereArgs: [id]);
  await db.delete('Picture', where: 'userId = ?', whereArgs: [id]);
  await db.delete('Followers', where: 'userId = ?', whereArgs: [id]);
  await db.delete('PostPicture', where: 'userId = ?', whereArgs: [id]);
  //add userId to Comment table
  //await db.delete('Comment', where: 'userId = ?', whereArgs: [id]);
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
      //followers as List with id's
      //stored as String
      await db.execute("""
          CREATE TABLE IF NOT EXISTS Followers
          (id INTEGER PRIMARY KEY,
          userId INTEGER NOT NULL,
          followers TEXT,
          FOREIGN KEY(userId) REFERENCES User(id),
          FOREIGN KEY(followers) REFERENCES User(followers));
          """);
      await db.execute("""
          CREATE TABLE IF NOT EXISTS PostPicture
          (id INTEGER PRIMARY KEY,
          userId INTEGER NOT NULL,
          picture BLOB NOT NULL,
          caption TEXT,
          listWhoLiked TEXT,
          date TEXT,
          FOREIGN KEY (userId) REFERENCES User(id));
          """);
      await db.execute("""
        CREATE TABLE IF NOT EXISTS Comment
        (id INTEGER PRIMARY KEY,
        idPost INTEGER,
        comments TEXT NOT NULL);
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
      await db.execute("DROP TABLE IF EXISTS User");
      await db.execute("DROP TABLE IF EXISTS Picture");
      await db.execute("DROP TABLE IF EXISTS Followers");
      await db.execute("DROP TABLE IF EXISTS PostPicture");
      await db.execute("DROP TABLE IF EXISTS Comment");
    },
  );
}

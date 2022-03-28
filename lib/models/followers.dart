import 'package:instagram_flutter/models/user.dart';
import 'package:sqflite/sqflite.dart';

class Followers {
  final int? id;
  final int userId;
  final String followers;

  Followers({
    this.id,
    required this.userId,
    required this.followers,
  });

  Future<void> addFollower() async {
    final db = await databaseCreate();
    await db.insert(
      'Followers',
      toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'followers': followers,
    };
  }

  Future<void> update() async {
    final db = await databaseCreate();
    await db.update('Followers', toMap(), where: 'id = ?', whereArgs: [id]);
  }
}

Future<Map<String, dynamic>> follow(
    Map<String, dynamic> user, int loggedUserId) async {
  //add follower++
  final Map<String, dynamic>? thisUser =
      await getUserByUsername(user['username']);
  final Map<String, dynamic> updatedUser = Map.from(user);
  updatedUser['email'] = thisUser!['email'];
  updatedUser['password'] = thisUser['password'];
  updatedUser['followers']++;
  await fromMap(updatedUser).update();

  //add id to followers' list
  Followers newFollow =
      Followers(userId: loggedUserId, followers: '[$loggedUserId]');
  newFollow.addFollower();

  return updatedUser;
}

Future<List<Map<String, dynamic>>?> getFollowersFromUser(int id) async {
  final db = await databaseCreate();

  final List<Map<String, dynamic>> list = await db.rawQuery("""
      SELECT u.id, u.name, u.username, u.followers, u.following, u.totalPubs, p.picture
      FROM User u, Picture p, Followers f
      WHERE u.id = p.userId
      AND u.id = f.userId
  """);
  if (list.isEmpty) {
    return null;
  }
  return list;
}

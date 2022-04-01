import 'package:instagram_flutter/models/user.dart';
import 'package:sqflite/sqflite.dart';

class Followers {
  final int userId;
  final String followers;

  Followers({
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
      'userId': userId,
      'followers': followers,
    };
  }

  Future<void> update() async {
    final db = await databaseCreate();
    await db
        .update('Followers', toMap(), where: 'userId = ?', whereArgs: [userId]);
  }
}

Future<void> defaultFollowers(int userId) async {
  final f = Followers(
    userId: userId,
    followers: '',
  );
  await f.addFollower();
}

Future<Map<String, dynamic>> getFollowersList(int userId) async {
  var db = await databaseCreate();
  final followers = await db.query(
    'Followers',
    where: 'userId = ?',
    whereArgs: [userId],
    columns: ['followers'],
  );
  return followers.first;
}

Future<bool> isFollowing(int userId, int loggedUserId) async {
  var db = await databaseCreate();
  final followers = await db.query(
    'Followers',
    columns: ['followers'],
    where: 'userId = ?',
    whereArgs: [userId],
  );
  final followingOrNot = await db.rawQuery("""
    SELECT *
    FROM Followers
    WHERE userId = $userId
    AND $loggedUserId IN (${followers.first['followers']} 0);
  """);

  if (followingOrNot.isEmpty) {
    return false;
  } else {
    return true;
  }
}

Future<Map<String, dynamic>> follow(
    Map<String, dynamic> user, int loggedUserId) async {
  final Map<String, dynamic>? thisUser =
      await getUserByUsername(user['username']);
  final Map<String, dynamic> updatedUser = Map.from(user);

  updatedUser['email'] = thisUser!['email'];
  updatedUser['password'] = thisUser['password'];
  updatedUser['followers']++;
  await fromMap(updatedUser).update();

  //get followers list
  final followersList = await getFollowersList(user['id']);
  //add id to followers' list
  final String f = followersList['followers'] + ' $loggedUserId,';
  Followers newFollow = Followers(userId: user['id'], followers: f);
  await newFollow.update();

  return updatedUser;
}

Future<List<Map<String, dynamic>>?> getFollowersFromUser(int id) async {
  final db = await databaseCreate();

  final List<Map<String, dynamic>> listFollowers = await db.rawQuery("""
      SELECT f.followers
      FROM Followers f
      WHERE f.userId = $id
  """);

  final List<Map<String, dynamic>> list = await db.rawQuery("""
      SELECT u.id, u.name, u.username, u.followers, u.following, u.totalPubs, p.picture
      FROM User u, Picture p
      WHERE u.id = p.userId
      AND u.id IN (${listFollowers.first['followers']} 0);
  """);
  if (list.isEmpty) {
    return null;
  }
  return list;
}

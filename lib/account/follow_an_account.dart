import 'package:instagram_flutter/models/user.dart';

Future<Map<String, dynamic>> follow(Map<String, dynamic> user) async {
  final Map<String, dynamic>? thisUser =
      await getUserByUsername(user['username']);
  final Map<String, dynamic> updatedUser = Map.from(user);
  updatedUser['email'] = thisUser!['email'];
  updatedUser['password'] = thisUser['password'];
  updatedUser['followers']++;
  await fromMap(updatedUser).update();

  return updatedUser;
}

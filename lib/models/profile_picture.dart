import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_flutter/models/user.dart';
import 'package:sqflite/sqflite.dart';

class Picture {
  final int? id;
  final int userId;
  final String title;
  final Uint8List picture;

  Picture(
      {this.id,
      required this.userId,
      required this.title,
      required this.picture});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "userId": userId,
      "title": title,
      "picture": picture,
    };
  }

  Future<void> update() async {
    final db = await databaseCreate();
    await db.update('Picture', toMap(), where: 'id = ?', whereArgs: [id]);
  }
}

Future<void> savePicture(Picture picture) async {
  var db = await databaseCreate();
  await db.insert('Picture', picture.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace);
}

Future<Map<String, dynamic>> getPicture(int userId) async {
  var db = await databaseCreate();
  final picture =
      await db.query('Picture', where: 'userId = ?', whereArgs: [userId]);
  return picture.first;
}

Future<void> defaultProfilePicture(int id) async {
  Map<String, dynamic> user = await getUserById(id);

  var byteData = await rootBundle
      .load('assets/images/standard.jpg')
      .then((value) => value);
  final Uint8List pic = byteData.buffer.asUint8List();

  Picture picture = Picture(
      userId: user['id'],
      title: '@${user['username']} Profile Picture',
      picture: pic);
  savePicture(picture);
}

Future<Map<String, dynamic>?> setNewProfilePicture(
    Map<String, dynamic> currentProfilePicture) async {
  final XFile? img = await ImagePicker().pickImage(source: ImageSource.gallery);

  if (img == null) return null;
  var bytes = await img.readAsBytes();
  Picture picture = Picture(
      id: currentProfilePicture['id'],
      userId: currentProfilePicture['userId'],
      title: currentProfilePicture['title'],
      picture: bytes);
  picture.update();

  return getPicture(picture.userId);
}

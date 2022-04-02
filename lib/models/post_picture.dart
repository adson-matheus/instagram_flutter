import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:instagram_flutter/models/user.dart';
import 'package:sqflite/sqflite.dart';

class PostPicture {
  final int? id;
  final int userId;
  final Uint8List picture;
  final String? caption;
  final List<int>? listWhoLiked;
  final DateTime? date;

  PostPicture({
    this.id,
    required this.userId,
    required this.picture,
    this.caption,
    this.listWhoLiked,
    this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'picture': picture,
      'caption': caption,
      'listWhoLiked': listWhoLiked,
      'date': date.toString(),
    };
  }

  newPost() async {
    final db = await databaseCreate();
    await db.insert(
      'PostPicture',
      toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}

Future<List<Map<String, dynamic>>?> getPosts(int loggedUserId) async {
  final db = await databaseCreate();
  final List<Map<String, Object?>> posts = await db.query(
    'PostPicture',
    where: 'userId = ?',
    whereArgs: [loggedUserId],
  );
  if (posts.isEmpty) {
    return null;
  } else {
    return posts.reversed.toList();
  }
}

Future<void> postNewPicture(int loggedUserId) async {
  final XFile? img = await ImagePicker().pickImage(
    source: ImageSource.camera,
  );
  if (img == null) return;

  var bytes = await img.readAsBytes();

  PostPicture postPicture = PostPicture(
    userId: loggedUserId,
    picture: bytes,
    date: DateTime.now(),
  );
  postPicture.newPost();

  Comment comment = Comment(
    idPost: postPicture.userId,
    comments: {},
  );
  comment.comment();
}

//////////////Comment

class Comment {
  final int? id;
  final int idPost;
  final Map<int, String> comments;

  Comment({
    this.id,
    required this.idPost,
    required this.comments,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idPost': idPost,
      'comments': comments,
    };
  }

  comment() async {
    final db = await databaseCreate();
    await db.insert(
      'Comment',
      toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}

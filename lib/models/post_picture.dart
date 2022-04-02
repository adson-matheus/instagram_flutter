import 'dart:typed_data';

import 'package:instagram_flutter/models/user.dart';
import 'package:sqflite/sqflite.dart';

class PostPicture {
  final int? id;
  final int userId;
  final Uint8List picture;
  final String? caption;
  final List<int>? listWhoLiked;
  final Comment? comments;
  final DateTime? date;

  PostPicture({
    this.id,
    required this.userId,
    required this.picture,
    this.caption,
    this.listWhoLiked,
    this.comments,
    this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'picture': picture,
      'caption': caption,
      'listWhoLiked': listWhoLiked,
      'comments': comments,
      'date': date,
    };
  }

  newPost() async {
    final db = await databaseCreate();
    db.insert(
      'Post',
      toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}

class Comment {
  final int id;
  final Map<int, String> comments;

  Comment({
    required this.id,
    required this.comments,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'comments': comments,
    };
  }

  comment() async {
    final db = await databaseCreate();
    db.insert(
      'Comment',
      toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}

import 'package:flutter/material.dart';

class PostPictureWidget extends StatefulWidget {
  final int loggedUserId;
  const PostPictureWidget({
    Key? key,
    required this.loggedUserId,
  }) : super(key: key);

  @override
  State<PostPictureWidget> createState() => _PostPictureWidgetState();
}

class _PostPictureWidgetState extends State<PostPictureWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

import 'package:flutter/material.dart';
import 'package:instagram_flutter/models/post_picture.dart';
import 'package:instagram_flutter/models/user.dart';

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
  late int loggedUserId;
  @override
  void initState() {
    super.initState();
    loggedUserId = widget.loggedUserId;
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: const Text('Postar Foto'),
      onPressed: () async {
        final bool isPosted = await postNewPicture(loggedUserId);

        if (isPosted) {
          //posts count++
          final user = await getUserById(loggedUserId);
          final Map<String, dynamic> updatedUser = Map.from(user);
          updatedUser['totalPubs']++;
          fromMap(updatedUser).update();

          //back to index
          Navigator.of(context).popAndPushNamed(
            '/index',
            arguments: [updatedUser, 0],
          );
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:instagram_flutter/controller/useful_widgets.dart';
import 'package:instagram_flutter/models/followers.dart';

class GetFollowersFromUserWidget extends StatefulWidget {
  final int userId;
  final int loggedUserId;
  const GetFollowersFromUserWidget({
    Key? key,
    required this.userId,
    required this.loggedUserId,
  }) : super(key: key);

  @override
  State<GetFollowersFromUserWidget> createState() =>
      _GetFollowersFromUserWidgetState();
}

class _GetFollowersFromUserWidgetState
    extends State<GetFollowersFromUserWidget> {
  late int userId;
  late int loggedUserId;

  @override
  void initState() {
    super.initState();
    userId = widget.userId;
    loggedUserId = widget.loggedUserId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getFollowersFromUser(userId),
        builder: (BuildContext context,
            AsyncSnapshot<List<Map<String, dynamic>>?> snapshot) {
          if (snapshot.hasData) {
            return SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListUsersReusable(
                    content: snapshot.data!,
                    index: index,
                    loggedUserId: loggedUserId,
                  );
                },
              ),
            );
          } else {
            return const Scaffold(
                body: Center(
              child: Text('Sem seguidores'),
            ));
          }
        },
      ),
    );
  }
}

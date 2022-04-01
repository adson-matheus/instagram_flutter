import 'package:flutter/material.dart';
import 'package:instagram_flutter/models/followers.dart';

class IsFollowingWidget extends StatefulWidget {
  final int loggedUserId;
  final Map<String, dynamic> user;

  const IsFollowingWidget({
    Key? key,
    required this.loggedUserId,
    required this.user,
  }) : super(key: key);

  @override
  State<IsFollowingWidget> createState() => _IsFollowingWidgetState();
}

class _IsFollowingWidgetState extends State<IsFollowingWidget> {
  late int loggedUserId;
  late Map<String, dynamic> user;

  @override
  void initState() {
    super.initState();
    user = widget.user;
    loggedUserId = widget.loggedUserId;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: isFollowing(user['id'], loggedUserId),
        builder: (
          BuildContext context,
          AsyncSnapshot<bool> snapshot,
        ) {
          if (snapshot.hasData) {
            if (snapshot.data!) {
              return SizedBox(
                child: OutlinedButton(
                  child: const Text(
                    'Seguindo',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {},
                ),
              );
            } else {
              return SizedBox(
                child: ElevatedButton(
                  child: const Text(
                    'Seguir',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.blue)),
                  onPressed: () async {
                    await follow(
                      user,
                      loggedUserId,
                    );
                  },
                ),
              );
            }
          } else {
            return const Center(child: Text('Ocorreu um erro ao carregar.'));
          }
        });
  }
}

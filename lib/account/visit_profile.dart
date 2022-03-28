import 'package:flutter/material.dart';
import 'package:instagram_flutter/controller/useful_widgets.dart';
import 'package:instagram_flutter/index/profile/profile_appbar.dart';
import 'package:instagram_flutter/index/profile/profile_stories.dart';
import 'package:instagram_flutter/models/followers.dart';

class VisitProfileWidget extends StatefulWidget {
  final Map<String, dynamic> user;
  final int loggedUserId;
  const VisitProfileWidget({
    Key? key,
    required this.user,
    required this.loggedUserId,
  }) : super(key: key);

  @override
  State<VisitProfileWidget> createState() => _VisitProfileWidgetState();
}

class _VisitProfileWidgetState extends State<VisitProfileWidget> {
  late Map<String, dynamic> user;
  late int loggedUserId;

  @override
  void initState() {
    super.initState();
    user = widget.user;
    loggedUserId = widget.loggedUserId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user['username']),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(10.0),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: ClipOval(
                  child: Image.memory(
                    user['picture'],
                    width: 327,
                    height: 327,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Row(
                children: [
                  PaddingWithColumn(
                      number: user['totalPubs'], text: 'Publicações'),
                  TextButton(
                    onPressed: () => Navigator.of(context)
                        .pushNamed('/get_followers_from_user', arguments: [
                      user['id'] as int,
                      loggedUserId,
                    ]),
                    child: PaddingWithColumn(
                        number: user['followers'], text: 'Seguidores'),
                  ),
                  PaddingWithColumn(
                      number: user['following'], text: 'Seguindo'),
                ],
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: ElevatedButton(
                      child: const Text(
                        'Seguir',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all(Colors.blue)),
                      onPressed: () async {
                        final updated = await follow(user, loggedUserId);
                        setState(() {
                          user = updated;
                        });
                      }),
                ),
                ElevatedButton(
                  child: const Icon(
                    Icons.person_add,
                    color: Colors.white,
                  ),
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.blue)),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          const ProfileStories(),
          AppBarProfile(),
        ],
      ),
    );
  }
}

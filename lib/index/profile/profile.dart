import 'package:flutter/material.dart';
import 'package:instagram_flutter/controller/useful_widgets.dart';
import 'package:instagram_flutter/index/profile/profile_appbar.dart';
import 'package:instagram_flutter/index/profile/profile_stories.dart';

class ProfileWidget extends StatelessWidget {
  final Map<String, dynamic> user;
  final Map<String, dynamic> profilePicture;

  const ProfileWidget(
      {Key? key, required this.user, required this.profilePicture})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
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
                  profilePicture['picture'],
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
                PaddingWithColumn(
                    number: user['followers'], text: 'Seguidores'),
                PaddingWithColumn(number: user['following'], text: 'Seguindo'),
              ],
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.75,
                child: OutlinedButton(
                  child: const Text(
                    'Editar Perfil',
                  ),
                  onPressed: () => Navigator.of(context).pushNamed(
                      '/profile_edit',
                      arguments: <Map<String, dynamic>>[user, profilePicture]),
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.white)),
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                child: const Icon(
                  Icons.person_add,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        const ProfileStories(),
        AppBarProfile(),
      ],
    );
  }
}

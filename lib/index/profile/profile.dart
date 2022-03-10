import 'package:flutter/material.dart';
import 'package:instagram_flutter/controller/useful_widgets.dart';
import 'package:instagram_flutter/index/profile/profile_appbar.dart';
import 'package:instagram_flutter/index/profile/profile_stories.dart';

class Profile extends StatelessWidget {
  final Map<String, dynamic> user;
  const Profile({Key? key, required this.user}) : super(key: key);

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
                child: Image.asset(
                  'assets/images/profile.jpg',
                  width: 327,
                  height: 327,
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
                    //style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {},
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

class ShowBottomSheet extends StatefulWidget {
  final int id;
  const ShowBottomSheet({Key? key, required this.id}) : super(key: key);

  @override
  State<ShowBottomSheet> createState() => _ShowBottomSheetState();
}

class _ShowBottomSheetState extends State<ShowBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(Colors.white)),
        child: const Icon(Icons.menu),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Card(
                  child: BottomSheetButtons(id: widget.id),
                );
              });
        });
  }
}

class BottomSheetButtons extends StatelessWidget {
  final int id;
  BottomSheetButtons({Key? key, required this.id}) : super(key: key);

  final ButtonStyle style = ButtonStyle(
      foregroundColor: MaterialStateProperty.all(Colors.white),
      alignment: Alignment.centerLeft,
      minimumSize:
          MaterialStateProperty.all<Size>(const Size(double.infinity, 50)));

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton.icon(
            style: style,
            icon: const Icon(
              Icons.settings,
            ),
            label: const Text('Configurações'),
            onPressed: () => Navigator.pushNamed(context, '/profile_settings',
                arguments: id)),
        TextButton.icon(
          style: style,
          icon: const Icon(
            Icons.history,
          ),
          label: const Text('Itens Arquivados'),
          onPressed: () {},
        ),
        TextButton.icon(
          style: style,
          icon: const Icon(
            Icons.watch_later_outlined,
          ),
          label: const Text('Sua Atividade'),
          onPressed: () {},
        ),
        TextButton.icon(
          style: style,
          icon: const Icon(
            Icons.bookmark_border,
          ),
          label: const Text('Salvo'),
          onPressed: () {},
        ),
      ],
    );
  }
}

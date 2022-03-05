import 'package:flutter/material.dart';
import 'package:instagram_flutter/controller/useful_widgets.dart';

class Profile extends StatelessWidget {
  //final Map<String, dynamic> user;
  const Profile({Key? key}) : super(key: key);

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
              children: const [
                PaddingWithColumn(number: '0', text: 'Publicações'),
                PaddingWithColumn(number: '1', text: 'Seguidores'),
                PaddingWithColumn(number: '139', text: 'Seguindo'),
              ],
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.75,
                child: TextButton(
                  child: const Text(
                    'Editar Perfil',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {},
                ),
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Icon(
                      Icons.person_add,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}

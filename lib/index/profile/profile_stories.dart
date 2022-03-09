import 'package:flutter/material.dart';

class ProfileStories extends StatelessWidget {
  const ProfileStories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Destaques dos stories',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const Text('Mantenha seus stories favoritos no seu perfil',
              style: TextStyle(
                fontSize: 12,
              )),
          SizedBox(
            height: 75,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (BuildContext context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/profile.jpg',
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

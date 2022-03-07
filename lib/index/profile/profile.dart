import 'package:flutter/material.dart';
import 'package:instagram_flutter/controller/useful_widgets.dart';

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
                  'assets/images/adrya.jpg',
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
          padding: const EdgeInsets.only(top: 12.0, bottom: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
              TextButton(
                onPressed: () {},
                child: const Icon(
                  Icons.person_add,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        const Text(
          'Destaques dos stories',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const Text('Mantenha seus stories favoritos no seu perfil',
            style: TextStyle(
              fontSize: 12,
            )),
        const ProfileStories(),
        AppBarProfile(),
      ],
    );
  }
}

class ProfileStories extends StatelessWidget {
  const ProfileStories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SizedBox(
        height: 75,
        width: 75,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (BuildContext context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/adrya.jpg',
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class AppBarProfile extends StatelessWidget {
  AppBarProfile({Key? key}) : super(key: key);

  final List<Tab> _tab = const <Tab>[
    Tab(
      icon: Icon(Icons.grid_4x4),
    ),
    Tab(
      icon: Icon(Icons.photo_camera_front_outlined),
    ),
  ];

  final _tabBarView = <Widget>[
    const Center(child: Text('Perfil')),
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(
          Icons.photo_camera_front_outlined,
          size: 40,
        ),
        Text('Fotos com você'),
      ],
    )
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: DefaultTabController(
        length: _tab.length,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: _tab,
              indicatorColor: Colors.white,
            ),
            elevation: 0.0,
            backgroundColor: Colors.grey[850],
          ),
          body: TabBarView(children: _tabBarView),
        ),
      ),
    );
  }
}

enum menuOption { config, archived, activity, saved }

class ProfileMenuOptions extends StatefulWidget {
  final int id;
  const ProfileMenuOptions({Key? key, required this.id}) : super(key: key);

  @override
  State<ProfileMenuOptions> createState() => _ProfileMenuOptionsState();
}

class _ProfileMenuOptionsState extends State<ProfileMenuOptions> {
  late String _selection;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<menuOption>(
      icon: const Icon(Icons.menu),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<menuOption>>[
        PopupMenuItem<menuOption>(
          value: menuOption.config,
          child: Row(
              children: const [Icon(Icons.settings), Text(' Configurações')]),
        ),
        PopupMenuItem<menuOption>(
          value: menuOption.archived,
          child: Row(
              children: const [Icon(Icons.history), Text(' Itens Arquivados')]),
        ),
        PopupMenuItem<menuOption>(
          value: menuOption.activity,
          child: Row(children: const [
            Icon(Icons.watch_later_outlined),
            Text(' Sua Atividade')
          ]),
        ),
        PopupMenuItem<menuOption>(
          value: menuOption.saved,
          child: Row(
              children: const [Icon(Icons.bookmark_border), Text(' Salvo')]),
        ),
      ],
      onSelected: (menuOption result) {
        setState(() => _selection = result.name);
        if (_selection == 'config') {
          Navigator.pushNamed(context, '/profile_settings',
              arguments: widget.id);
        }
      },
    );
  }
}

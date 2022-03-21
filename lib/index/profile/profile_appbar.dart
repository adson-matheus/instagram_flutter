import 'package:flutter/material.dart';

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
        Text('Fotos marcadas'),
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
            leading: null,
            automaticallyImplyLeading: false,
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

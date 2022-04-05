import 'package:flutter/material.dart';

class AppBarProfile extends StatefulWidget {
  final int loggedUserId;
  final List<Map<String, dynamic>>? posts;

  const AppBarProfile({
    Key? key,
    required this.loggedUserId,
    required this.posts,
  }) : super(key: key);

  @override
  State<AppBarProfile> createState() => _AppBarProfileState();
}

class _AppBarProfileState extends State<AppBarProfile> {
  late int loggedUserId;
  late List<Map<String, dynamic>>? posts;

  @override
  void initState() {
    super.initState();
    loggedUserId = widget.loggedUserId;
    posts = widget.posts;
  }

  final List<Tab> _tab = const <Tab>[
    Tab(
      icon: Icon(Icons.grid_4x4),
    ),
    Tab(
      icon: Icon(Icons.photo_camera_front_outlined),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final _tabBarView = <Widget>[
      posts != null
          ? GridView.count(
              crossAxisCount: 3,
              children: [
                Image.memory(posts![0]['picture']),
                Image.memory(posts![1]['picture']),
                Image.memory(posts![2]['picture']),
              ],
            )
          : const Center(
              child: Text('Fotos'),
            ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.photo_camera_front_outlined,
            size: 40,
          ),
          Text('Fotos marcadas'),
        ],
      ),
    ];

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

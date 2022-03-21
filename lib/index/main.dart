import 'package:flutter/material.dart';
import 'package:instagram_flutter/controller/useful_widgets.dart';
import 'package:instagram_flutter/index/profile/profile.dart';
import 'package:instagram_flutter/index/search/search.dart';
import 'package:instagram_flutter/index/profile/profile_bottom_sheet.dart';
import 'package:instagram_flutter/models/profile_picture.dart';

class BottomNavigationBarIndex extends StatefulWidget {
  final Map<String, dynamic> user;
  final int? selectBody;
  const BottomNavigationBarIndex(
      {Key? key, required this.user, this.selectBody})
      : super(key: key);

  @override
  State<BottomNavigationBarIndex> createState() =>
      _BottomNavigationBarIndexState();
}

class _BottomNavigationBarIndexState extends State<BottomNavigationBarIndex> {
  late int _currentBody;
  static const Color _selectedItemColor = Colors.white;
  static const Color _unselectedItemColor = Colors.white70;

  @override
  void initState() {
    super.initState();
    _currentBody = widget.selectBody ?? 0;
  }

  void itemTapped(int index) {
    setState(() {
      _currentBody = index;
    });
  }

  final List<BottomNavigationBarItem> _items = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'),
    const BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Pesquisar'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.play_circle), label: 'Reels'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.shopping_bag_outlined), label: 'Loja'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.photo_camera_front_outlined), label: 'Perfil'),
  ];

  @override
  Widget build(BuildContext context) {
    final List<AppBar> _appBarOptions = <AppBar>[
      AppBar(
        title: const Text('Instagram',
            style: TextStyle(fontFamily: 'Lobster-Regular')),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.add_box_outlined)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border)),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.message_outlined)),
        ],
      ),
      AppBar(
        title: const Text('Instagram',
            style: TextStyle(fontFamily: 'Lobster-Regular')),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.add_box_outlined)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border)),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.message_outlined)),
        ],
      ),
      AppBar(
        title: const Text('Instagram',
            style: TextStyle(fontFamily: 'Lobster-Regular')),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.add_box_outlined)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border)),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.message_outlined)),
        ],
      ),
      AppBar(
        title: const Text('Instagram',
            style: TextStyle(fontFamily: 'Lobster-Regular')),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.add_box_outlined)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border)),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.message_outlined)),
        ],
      ),
      AppBar(
        title: Text(widget.user['username']),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.add_box_outlined)),
          ShowBottomSheet(id: widget.user['id']),
        ],
      ),
    ];

    final List<Widget> _widgetOptions = <Widget>[
      const Text('Início'),
      const SearchPageWidget(),
      const Text('Reels'),
      const Text('Loja'),
      //ProfileWidget(user: widget.user, profilePicture: profilePicture),
    ];

    return FutureBuilder<Map<String, dynamic>>(
        future: getPicture(widget.user['id']),
        builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.hasData) {
            return WillPopeScopeExitApp(
                child: Scaffold(
              appBar: _appBarOptions.elementAt(_currentBody),
              body: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: _currentBody == 4
                    ? ProfilePageWidget(
                        user: widget.user, profilePicture: snapshot.data!)
                    : _widgetOptions.elementAt(_currentBody),
              ),
              bottomNavigationBar: BottomNavigationBar(
                items: _items,
                onTap: itemTapped,
                currentIndex: _currentBody,
                selectedItemColor: _selectedItemColor,
                unselectedItemColor: _unselectedItemColor,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                type: BottomNavigationBarType.fixed,
              ),
            ));
          } else {
            return const Padding(
              padding: EdgeInsets.all(24.0),
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

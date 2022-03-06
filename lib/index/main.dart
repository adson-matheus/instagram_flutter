import 'package:flutter/material.dart';
import 'package:instagram_flutter/controller/useful_widgets.dart';
import 'package:instagram_flutter/index/profile.dart';

class BottomNavigationBarIndex extends StatefulWidget {
  final Map<String, dynamic> user;
  const BottomNavigationBarIndex({Key? key, required this.user})
      : super(key: key);

  @override
  State<BottomNavigationBarIndex> createState() =>
      _BottomNavigationBarIndexState();
}

class _BottomNavigationBarIndexState extends State<BottomNavigationBarIndex> {
  int _currentBody = 0;
  static const Color _selectedItemColor = Colors.white;
  static const Color _unselectedItemColor = Colors.white70;

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
          IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
        ],
      ),
    ];

    final List<Widget> _widgetOptions = <Widget>[
      const Text('Início'),
      const Text('Pesquisar'),
      const Text('Reels'),
      const Text('Loja'),
      Profile(user: widget.user),
    ];

    return WillPopeScopeExitApp(
        child: Scaffold(
      appBar: _appBarOptions.elementAt(_currentBody),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: _widgetOptions.elementAt(_currentBody),
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
  }
}

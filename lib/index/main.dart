import 'package:flutter/material.dart';
import 'package:instagram_flutter/controller/useful_widgets.dart';

class BottomNavigationBarIndex extends StatefulWidget {
  final Map<String, dynamic> user;
  const BottomNavigationBarIndex({Key? key, required this.user})
      : super(key: key);

  final _title =
      const Text('Instagram', style: TextStyle(fontFamily: 'Lobster-Regular'));

  @override
  State<BottomNavigationBarIndex> createState() =>
      _BottomNavigationBarIndexState();
}

class _BottomNavigationBarIndexState extends State<BottomNavigationBarIndex> {
  int _currentIndex = 0;
  static const Color _selectedItemColor = Colors.white;
  static const Color _unselectedItemColor = Colors.white70;

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

  final List<Widget> _widgetOptions = <Widget>[
    const Text('Início'),
    const Text('Pesquisar'),
    const Text('Reels'),
    const Text('Loja'),
    const Text('Perfil'),
  ];

  void itemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopeScopeExitApp(
        child: Scaffold(
      appBar: AppBar(
        title: widget._title,
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.add_box_outlined)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border)),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.message_outlined)),
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: _widgetOptions.elementAt(_currentIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _items,
        onTap: itemTapped,
        currentIndex: _currentIndex,
        selectedItemColor: _selectedItemColor,
        unselectedItemColor: _unselectedItemColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    ));
  }
}

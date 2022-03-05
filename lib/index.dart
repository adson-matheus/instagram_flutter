import 'package:flutter/material.dart';
import 'package:instagram_flutter/main.dart';

class Index extends StatefulWidget {
  final Map<String, dynamic> user;
  const Index({Key? key, required this.user}) : super(key: key);

  final _title =
      const Text('Instagram', style: TextStyle(fontFamily: 'Lobster-Regular'));

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  @override
  Widget build(BuildContext context) {
    return WillPopeScopeExitApp(
        child: Scaffold(
      appBar: AppBar(title: widget._title),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Text('Olá, ${widget.user['name']}.'),
            Text('@${widget.user['username']}'),
            Text('${widget.user['email']}')
          ],
        ),
      ),
    ));
  }
}

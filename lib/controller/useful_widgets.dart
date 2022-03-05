import 'package:flutter/material.dart';

class WillPopeScopeExitApp extends StatelessWidget {
  final Widget child;
  const WillPopeScopeExitApp({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          final result = await showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                    title: const Text('Sair?'),
                    content: const Text('Deseja sair?'),
                    actions: [
                      TextButton(
                          child: const Text('Não'),
                          onPressed: () => Navigator.pop(context, false)),
                      TextButton(
                          child: const Text('Sim'),
                          onPressed: () {
                            Navigator.pop(context, true);
                          }),
                    ],
                  ));
          return result;
        },
        child: child);
  }
}

class PaddingWithColumn extends StatelessWidget {
  final String number;
  final String text;
  const PaddingWithColumn({Key? key, required this.number, required this.text})
      : super(key: key);

  final _textStyle = const TextStyle(fontWeight: FontWeight.bold, fontSize: 16);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Text(
            number,
            style: _textStyle,
          ),
          Text(
            text,
            style: _textStyle,
          ),
        ],
      ),
    );
  }
}
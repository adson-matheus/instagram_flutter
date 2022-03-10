import 'package:flutter/material.dart';
import 'package:instagram_flutter/controller/useful_widgets.dart';

class ProfileSettings extends StatelessWidget {
  final int id;

  const ProfileSettings({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> _options = <Widget>[
      ListTile(
        leading: const Icon(Icons.exit_to_app),
        title: const Text('Sair'),
        onTap: () => logout(context),
      ),
      ListTile(
          leading: const Icon(Icons.highlight_remove),
          title: const Text('Deletar Conta'),
          onTap: () async => await delUserAlert(id, context)),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Configurações')),
      body: ListView.builder(
          itemCount: _options.length,
          itemBuilder: ((context, i) => _options[i])),
    );
  }
}

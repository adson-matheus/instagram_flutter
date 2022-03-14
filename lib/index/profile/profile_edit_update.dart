import 'package:flutter/material.dart';
import 'package:instagram_flutter/models/user.dart';

Future<bool> onPressedUpdate(
  GlobalKey<FormState> formKey,
  BuildContext context,
  Map<String, dynamic> user,
  TextEditingController username,
  TextEditingController email,
) async {
  if (formKey.currentState!.validate()) {
    bool userExists = false;
    bool emailExists = false;

    if (user['username'] != username.text) {
      userExists = await checkIfUserExists(username.text);
    }
    if (user['email'] != email.text) {
      emailExists = await checkIfEmailExists(email.text);
    }
    if (!userExists && !emailExists) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(seconds: 5),
          backgroundColor: Colors.teal,
          content: Text(
            'Dados salvos!',
            style: TextStyle(color: Colors.white),
          )));
      return true;
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Tente Novamente.'),
              content: userExists
                  ? emailExists
                      ? const Text('Usuário e email já existem!')
                      : const Text('Este usuário já existe')
                  : const Text('Este email já foi cadastrado'),
              actions: [
                TextButton(
                    child: const Text('Ok'),
                    onPressed: () => Navigator.of(context).pop())
              ],
            );
          });
      return false;
    }
  }
  return false;
}

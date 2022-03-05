import 'package:flutter/material.dart';
import 'package:instagram_flutter/models/user.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Text(
                  'Instagram',
                  style: TextStyle(fontSize: 48, fontFamily: 'Lobster-Regular'),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 16.0, left: 16.0, top: 10.0),
                        child: TextFormField(
                          controller: _username,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Insira um email ou nome de usuário.';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              hintText: 'email ou nome de usuário',
                              border: OutlineInputBorder()),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 16.0, left: 16.0, top: 10.0),
                        child: TextFormField(
                          controller: _password,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Insira uma senha.';
                            }
                            return null;
                          },
                          obscureText: true,
                          decoration: const InputDecoration(
                              hintText: 'Senha', border: OutlineInputBorder()),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                        minimumSize: MaterialStateProperty.all<Size>(
                            const Size(double.infinity, 50))),
                    child: const Text(
                      'Entrar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final Map<String, dynamic>? user =
                            await getUserByUsername(_username.text);
                        user == null
                            ? const ScaffoldMessenger(
                                child: SnackBar(
                                content: Text('Usuário não encontrado'),
                              ))
                            : Navigator.of(context).pushNamedAndRemoveUntil(
                                '/index', (Route<dynamic> route) => false,
                                arguments: user);
                      }
                    },
                  ),
                )
              ])),
    );
  }
}

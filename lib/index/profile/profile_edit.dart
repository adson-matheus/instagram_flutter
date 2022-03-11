import 'package:flutter/material.dart';
import 'package:instagram_flutter/controller/useful_widgets.dart';
import 'package:instagram_flutter/models/user.dart';

class EditProfile extends StatefulWidget {
  final Map<String, dynamic> user;
  const EditProfile({Key? key, required this.user}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final Text _title = const Text('Editar Perfil');

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _email = TextEditingController();

  Future<void> updateUser() async {
    User user = User(
        id: widget.user['id'],
        name: _name.text,
        username: _username.text,
        email: _email.text,
        password: widget.user['password']);
    await user.update();
  }

  @override
  void dispose() {
    _name.dispose();
    _username.dispose();
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: _title),
      body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: [
              Row(
                children: [
                  ClipOval(
                    child: Image.asset(
                      'assets/images/profile.jpg',
                      height: MediaQuery.of(context).size.height * 0.25,
                      width: MediaQuery.of(context).size.width * 0.25,
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        widget.user['username'],
                        style: const TextStyle(fontSize: 24),
                      ),
                      TextButton(
                          child: const Text('Alterar foto do perfil'),
                          onPressed: () {})
                    ],
                  ),
                ],
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      FormFieldWithPadding(
                        initialValue: widget.user['name'],
                        validatorReturn: 'Insira seu nome (máx. 50 caracteres)',
                        hintTextDecoration: 'Nome e sobrenome',
                        textInputType: TextInputType.name,
                        textCapitalization: TextCapitalization.words,
                        isPassword: false,
                        isEmail: false,
                        isUsername: false,
                      ),
                      FormFieldWithPadding(
                          initialValue: widget.user['username'],
                          validatorReturn:
                              'Nome de usuário sem espaços (máx. 20 caracteres)',
                          hintTextDecoration: 'Username',
                          textInputType: TextInputType.name,
                          textCapitalization: TextCapitalization.none,
                          isPassword: false,
                          isEmail: false,
                          isUsername: true),
                      FormFieldWithPadding(
                        initialValue: widget.user['email'],
                        validatorReturn: 'Digite um email válido.',
                        hintTextDecoration: 'Email',
                        textInputType: TextInputType.emailAddress,
                        textCapitalization: TextCapitalization.none,
                        isPassword: false,
                        isEmail: true,
                        isUsername: false,
                      ),
                      OutlinedButton(
                        child: const Text(
                          'Enviar',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blue)),
                        onPressed: () {},
                        // onPressed: () async {
                        //   final res = await result(context);
                        //   if (res) {
                        //     await updateUser();
                        //     ScaffoldMessenger.of(context).showSnackBar(
                        //       const SnackBar(
                        //           duration: Duration(seconds: 2),
                        //           backgroundColor: Colors.teal,
                        //           content: Text(
                        //             'Editado com sucesso!',
                        //             style: TextStyle(color: Colors.white),
                        //           )),
                        //     );
                        //   }
                        // },
                      )
                    ],
                  ))
            ],
          )),
    );
  }
}

Future<bool> result(context) async {
  final result = await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
            title: const Text('Salvar alterações?'),
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
}

class AlertEdit extends StatelessWidget {
  const AlertEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Salvar alterações?'),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Não')),
        TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Sim')),
      ],
    );
  }
}

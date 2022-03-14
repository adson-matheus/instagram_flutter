import 'package:flutter/material.dart';
import 'package:instagram_flutter/controller/useful_widgets.dart';
import 'package:instagram_flutter/index/profile/profile_edit_update.dart';
import 'package:instagram_flutter/models/user.dart';

class EditProfile extends StatefulWidget {
  final Map<String, dynamic> user;
  final Text _title = const Text('Editar Perfil');

  const EditProfile({Key? key, required this.user}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _email = TextEditingController();
  late Map<String, dynamic> user;

  @override
  void initState() {
    super.initState();
    user = widget.user;
    _name.text = user['name'];
    _username.text = user['username'];
    _email.text = user['email'];
  }

  @override
  void dispose() {
    _name.dispose();
    _username.dispose();
    _email.dispose();
    super.dispose();
  }

  Future<void> updateUser() async {
    User updatedUser = User(
      id: user['id'],
      name: _name.text,
      username: _username.text,
      email: _email.text,
      password: user['password'],
      followers: user['followers'],
      following: user['following'],
      totalPubs: user['totalPubs'],
    );
    setState(() {
      user = updatedUser.toMap();
    });
    await updatedUser.update();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: widget._title),
      body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/profile.jpg',
                            height: MediaQuery.of(context).size.height * 0.25,
                            width: MediaQuery.of(context).size.width * 0.25,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          user['username'],
                          style: const TextStyle(fontSize: 20),
                        ),
                        TextButton(
                            child: const Text('Alterar foto do perfil'),
                            onPressed: () {})
                      ],
                    ),
                  ],
                ),
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      FormFieldWithPadding(
                        controller: _name,
                        validatorReturn: 'Insira seu nome (máx. 50 caracteres)',
                        hintTextDecoration: 'Nome e sobrenome',
                        textInputType: TextInputType.name,
                        textCapitalization: TextCapitalization.words,
                        isPassword: false,
                        isEmail: false,
                        isUsername: false,
                      ),
                      FormFieldWithPadding(
                          controller: _username,
                          validatorReturn:
                              'Nome de usuário sem espaços (máx. 20 caracteres)',
                          hintTextDecoration: 'Username',
                          textInputType: TextInputType.name,
                          textCapitalization: TextCapitalization.none,
                          isPassword: false,
                          isEmail: false,
                          isUsername: true),
                      FormFieldWithPadding(
                        controller: _email,
                        validatorReturn: 'Digite um email válido.',
                        hintTextDecoration: 'Email',
                        textInputType: TextInputType.emailAddress,
                        textCapitalization: TextCapitalization.none,
                        isPassword: false,
                        isEmail: true,
                        isUsername: false,
                      ),
                      ElevatedButton(
                          child: const Text(
                            'Enviar',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blue)),
                          onPressed: () async {
                            if (_name.text != user['name'] ||
                                _username.text != user['username'] ||
                                _email.text != user['email']) {
                              bool canUpdate = await onPressedUpdate(
                                  _formKey, context, user, _username, _email);
                              if (canUpdate) {
                                await updateUser();
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/index', (route) => false,
                                    arguments: user);
                              }
                            }
                          })
                    ],
                  ))
            ],
          )),
    );
  }
}

// Future<bool> result(context) async {
//   final result = await showDialog(
//       context: context,
//       builder: (BuildContext context) => AlertDialog(
//             title: const Text('Salvar alterações?'),
//             actions: [
//               TextButton(
//                   child: const Text('Não'),
//                   onPressed: () => Navigator.pop(context, false)),
//               TextButton(
//                   child: const Text('Sim'),
//                   onPressed: () {
//                     Navigator.pop(context, true);
//                   }),
//             ],
//           ));
//   return result;
// }

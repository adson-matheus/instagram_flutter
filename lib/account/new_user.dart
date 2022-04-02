import 'package:flutter/material.dart';
import 'package:instagram_flutter/controller/useful_widgets.dart';
import 'package:instagram_flutter/models/user.dart';

class NewUser extends StatefulWidget {
  const NewUser({Key? key}) : super(key: key);

  @override
  State<NewUser> createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  Future<void> newUser() async {
    User user = User(
        name: _name.text,
        username: _username.text.toLowerCase(),
        password: _password.text,
        email: _email.text);
    await user.createUser();
  }

  @override
  void dispose() {
    _name.dispose();
    _username.dispose();
    _password.dispose();
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Instagram',
                style: TextStyle(fontSize: 48, fontFamily: 'Lobster-Regular'),
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
                    FormFieldWithPadding(
                        controller: _password,
                        validatorReturn:
                            'Insira uma senha (máx. 50 caracteres)',
                        hintTextDecoration: 'Senha',
                        textInputType: TextInputType.visiblePassword,
                        textCapitalization: TextCapitalization.none,
                        isPassword: true,
                        isEmail: false,
                        isUsername: false),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, right: 16.0, left: 16.0),
                      child: TextButton(
                        child: const Text(
                          'Cadastrar',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white),
                            elevation: MaterialStateProperty.all(5.0),
                            minimumSize: MaterialStateProperty.all<Size>(
                                Size(MediaQuery.of(context).size.width, 50)),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blue)),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            bool userExists =
                                await checkIfUserExists(_username.text);
                            bool emailExists =
                                await checkIfEmailExists(_email.text);

                            if (!userExists && !emailExists) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                      duration: const Duration(seconds: 5),
                                      backgroundColor: Colors.teal,
                                      content: Text(
                                        'Bem vindo, ${_username.text.toLowerCase()}',
                                        style: const TextStyle(
                                            color: Colors.white),
                                      )));
                              newUser();
                              Navigator.popAndPushNamed(context, '/login');
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Tente Novamente.'),
                                      content: userExists
                                          ? emailExists
                                              ? const Text(
                                                  'Usuário e email já existem!')
                                              : const Text(
                                                  'Este usuário já existe')
                                          : const Text(
                                              'Este email já foi cadastrado'),
                                      actions: [
                                        TextButton(
                                            child: const Text('Ok'),
                                            onPressed: () =>
                                                Navigator.of(context).pop())
                                      ],
                                    );
                                  });
                            }
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

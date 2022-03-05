import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
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

  //envia uma mensagem usando o gmail
  //nao eh exatamente o que quero
  Future<void> sendEmail() async {
    Email email = Email(
        recipients: [_email.text],
        subject: 'Olá, ${_name.text}',
        body: 'Bem vindo ao Instagram Flutter!',
        isHTML: false);

    await FlutterEmailSender.send(email);
  }

  Future<void> newUser() async {
    User user = User(
        name: _name.text,
        username: _username.text,
        password: _password.text,
        email: _email.text);
    await user.createUser(user);
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
      body: SizedBox(
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Padding(
                  padding: EdgeInsets.only(top: 0.0),
                  child: Text(
                    'Instagram',
                    style:
                        TextStyle(fontSize: 48, fontFamily: 'Lobster-Regular'),
                  ),
                ),
              ],
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  FormFieldWithPadding(
                    controller: _name,
                    validatorReturn: 'Insira seu nome',
                    hintTextDecoration: 'Nome e sobrenome',
                    isPassword: false,
                    isEmail: false,
                  ),
                  FormFieldWithPadding(
                      controller: _username,
                      validatorReturn: 'Insira um nome de usuário.',
                      hintTextDecoration: 'Username',
                      isPassword: false,
                      isEmail: false),
                  FormFieldWithPadding(
                    controller: _email,
                    validatorReturn: 'Digite um email válido.',
                    hintTextDecoration: 'Email',
                    isPassword: false,
                    isEmail: true,
                  ),
                  FormFieldWithPadding(
                    controller: _password,
                    validatorReturn: 'Insira uma senha.',
                    hintTextDecoration: 'Senha',
                    isPassword: true,
                    isEmail: false,
                  ),
                  TextButton(
                    child: const Text('Cadastrar'),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                duration: Duration(seconds: 2),
                                backgroundColor: Colors.white,
                                content: Text('Aguarde...')));
                        const CircularProgressIndicator(
                          semanticsLabel: 'Carregando...',
                        );
                        newUser();

                        Navigator.popAndPushNamed(context, '/login');
                        //sendEmail();

                        //dispose();
                      }
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FormFieldWithPadding extends StatelessWidget {
  final TextEditingController controller;
  final String validatorReturn;
  final String hintTextDecoration;
  final bool isPassword;
  final bool isEmail;

  const FormFieldWithPadding(
      {Key? key,
      required this.controller,
      required this.validatorReturn,
      required this.hintTextDecoration,
      required this.isPassword,
      required this.isEmail})
      : super(key: key);

  bool emailValidator() {
    return EmailValidator.validate(controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0, left: 16.0, top: 10.0),
      child: TextFormField(
          controller: controller,
          obscureText: isPassword,
          decoration: InputDecoration(
              hintText: validatorReturn, border: const OutlineInputBorder()),
          validator: isEmail
              ? (value) {
                  if (!emailValidator()) {
                    return validatorReturn;
                  }
                  return null;
                }
              : (value) {
                  if (value == null || value.isEmpty) {
                    return validatorReturn;
                  }
                  return null;
                }),
    );
  }
}
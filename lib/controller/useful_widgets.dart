import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:instagram_flutter/models/user.dart';

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
  final int number;
  final String text;
  const PaddingWithColumn({Key? key, required this.number, required this.text})
      : super(key: key);

  final _textStyle = const TextStyle(fontWeight: FontWeight.bold, fontSize: 14);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Column(
        children: <Widget>[
          Text(
            number.toString(),
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

void logout(BuildContext context) {
  Navigator.of(context)
      .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
}

Future<void> delUserAlert(id, context) async {
  final result = await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
            title: const Text('EXCLUIR sua conta?'),
            content: const Text('Você realmente deseja excluir sua conta?'),
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
  if (result) {
    logout(context);
    await deleteUser(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(seconds: 5),
        backgroundColor: Colors.white,
        content: Text('Sua conta foi excluída permanentemente.')));
  }
}

class FormFieldWithPadding extends StatelessWidget {
  final TextEditingController? controller;
  final String? initialValue;
  final String validatorReturn;
  final String hintTextDecoration;
  final TextInputType textInputType;
  final TextCapitalization textCapitalization;
  final bool isPassword;
  final bool isEmail;
  final bool isUsername;

  const FormFieldWithPadding(
      {Key? key,
      this.controller,
      required this.validatorReturn,
      required this.hintTextDecoration,
      required this.textInputType,
      required this.textCapitalization,
      required this.isPassword,
      required this.isEmail,
      required this.isUsername,
      this.initialValue})
      : super(key: key);

  bool emailValidator() {
    return EmailValidator.validate(controller!.text);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0, left: 16.0, top: 10.0),
      child: TextFormField(
          controller: controller,
          obscureText: isPassword,
          keyboardType: textInputType,
          textCapitalization: textCapitalization,
          initialValue: initialValue,
          enableSuggestions: false,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            label: Text(hintTextDecoration),
          ),
          validator: isEmail
              ? (value) {
                  if (!emailValidator()) {
                    return validatorReturn;
                  }
                  return null;
                }
              : isUsername
                  ? (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.contains(' ') ||
                          value.length > 20) {
                        return validatorReturn;
                      }
                      return null;
                    }
                  : (value) {
                      if (value == null || value.isEmpty || value.length > 50) {
                        return validatorReturn;
                      }
                      return null;
                    }),
    );
  }
}

class ListUsersReusable extends StatefulWidget {
  final List<Map<String, dynamic>> content;
  final int index;
  final int loggedUserId;
  const ListUsersReusable({
    Key? key,
    required this.content,
    required this.index,
    required this.loggedUserId,
  }) : super(key: key);

  @override
  State<ListUsersReusable> createState() => _ListUsersReusableState();
}

class _ListUsersReusableState extends State<ListUsersReusable> {
  late List<Map<String, dynamic>> content;
  late int index;
  late int loggedUserId;
  @override
  void initState() {
    super.initState();
    content = widget.content;
    index = widget.index;
    loggedUserId = widget.loggedUserId;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: SizedBox(
          width: 56,
          height: 100,
          child: ClipOval(
            child: Image.memory(
              content[index]['picture'],
              width: 327,
              height: 327,
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(
          content[index]['username'],
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          content[index]['name'],
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        contentPadding: EdgeInsets.zero,
        style: ListTileStyle.list,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        horizontalTitleGap: 10,
        onTap: () => Navigator.of(context).pushNamed('/visit_profile',
            arguments: [content[index], loggedUserId]),
      ),
    );
  }
}

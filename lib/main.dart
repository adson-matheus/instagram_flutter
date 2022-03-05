import 'package:flutter/material.dart';
import 'package:instagram_flutter/controller/useful_widgets.dart';
import 'package:instagram_flutter/routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram Flutter',
      theme: ThemeData.dark(),
      home: const MainPage(),
      onGenerateRoute: generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopeScopeExitApp(
        child: Scaffold(
      body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: ListView(
            children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 300.0),
                      child: Text(
                        'Instagram',
                        style: TextStyle(
                            fontSize: 48, fontFamily: 'Lobster-Regular'),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: TextButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.blue),
                              minimumSize: MaterialStateProperty.all<Size>(
                                  const Size(double.infinity, 50))),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const <Widget>[
                                Icon(
                                  Icons.login,
                                  color: Colors.white,
                                ),
                                Text(
                                  ' Entrar',
                                  style: TextStyle(color: Colors.white),
                                )
                              ]),
                          onPressed: () =>
                              Navigator.pushNamed(context, '/login'),
                        )),
                    const Padding(
                      padding: EdgeInsets.only(top: 80.0, bottom: 5.0),
                      child: Text(
                        'OU',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 80.0),
                      child: TextButton(
                        child: Text('Cadastre-se com o e-mail',
                            style: TextStyle(color: Colors.blue.shade400)),
                        onPressed: () {
                          Navigator.pushNamed(context, '/new/user');
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Já tem uma conta?',
                          style: TextStyle(color: Colors.white70),
                        ),
                        TextButton(
                          child: Text(
                            'Entrar',
                            style: TextStyle(color: Colors.blue.shade800),
                          ),
                          onPressed: () =>
                              Navigator.pushNamed(context, '/login'),
                        ),
                      ],
                    ),
                  ]),
            ],
          )),
    ));
  }
}

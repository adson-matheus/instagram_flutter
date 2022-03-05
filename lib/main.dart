import 'package:flutter/material.dart';
import 'package:instagram_flutter/routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram Flutter',
      theme: ThemeData.dark(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          //primarySwatch: Colors.blue,
          ),
      home: const MainPage(),
      onGenerateRoute: generateRoute,
      initialRoute: '/login',
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

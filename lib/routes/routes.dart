import 'package:flutter/material.dart';
import 'package:instagram_flutter/account/new_user.dart';
import 'package:instagram_flutter/index.dart';
import 'package:instagram_flutter/login/login.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/login':
      return MaterialPageRoute(builder: (_) => const LoginPage());
    case '/new/user':
      return MaterialPageRoute(builder: (_) => const NewUser());
    case '/index':
      final user = settings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(builder: (_) => Index(user: user));
    default:
      return MaterialPageRoute(builder: (_) => const LoginPage());
  }
}

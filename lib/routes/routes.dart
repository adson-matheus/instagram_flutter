import 'package:flutter/material.dart';
import 'package:instagram_flutter/account/new_user.dart';
import 'package:instagram_flutter/index/main.dart';
import 'package:instagram_flutter/index/profile/profile_settings.dart';
import 'package:instagram_flutter/login/login.dart';
import 'package:instagram_flutter/main.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (_) => const MainPage());
    case '/login':
      return MaterialPageRoute(builder: (_) => const LoginPage());
    case '/new/user':
      return MaterialPageRoute(builder: (_) => const NewUser());
    case '/index':
      final user = settings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
          builder: (_) => BottomNavigationBarIndex(user: user));
    case '/profile_settings':
      final id = settings.arguments as int;
      return MaterialPageRoute(builder: (_) => ProfileSettings(id: id));
    default:
      return MaterialPageRoute(builder: (_) => const LoginPage());
  }
}

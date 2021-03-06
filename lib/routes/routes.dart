import 'package:flutter/material.dart';
import 'package:instagram_flutter/account/new_user.dart';
import 'package:instagram_flutter/index/visit_profile/visit_profile.dart';
import 'package:instagram_flutter/controller/get_followers.dart';
import 'package:instagram_flutter/index/main.dart';
import 'package:instagram_flutter/index/profile/profile_edit.dart';
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
      final args = settings.arguments as List<Object>;
      final user = args[0] as Map<String, dynamic>;
      if (args.length > 1) {
        final selectBody = args[1] as int;
        return MaterialPageRoute(
            builder: (_) =>
                BottomNavigationBarIndex(user: user, selectBody: selectBody));
      }
      return MaterialPageRoute(
          builder: (_) => BottomNavigationBarIndex(user: user));
    case '/profile_settings':
      final id = settings.arguments as int;
      return MaterialPageRoute(builder: (_) => ProfileSettings(id: id));
    case '/profile_edit':
      final args = settings.arguments as List<Map<String, dynamic>>;
      final user = args[0];
      final profilePicture = args[1];
      return MaterialPageRoute(
          builder: (_) =>
              EditProfile(user: user, profilePicture: profilePicture));
    case '/visit_profile':
      final args = settings.arguments as List<Object>;
      final user = args[0] as Map<String, dynamic>;
      final loggedUserId = args[1] as int;
      final loggedUserIsFollowing = args[2] as bool;
      return MaterialPageRoute(
          builder: (_) => VisitProfileWidget(
                user: user,
                loggedUserId: loggedUserId,
                loggedUserIsFollowing: loggedUserIsFollowing,
              ));
    case '/get_followers_from_user':
      final args = settings.arguments as List<int>;
      final userId = args[0];
      final loggedUserId = args[1];
      return MaterialPageRoute(
          builder: (_) => GetFollowersFromUserWidget(
                userId: userId,
                loggedUserId: loggedUserId,
              ));
    default:
      return MaterialPageRoute(builder: (_) => const LoginPage());
  }
}

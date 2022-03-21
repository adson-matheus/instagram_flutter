import 'package:flutter/material.dart';
import 'package:instagram_flutter/models/user.dart';
import 'list_users_from_search.dart';

class SearchPageWidget extends StatefulWidget {
  const SearchPageWidget({Key? key}) : super(key: key);

  @override
  State<SearchPageWidget> createState() => _SearchPageWidgetState();
}

class _SearchPageWidgetState extends State<SearchPageWidget> {
  bool showList = false;
  List<Map<String, dynamic>>? users;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Pesquisar',
            ),
            keyboardType: TextInputType.name,
            autocorrect: false,
            autofocus: true,
            maxLength: 50,
            onSubmitted: (value) async {
              if (value.isNotEmpty) {
                final getUsers = await getUsersAndProfilePictures(value);
                showList = true;
                setState(() {
                  users = getUsers;
                });
              }
            },
          ),
        ),
        if (showList) Expanded(child: ListUsersFromSearchWidget(users: users))
      ],
    );
  }
}

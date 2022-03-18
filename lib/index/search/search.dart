import 'package:flutter/material.dart';
import 'package:instagram_flutter/models/user.dart';

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

class ListUsersFromSearchWidget extends StatelessWidget {
  final List<Map<String, dynamic>>? users;
  const ListUsersFromSearchWidget({Key? key, required this.users})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return users != null
        ? ListView.builder(
            itemCount: users!.length,
            itemBuilder: ((context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: SizedBox(
                    width: 56,
                    height: 100,
                    child: ClipOval(
                      child: Image.memory(
                        users![index]['picture'],
                        width: 327,
                        height: 327,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Text(
                    users![index]['username'],
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    users![index]['name'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  contentPadding: EdgeInsets.zero,
                  style: ListTileStyle.list,
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                  horizontalTitleGap: 10,
                  onTap: () {},
                ),
              );
            }))
        : const SizedBox(
            child: Align(
                alignment: Alignment.topCenter, child: Text('Sem resultados')),
          );
  }
}

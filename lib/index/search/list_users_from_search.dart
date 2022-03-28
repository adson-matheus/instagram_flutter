import 'package:flutter/material.dart';
import 'package:instagram_flutter/controller/useful_widgets.dart';

class ListUsersFromSearchWidget extends StatelessWidget {
  final List<Map<String, dynamic>>? users;
  final int loggedUserId;
  const ListUsersFromSearchWidget({
    Key? key,
    required this.users,
    required this.loggedUserId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return users != null
        ? ListView.builder(
            itemCount: users!.length,
            itemBuilder: ((context, index) {
              return ListUsersReusable(
                content: users!,
                index: index,
                loggedUserId: loggedUserId,
              );
            }))
        : const SizedBox(
            child: Align(
                alignment: Alignment.topCenter, child: Text('Sem resultados')),
          );
  }
}

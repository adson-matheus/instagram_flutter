import 'package:flutter/material.dart';

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

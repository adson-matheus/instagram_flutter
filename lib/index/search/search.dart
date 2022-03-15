import 'package:flutter/material.dart';
import 'package:instagram_flutter/models/user.dart';
import 'package:searchfield/searchfield.dart';

class SearchPageWidget extends StatefulWidget {
  const SearchPageWidget({Key? key}) : super(key: key);

  @override
  State<SearchPageWidget> createState() => _SearchPageWidgetState();
}

class _SearchPageWidgetState extends State<SearchPageWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Map<String, dynamic>>?>(
          future: getUsers(),
          builder:
              ((context, AsyncSnapshot<List<Map<String, dynamic>>?> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, itemCount) {
                    return SearchField(
                        suggestions: snapshot.data!
                            .map(
                                (user) => SearchFieldListItem(user['username']))
                            .toList());
                  });
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else {
              return Column(
                children: const [
                  Text('Carregando...'),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(),
                  ),
                ],
              );
            }
          })),
    );
  }
}

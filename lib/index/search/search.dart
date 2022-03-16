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
          future: getUsersAndProfilePictures(),
          builder:
              ((context, AsyncSnapshot<List<Map<String, dynamic>>?> snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: SearchField(
                  suggestions: snapshot.data!
                      .map((user) => SearchFieldListItem(user['username'],
                          item: user,
                          child: ListTile(
                            leading: SizedBox(
                              width: 56,
                              height: 100,
                              child: ClipOval(
                                child: Image.memory(
                                  user['picture'],
                                  width: 327,
                                  height: 327,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            title: Text(
                              user['username'],
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text(
                              user['name'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            contentPadding: EdgeInsets.zero,
                          )))
                      .toList(),
                  hint: 'Pesquisar',
                  hasOverlay: false,
                  maxSuggestionsInViewPort: 5,
                  itemHeight: 100.0,
                  suggestionState: Suggestion.hidden,
                  searchStyle: const TextStyle(
                    height: 2.0,
                    overflow: TextOverflow.ellipsis,
                  ),
                  emptyWidget: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: const Align(
                        alignment: Alignment.topCenter,
                        child: Text('Sem resultados')),
                  ),
                ),
              );
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

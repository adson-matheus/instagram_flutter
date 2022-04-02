import 'package:flutter/material.dart';
import 'package:instagram_flutter/models/post_picture.dart';

class ViewPostsWidget extends StatefulWidget {
  final Map<String, dynamic> user;
  const ViewPostsWidget({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<ViewPostsWidget> createState() => _ViewPostsWidgetState();
}

class _ViewPostsWidgetState extends State<ViewPostsWidget> {
  late Map<String, dynamic> user;

  @override
  void initState() {
    super.initState();
    user = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>?>(
      future: getPosts(user['id']),
      builder: (BuildContext context,
          AsyncSnapshot<List<Map<String, dynamic>>?> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.only(bottom: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: Image.memory(
                        snapshot.data![index]['picture'],
                        fit: BoxFit.fitWidth,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: IconButton(
                            icon: const Icon(
                              Icons.favorite_border_outlined,
                            ),
                            iconSize: 30.0,
                            onPressed: () {},
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: IconButton(
                            icon: const Icon(
                              Icons.insert_comment_outlined,
                            ),
                            iconSize: 30.0,
                            onPressed: () {},
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: IconButton(
                            icon: const Icon(
                              Icons.send,
                            ),
                            iconSize: 30.0,
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(snapshot.data![index]['listWhoLiked'] == null
                          ? '0 curtidas'
                          : 'Ver curtidas'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        user['username'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        snapshot.data![index]['date'],
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10.0,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}

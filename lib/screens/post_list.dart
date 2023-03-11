import 'package:flutter/material.dart';
import 'package:flutter_crud_app/firestore_service.dart';
import '../model/models.dart';
import 'screens.dart';

class PostList extends StatelessWidget {
  const PostList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Firestore CRUD'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/addPost');
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: StreamBuilder<List<Post>>(
          stream: FirestoreService().getPosts(),
          builder: (context, snapshot) {
        
            if (snapshot.hasData) {
              final posts = snapshot.data!;

              if (snapshot.data!.isNotEmpty) {
                return ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              post.title,
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              post.content,
                              style: const TextStyle(fontSize: 16.0),
                            ),
                            const SizedBox(height: 8.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    FirestoreService().deletePost(post.id);
                                  },
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                                const SizedBox(width: 16.0),
                                GestureDetector(
                                  onTap: () {
                                    // Navigator.pushNamed(context, '/addPost',
                                    //     arguments: "post");
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              AddPost(post: post),
                                        ));
                                  },
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const Center(child: Text("No Data Found"));
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}

class Post {
  final String id;
  final String title;
  final String content;

  Post({required this.id, required this.title, required this.content});

  factory Post.fromMap(Map<String, dynamic> data, String id) {
    return Post(
      id: id,
      title: data['title'],
      content: data['content'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
    };
  }
}

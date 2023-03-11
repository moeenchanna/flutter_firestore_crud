// Importing the required package and model
import 'package:cloud_firestore/cloud_firestore.dart';
import 'model/post.dart';

// Defining a class to handle Firestore service
class FirestoreService {
  // Getting an instance of Firestore
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Function to get all Posts from Firestore
  Stream<List<Post>> getPosts() {
    return _db.collection('posts').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Post.fromMap(doc.data(), doc.id)).toList());
  }

  // Function to add a Post to Firestore
  Future<void> addPost(Post post) {
    return _db.collection('posts').add(post.toMap());
  }

  // Function to update a Post in Firestore
  Future<void> updatePost(Post post) {
    return _db.collection('posts').doc(post.id).update(post.toMap());
  }

  // Function to delete a Post from Firestore
  Future<void> deletePost(String id) {
    return _db.collection('posts').doc(id).delete();
  }
}

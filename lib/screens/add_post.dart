import 'package:flutter/material.dart';
import 'package:flutter_crud_app/firestore_service.dart';
import '../model/models.dart';

class AddPost extends StatefulWidget {
  final Post? post;

  const AddPost({super.key, this.post});

  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final _formKey = GlobalKey<FormState>();
  final _firestoreService = FirestoreService();

  String _id = '';
  String _title = '';
  String _content = '';

  @override
  void initState() {
    super.initState();

    if (widget.post != null) {
      _id = widget.post!.id;
      _title = widget.post!.title;
      _content = widget.post!.content;    
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post == null ? 'Add Post' : 'Edit Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                initialValue: _title,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _title = value;
                  });
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                initialValue: _content,
                maxLines: null,
                decoration: const InputDecoration(
                  labelText: 'Content',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some content';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _content = value;
                  });
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if (widget.post == null) {
                      await _firestoreService.addPost(
                          Post(title: _title, content: _content, id: _id));
                    } else {
                      await _firestoreService.updatePost(
                          Post(id: _id, title: _title, content: _content));
                    }
                    Navigator.pop(context);
                  }
                },
                child: Text(widget.post == null ? 'Add Post' : 'Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

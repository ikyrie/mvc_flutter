import 'package:flutter/material.dart';
import 'package:mvc/controllers/post_controller.dart';
import 'package:mvc/models/post.dart';

import '../models/post_form_model.dart';

class PostDetails extends StatefulWidget {
  const PostDetails({super.key});

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  final PostController postController = PostController();

  @override
  Widget build(BuildContext context) {
    final currentPost = ModalRoute.of(context)!.settings.arguments as Post;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder(
            future: postController.getPostInfo(currentPost),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  break;
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator(),);
                case ConnectionState.active:
                  break;
                case ConnectionState.done:
                  if(snapshot.hasData) {
                    final Post post = snapshot.data as Post;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 32.0),
                          child: Text(post.title, style: Theme.of(context).textTheme.displayMedium,),
                        ),
                        Text(post.content, style: Theme.of(context).textTheme.bodyMedium,),
                        const Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Divider(),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            TextButton(
                                onPressed: () => openForm(context, post),
                                child: const Text(
                                  "Edit",
                                  style: TextStyle(color: Colors.blue),
                                )),
                            TextButton(
                                onPressed: () {
                                  postController.deletePost(post);
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  "Delete",
                                  style: TextStyle(color: Colors.red),
                                )),
                          ],
                        )
                      ],
                    );
                  }
              }
              return Container();
            }
          ),
        ),
      ),
    );
  }

  Future<dynamic> openForm(BuildContext context, Post post) {
    final formKey = GlobalKey<FormState>();
    final PostFormModel postFormModel = PostFormModel(id: post.id);

    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Post"),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
              TextFormField(
                initialValue: post.title,
                validator: (value) {
                  postFormModel.title = value;
                  if(postFormModel.validateTitle()) {
                    return null;
                  } else {
                    return "Please enter a title";
                  }
                },
                decoration: const InputDecoration(hintText: "Title"),
              ),
              TextFormField(
                initialValue: post.content,
                validator: (value) {
                  postFormModel.content = value;
                  if(postFormModel.validateContent()) {
                    return null;
                  } else {
                    return "Please enter a content";
                  }
                },
                decoration: const InputDecoration(hintText: "Content"),
                maxLines: 4,
              ),
            ],),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                if(formKey.currentState!.validate()) {
                  if(postFormModel.createPost() != null) {
                    postController.addPost(postFormModel.createPost()!);
                    Navigator.pop(context);
                    setState(() {});
                  }
                }
              },
              child: const Text("Save"),
            ),
          ],
        );
      },);
  }
}

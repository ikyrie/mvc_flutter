import 'package:flutter/material.dart';
import 'package:mvc/controllers/post_controller.dart';
import 'package:mvc/models/post.dart';
import 'package:mvc/models/post_form_model.dart';

class Home extends StatefulWidget {
const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();

}

class _HomeState extends State<Home> {
  final PostController postController = PostController();
  List<Post> posts = [];

  @override
  void initState() {
    posts = postController.getPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return SafeArea(child: Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => openForm(context),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: _PostCard(post: Post(title: posts[index].title, content: posts[index].content)),
        ),
        itemCount: posts.length,),
    ),);
  }

  Future<dynamic> openForm(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final PostFormModel postFormModel = PostFormModel();

    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("New Post"),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
              TextFormField(
                validator: (value) {
                  postFormModel.setTitle(value);
                  if(postFormModel.validateTitle()) {
                    return null;
                  } else {
                    return "Please enter a title";
                  }
                },
                decoration: const InputDecoration(hintText: "Title"),
              ),
              TextFormField(
                validator: (value) {
                  postFormModel.setContent(value);
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
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                if(_formKey.currentState!.validate()) {
                  postController.addPost(postFormModel.getTitle()!, postFormModel.getContent()!);
                  Navigator.pop(context);
                  setState(() {});
                }
              },
              child: Text("Add"),
            ),
          ],
        );
      },);
  }
}

class _PostCard extends StatelessWidget {
  const _PostCard({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Card(child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(post.title, style: Theme.of(context).textTheme.titleLarge,),
        ),
        Text(post.content, style: Theme.of(context).textTheme.bodyMedium, maxLines: 3, overflow: TextOverflow.fade),
        TextButton(onPressed: () => Navigator.pushNamed(context, '/postDetails', arguments: post), child: const Text("See all"),)
      ],),
    ),);
  }
}

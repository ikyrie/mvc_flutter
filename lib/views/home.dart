import 'package:flutter/material.dart';
import 'package:mvc/controllers/post_controller.dart';
import 'package:mvc/models/post.dart';

class Home extends StatefulWidget {
const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();

}

class _HomeState extends State<Home> {
  final PostController postController = PostController();
  List<Post> posts = [];
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

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
        onPressed: () => showDialog(context: context,
        builder: (context) => AlertDialog(
          title: const Text("New Post"),
          content: _DialogContent(titleController: titleController, contentController: contentController),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                clearDialogInput();
                Navigator.pop(context, 'Cancel');
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                postController.addPost(titleController.text, contentController.text);
                clearDialogInput();
                Navigator.pop(context, 'Ok');
                setState(() { });
              },
              child: const Text('Ok'),
            ),
          ],
        )),
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

  void clearDialogInput() {
    titleController.text = '';
    contentController.text = '';
  }
}

class _DialogContent extends StatelessWidget {
  const _DialogContent({
    super.key,
    required this.titleController,
    required this.contentController,
  });

  final TextEditingController titleController;
  final TextEditingController contentController;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        TextFormField( controller: titleController, decoration: const InputDecoration(hintText: "Title"),),
        TextFormField(maxLines: 4, controller: contentController, decoration: const InputDecoration(hintText: "Content")),
      ],
    );
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

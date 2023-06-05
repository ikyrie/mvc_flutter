import 'package:flutter/material.dart';
import 'package:mvc/models/post.dart';

class PostDetails extends StatelessWidget {
  const PostDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final post = ModalRoute.of(context)!.settings.arguments as Post;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(post.title, style: Theme.of(context).textTheme.titleLarge,),
              ),
              Text(post.content, style: Theme.of(context).textTheme.bodyMedium,),
          ],),
        ),
      ),
    );
  }
}

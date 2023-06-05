import 'package:mvc/models/post.dart';

class PostController {
  List<Post> posts = [];

  void addPost(String title, String content) {
    final Post newPost = Post(title: title, content: content);
    posts.add(newPost);
  }

  List<Post> getPosts() {
    return posts;
  }


}

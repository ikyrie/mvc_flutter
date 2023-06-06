import 'package:mvc/models/post.dart';

class PostController {
  List<Post> posts = [];

  void addPost(Post post) {
    posts.add(post);
  }

  List<Post> getPosts() {
    return posts;
  }


}

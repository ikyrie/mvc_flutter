import 'package:mvc/data/post_database.dart';
import 'package:mvc/models/post.dart';

class PostController {
  List<Post> posts = [];
  final PostDatabase dao = PostDatabase();

  void addPost(Post post) async {
    await dao.save(post);
  }

  Future<List<Post>> getPosts() async {
    posts = await dao.findAll();
    return posts;
  }


}

import 'package:mvc/data/post_database.dart';
import 'package:mvc/models/post.dart';

class PostController {
  final PostDatabase _dao = PostDatabase();

  void addPost(Post post) async {
    await _dao.save(post);
  }

  Future<List<Post>> getPosts() async {
    List<Post> posts = [];
    posts = await _dao.findAll();
    return posts;
  }

  Future<Post> getPostInfo(Post post) async {
    Post content = await _dao.findById(post.id!);
    return content;
  }

  Future<void> deletePost(Post post) async {
    _dao.delete(post);
  }


}

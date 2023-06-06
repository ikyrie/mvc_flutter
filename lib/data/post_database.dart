import 'package:mvc/models/post.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class PostDatabase {
  static const String _tableName = "postTable";
  static const String _postId = "post_id";
  static const String _title = "title";
  static const String _content = "content";

  static const String createTableSQL =
      "CREATE TABLE $_tableName($_postId INTEGER NOT NULL PRIMARY KEY, $_title TEXT,$_content TEXT)";

  save(Post post) async {
    print("SAVE");

    Map<String, dynamic> postMap = _toMap(post);

    final Database database = await _getDatabase();

    if (post.id == null) {
      print("CREATING ${post.title}");
      return await database.insert(_tableName, postMap);
    } else {
      print("UPDATING ${post.title}");
      return await database.update(
        _tableName,
        postMap,
        where: "$_postId = ?",
        whereArgs: [post.id],
      );
    }
  }

  Future<List<Post>> findAll() async {
    print("FIND ALL");

    final Database database = await _getDatabase();
    final List<Map<String, dynamic>> result = await database.query(_tableName);

    print(result);

    return _toList(result);
  }

  Future<List<Post>> _find(String column, dynamic arg) async {
    print("FIND");
    final Database database = await _getDatabase();
    final List<Map<String, dynamic>> result = await database.query(
      _tableName,
      where: "$column = ?",
      whereArgs: [arg],
    );
    print(result);
    return _toList(result);
  }

  Future<Post> findById(int id) async {
    List<Post> result = await _find(_postId, id);
    if (result.isNotEmpty) {
      return result[0];
    }
    throw PostNotFindException();
  }

  Future<List<Post>> findByTitle(String title) async {
    return await _find(_title, title);
  }

  delete(Post post) async {
    print("DELETE");

    final Database database = await _getDatabase();

    return await database.delete(
      _tableName,
      where: "$_postId = ?",
      whereArgs: [post.id],
    );
  }

  Future<Database> _getDatabase() async {
    final String path = join(await getDatabasesPath(), "post.db");
    return openDatabase(
      path,
      onCreate: (db, version) {
        db.execute(createTableSQL);
      },
      version: 1,
    );
  }

  List<Post> _toList(List<Map<String, dynamic>> result) {
    final List<Post> listPost = [];
    for (Map<String, dynamic> map in result) {
      listPost.add(
        Post(id: map[_postId], title: map[_title], content: map[_content]),
      );
    }
    return listPost;
  }

  Map<String, dynamic> _toMap(Post post) {
    return {
      _postId: post.id,
      _title: post.title,
      _content: post.content,
    };
  }
}

class PostNotFindException implements Exception {}

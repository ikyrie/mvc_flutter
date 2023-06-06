import 'package:flutter/material.dart';
import 'package:mvc/data/post_database.dart';
import 'package:mvc/routes/app_routes.dart';
import 'package:mvc/views/home.dart';
import 'package:mvc/views/post_details.dart';

import 'models/post.dart';

void main() {
  runApp(const FaceBeek());

  testingSQL();
}

testingSQL() async {
  PostDatabase postDatabase = PostDatabase();

  await postDatabase.save(
    Post(title: "MVC Flutter", content: "Saiu curso novo na Alura!"),
  );

  await postDatabase.save(
    Post(
        title: "Só Love!",
        content:
            "Com dois gols de Vagner Love, Sport vence Londrina fora de casa!"),
  );

  await postDatabase.findAll();

  List<Post> listPost = await postDatabase.findByTitle("MVC Flutter");

  await postDatabase.delete(listPost.first);

  await postDatabase.findAll();
}

class FaceBeek extends StatelessWidget {
  const FaceBeek({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:
          ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink)),
      initialRoute: AppRoutes.home,
      routes: {
        AppRoutes.home: (context) => const Home(),
        AppRoutes.post: (context) => const PostDetails(),
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mvc/routes/app_routes.dart';
import 'package:mvc/views/home.dart';
import 'package:mvc/views/post_details.dart';

void main() {
  runApp(const FaceBeek());
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

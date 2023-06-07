import 'package:mvc/models/post.dart';

class PostFormModel {
  String? title;
  String? content;

  PostFormModel({this.title, this.content});

  bool validateTitle() {
    return title != null && title != '';
  }

  bool validateContent() {
    return content != null && content != '';
  }

  bool _validateForm() {
    return validateTitle() && validateContent();
  }

  Post? createPost() {
    if(_validateForm()){
      return Post(title: title!, content: content!);
    } else {
      return null;
    }
  }

}

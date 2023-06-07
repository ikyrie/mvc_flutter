import 'package:mvc/models/post.dart';

class PostFormModel {
  int? id;
  String? title;
  String? content;

  PostFormModel({this.id, this.title, this.content});

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
      if(id != null) {
        return Post(id: id!, title: title!, content: content!);
      } else {
        return Post(title: title!, content: content!);
      }
    } else {
      return null;
    }
  }

}

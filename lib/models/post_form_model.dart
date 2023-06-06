class PostFormModel {
  String? title;
  String? content;

  PostFormModel({this.title, this.content});

  void setTitle(String? title) {
    this.title = title;
  }

  void setContent(String? content) {
    this.content = content;
  }

  String? getTitle() {
    return title;
  }

  String?  getContent() {
    return content;
  }

  bool validateTitle() {
    return title != null && title != '';
  }

  bool validateContent() {
    return content != null && content != '';
  }

}

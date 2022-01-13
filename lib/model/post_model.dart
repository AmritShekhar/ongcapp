class PostModel {
  String title;
  String basin;
  String description;
  String post_date;
  String user;
  String id_post;

  PostModel(
      {this.title = "",
      this.basin = "",
      this.description = "",
      this.user = "",
      this.id_post = "",
      this.post_date = ""});

  factory PostModel.fromJSON(Map<String, dynamic> j) {
    return PostModel(
        id_post: j["id_post"],
        title: j["title"],
        basin: j["basin"],
        description: j["description"],
        post_date: j["post_date"],
        user: j["id_user"]);
  }

  Map toMap() {
    return {
      "id_post": id_post,
      "id_user": user,
      "title": title,
      "basin": basin,
      "description": description
    };
  }
}

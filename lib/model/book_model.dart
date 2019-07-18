class BookModel {
  int id;
  String title;
  String coverImageUrl;
  String link;
  String tags;
  String description;
  String subscriptUrl;

  static List<BookModel> fromJsonList(dynamic data) {
    return List<BookModel>.from(data.map((it) => BookModel.fromJsonMap(it)));
  }

  BookModel.fromJsonMap(Map<String, dynamic> map)
      : id = map["id"],
        title = map["title"],
        coverImageUrl = map["coverImageUrl"],
        link = map["link"],
        tags = map["tags"],
        description = map["description"],
        subscriptUrl = map["subscriptUrl"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['coverImageUrl'] = coverImageUrl;
    data['link'] = link;
    data['tags'] = tags;
    data['description'] = description;
    data['subscriptUrl'] = subscriptUrl;
    return data;
  }
}

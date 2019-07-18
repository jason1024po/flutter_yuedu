class HeaderModel {
  String imageUrl;
  bool hasMore;
  String title;
  String hasMoreLink;

  HeaderModel.fromJsonMap(Map<String, dynamic> map)
      : imageUrl = map["imageUrl"],
        hasMore = map["hasMore"],
        title = map["title"],
        hasMoreLink = map["hasMoreLink"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageUrl'] = imageUrl;
    data['hasMore'] = hasMore;
    data['title'] = title;
    data['hasMoreLink'] = hasMoreLink;
    return data;
  }
}

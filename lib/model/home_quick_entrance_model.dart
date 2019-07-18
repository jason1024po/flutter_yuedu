class HomeQuickEntranceModel {
  String title;
  String link;
  String imageUrl;

  static List<HomeQuickEntranceModel> fromJsonList(dynamic data) {
    return List<HomeQuickEntranceModel>.from(
        data.map((it) => HomeQuickEntranceModel.fromJsonMap(it)));
  }

  HomeQuickEntranceModel.fromJsonMap(Map<String, dynamic> map)
      : title = map["title"],
        link = map["link"],
        imageUrl = map["imageUrl"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = title;
    data['link'] = link;
    data['imageUrl'] = imageUrl;
    return data;
  }
}

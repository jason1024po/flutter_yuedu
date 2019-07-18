class SeriesModel {
  int id;
  String link;
  String imageUrl;

  static List<SeriesModel> fromJsonList(dynamic data) {
    return List<SeriesModel>.from(
        data.map((it) => SeriesModel.fromJsonMap(it)));
  }

  SeriesModel.fromJsonMap(Map<String, dynamic> map)
      : id = map["id"],
        link = map["link"],
        imageUrl = map["imageUrl"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['link'] = link;
    data['imageUrl'] = imageUrl;
    return data;
  }
}

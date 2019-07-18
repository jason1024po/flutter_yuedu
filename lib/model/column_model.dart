class ColumnModel {
  int id;
  String title;
  List<String> subItemNames;
  String link;
  String imageUrl;

  static List<ColumnModel> fromJsonList(dynamic data) {
    return List<ColumnModel>.from(
        data.map((it) => ColumnModel.fromJsonMap(it)));
  }

  ColumnModel.fromJsonMap(Map<String, dynamic> map)
      : id = map["id"],
        title = map["title"],
        subItemNames = List<String>.from(map["subItemNames"]),
        link = map["link"],
        imageUrl = map["imageUrl"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['subItemNames'] = subItemNames;
    data['link'] = link;
    data['imageUrl'] = imageUrl;
    return data;
  }
}

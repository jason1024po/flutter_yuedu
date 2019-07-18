class BannerModel {
  String link;
  String imageUrl;

  static List<BannerModel> fromJsonList(dynamic data) {
    return List<BannerModel>.from(
        data.map((it) => BannerModel.fromJsonMap(it)));
  }

  BannerModel.fromJsonMap(Map<String, dynamic> map)
      : link = map["link"],
        imageUrl = map["imageUrl"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['link'] = link;
    data['imageUrl'] = imageUrl;
    return data;
  }
}

class Modules {
  final int id;
  final String name;
  final String type;
  final dynamic payload;

  Modules.fromJsonMap(Map<String, dynamic> map)
      : id = map["id"],
        name = map["name"],
        type = map["type"],
        payload = map["payload"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    data['payload'] = payload;
    return data;
  }
}

import 'package:flutter_yuedu/model/modules.dart';

class HomePageModel {
  final int createTime;
  final int updateTime;
  final int status;
  final int id;
  final String key;
  final String name;
  final String description;
  final Object type;
  final String version;
  final List<Modules> modules;

  HomePageModel.fromJsonMap(Map<String, dynamic> map)
      : createTime = map["createTime"],
        updateTime = map["updateTime"],
        status = map["status"],
        id = map["id"],
        key = map["key"],
        name = map["name"],
        description = map["description"],
        type = map["type"],
        version = map["version"],
        modules = List<Modules>.from(
            map["modules"].map((it) => Modules.fromJsonMap(it)));

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createTime'] = createTime;
    data['updateTime'] = updateTime;
    data['status'] = status;
    data['id'] = id;
    data['key'] = key;
    data['name'] = name;
    data['description'] = description;
    data['type'] = type;
    data['version'] = version;
    data['modules'] =
        modules != null ? this.modules.map((v) => v.toJson()).toList() : null;
    return data;
  }
}

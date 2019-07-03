import 'package:flutter/material.dart';
import 'package:flutter_yuedu/api/http.dart';
import 'package:flutter_yuedu/sqlite/sqlite.dart';
import 'package:oktoast/oktoast.dart';

const URL = "app/index";

class HomeProvider with ChangeNotifier {
  // 数据
  List<Map<String, Object>> data = [];

  HomeProvider() {
    fetchData();
  }

  Future<void> fetchData() async {
    // 缓存
    KeyValueStore.get(URL).then((value) {
      print("缓存来了");
      data = List.from(value.content);
      notifyListeners();
    }).catchError((error) {
      print(error);
    });

    // 网络
    Http.get(URL + "?appPageKey=STAGE_B&pageKey=STAGE_B").then((result) {
      final modules = result.data["page"]["modules"];
      data = List.from(modules);
      notifyListeners();
      KeyValueStore.add(URL, modules);
    }).catchError((error) {
      showToast("网络错误");
      print(error);
    });
  }
}

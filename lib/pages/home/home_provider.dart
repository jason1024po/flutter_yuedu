import 'package:flutter/material.dart';
import 'package:flutter_yuedu/api/http.dart';

const URL =
    "https://api-yread-online.du.youdao.com/v2/app/index?appPageKey=STAGE_B&pageKey=STAGE_B";

class HomeProvider with ChangeNotifier {
  // 数据
  List<Map<String, Object>> data = [];

  HomeProvider() {
    fetchData();
  }

  Future<void> fetchData() async {
    final res = await Http.get("app/index?appPageKey=STAGE_B&pageKey=STAGE_B");

    final _modules = res.data["page"]["modules"];
    data = List.from(_modules);

    notifyListeners();
  }
}

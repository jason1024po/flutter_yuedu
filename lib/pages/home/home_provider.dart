import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const URL =
    "https://api-yread-online.du.youdao.com/v2/app/index?appPageKey=STAGE_B&pageKey=STAGE_B";

class HomeProvider with ChangeNotifier {
  // banner
  List<String> bannerList = [];
  List<Map<String, String>> quickEntrances = [];

  List<Map<String, Object>> data = [];

  HomeProvider() {
    fetchData();
  }

  Future<void> fetchData() async {
    var response = await http.get(URL);
    var result = json.decode(response.body);

    final _modules = result["body"]["page"]["modules"];
    data = List.from(_modules);

    // banner
    bannerList = [];
    final _banners = _modules[0]["payload"]["banners"];
    _banners.forEach(
        (item) => bannerList.add((item as Map<String, Object>)["imageUrl"]));
    // 快速导航
    quickEntrances = [];
    _modules[1]["payload"]["quickEntrances"]
        .forEach((item) => quickEntrances.add(Map<String, String>.from(item)));

    notifyListeners();
  }
}

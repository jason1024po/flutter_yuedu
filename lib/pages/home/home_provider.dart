import 'package:flutter/material.dart';
import 'package:flutter_yuedu/api/http.dart';
import 'package:flutter_yuedu/model/home_page_model.dart';
import 'package:flutter_yuedu/sqlite/sqlite.dart';
import 'package:oktoast/oktoast.dart';

const URL = "app/index";

class HomeProvider with ChangeNotifier {
  // 数据
  HomePageModel data;
  bool isLoading = true;

  HomeProvider() {
    // 缓存
    KeyValueStore.get(URL).then((value) {
      print("缓存数据");
      data = HomePageModel.fromJsonMap(value.content);
      notifyListeners();
    }).catchError((error) {
      print(error);
    });

    fetchData();
  }

  Future<void> fetchData() async {
    isLoading = true;

    // 网络
    Http.get(URL + "?appPageKey=STAGE_B&pageKey=STAGE_B").then((result) {
      data = HomePageModel.fromJsonMap(result.body["page"]);
      notifyListeners();
      KeyValueStore.add(URL, result.body["page"]);
      stopLoading();
    }).catchError((error) {
      showToast("网络错误");
      print(error);
      stopLoading();
    });
  }

  stopLoading() async {
    Future.delayed(Duration(milliseconds: 300), () {
      isLoading = false;
      notifyListeners();
    });
  }
}

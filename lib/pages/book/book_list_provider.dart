import 'package:flutter/material.dart';
import 'package:flutter_yuedu/api/http.dart';
import 'package:oktoast/oktoast.dart';

const URL = "app/index/more";

class BookListProvider with ChangeNotifier {
  // 数据
  List<Map<String, Object>> data = [];
  bool isLoading = true;

  int pageSize = 20;

  bool isLoadMore = false;

  int get pageNow {
    return data.length ~/ pageSize;
  }

  resetData() {
    print("清数据");
    data.clear();
  }

  Future<void> fetchData(String id, {bool loadMore = false}) async {
    if (isLoadMore) {
      print("有加载更多");
      return;
    } else {
      if (!loadMore) resetData();
    }

    isLoadMore = loadMore;
    isLoading = true;
    notifyListeners();
    print("获取列表数据");

    int offset = pageSize * pageNow;

    // 网络
    Http.post(URL +
            "?appPageModuleDefinitionId=$id&appPageKey=STAGE_B&offset=$offset&limit=$pageSize")
        .then((result) {
      final list = result.data["appPageModule"]["payload"]["books"];
      if (pageNow == 0) data.clear();

      data.addAll(List.from(list));

      notifyListeners();
      stopLoading();
    }).catchError((error) {
      showToast("网络错误");
      notifyListeners();
      print(error);
      stopLoading();
    });
  }

  stopLoading() async {
    Future.delayed(Duration(milliseconds: 300), () {
      isLoading = false;
      isLoadMore = false;
      notifyListeners();
    });
  }
}

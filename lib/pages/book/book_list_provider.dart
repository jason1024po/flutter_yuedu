import 'package:flutter/material.dart';
import 'package:flutter_yuedu/api/http.dart';
import 'package:oktoast/oktoast.dart';

const URL = "app/index/more";

class BookListProvider with ChangeNotifier {
  // 数据
  List<Map<String, Object>> data = [];

  bool isLoading = true;

  int pageSize = 20;

  // 加载更多中
  bool loadingMore = false;

  bool hasMore = true;

  // 下一页
  int get pageNow {
    return data.length ~/ pageSize;
  }

  Future<void> fetchData(String id, {bool loadMore = false}) async {
    if (loadingMore) {
      print("更多加载进行中...");
      return;
    }
    if (loadMore && !hasMore) {
      print("没有更多数据了...");
      return;
    }
    if (!loadMore) {
      resetData();
//      notifyListeners();
    }

    loadingMore = loadMore;
    isLoading = true;
    print("获取列表数据....");

    int offset = pageSize * pageNow;

    // 网络
    final param =
        "?appPageModuleDefinitionId=$id&appPageKey=STAGE_B&offset=$offset&limit=$pageSize";
    Http.post(URL + param).then((result) {
      final list = result.data["appPageModule"]["payload"]["books"];
//      if (!loadMore) resetData();

      hasMore = list.length == pageSize;

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

  resetData() {
    print("清状态");
    hasMore = true;
    data.clear();
  }

  stopLoading() async {
    Future.delayed(Duration(milliseconds: 300), () {
      isLoading = false;
      loadingMore = false;
      notifyListeners();
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_yuedu/api/http.dart';
import 'package:oktoast/oktoast.dart';

const URL = "app/index/more";

class BookListProvider with ChangeNotifier {
  // 数据
  List<Map<String, Object>> data = [];

  Future<void> fetchData(String id) async {
    data.clear();
    print("获取列表数据");
    // 网络
    Http.post(URL +
            "?appPageModuleDefinitionId=$id&appPageKey=STAGE_B&offset=0&limit=20")
        .then((result) {
      final list = result.data["appPageModule"]["payload"]["books"];
      data = List.from(list);
      notifyListeners();
    }).catchError((error) {
      showToast("网络错误");
      print(error);
    });
  }
}

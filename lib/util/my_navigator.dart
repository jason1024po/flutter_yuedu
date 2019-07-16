import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yuedu/pages/book/book_details_page.dart';
import 'package:flutter_yuedu/pages/book/book_list.dart';
import 'package:flutter_yuedu/pages/book/book_list_highly_recommended.dart';
import 'package:flutter_yuedu/pages/member/join_member.dart';
import 'package:flutter_yuedu/pages/webview/webview.dart';

class MyNavigator {
  // 设置一次 context 方便后面
  static BuildContext _context;

  static set context(BuildContext value) {
    _context = value;
  }

  static pushWithLink(String link) {
    if (_context == null) {
      print("context 为空");
      return;
    }

    // query 参数
    final params = Uri.dataFromString(link).queryParameters;

    if (link.startsWith("http")) {
      push(_context, WebViewPage(url: link)); // 网页
    } else if (link.startsWith("ydathena://member")) {
      push(_context, JoinMember()); // 会员中心
    } else if (link.startsWith("ydathena://book")) {
      push(_context, BookDetailsPage(params["libraryId"])); // 详情
    } else if (link.startsWith("ydathena://morebook")) {
      push(_context, BookList(params["moduleId"])); // 图书列表
    } else if (link.startsWith("ydathena://morehighlyrecommendedbook")) {
      push(_context, BookListHighlyRecommended(params["moduleId"])); // 图书列表
    } else {
      print("未实现的路由：" + link);
    }
  }

  // push 新页面
  static push(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  // iOS 从底部向上出来的页面
  static present(BuildContext context, Widget page) {
    Navigator.of(context).push(
        MaterialPageRoute(fullscreenDialog: true, builder: (context) => page));
  }
}

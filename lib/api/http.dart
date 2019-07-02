import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/config.dart';
import 'api.dart';

class Http {
  static Future<Response> get(String url,
      {String query, String version = kVersion}) async {
    var response = await http.get(Api(url, version: version).toString());
    var result = json.decode(response.body);

    return Response(result["code"], result["message"], result["body"]);
  }

  static Future<Response> post(String url, {body}) async {
    var response = await http.post(url.toString(), body: body);
    var result = json.decode(response.body);

    return Response(result["code"], result["message"], result["body"]);
  }
}

/// 结果
class Response {
  int code;
  String message;
  dynamic data;

  Response(this.code, this.message, this.data);
}

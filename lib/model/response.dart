class Response {
  int code;
  Object message;
  dynamic body;

  Response.fromJsonMap(Map<String, dynamic> map)
      : code = map["code"],
        message = map["message"],
        body = map["body"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = code;
    data['message'] = message;
    data['body'] = body;
    return data;
  }
}

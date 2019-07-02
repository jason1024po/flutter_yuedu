import '../config/config.dart';

/// api 处理
class Api {
  final String host;
  final String path;
  final String version;

  Api(this.path, {this.version = kVersion, this.host = kBaseHost});

  @override
  String toString() {
    final isStartHttp = path.startsWith("http");
    var url = isStartHttp ? path : host + "/" + version + "/" + path;
    if (version.length == 0) {
      url = isStartHttp ? path : host + "/" + path;
    }
    print("🌐 " + url);
    return url;
  }
}

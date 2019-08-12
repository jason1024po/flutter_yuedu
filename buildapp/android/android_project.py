import re
import os
import time


# Android项目相关信息
class AndroidProject:
    # 应用 id
    application_id = ""
    # 显示版本号
    version_name = ""
    # 内部版本号
    version_code = ""
    # 配置文件
    _app_build_gradle_path = "app/build.gradle"
    # flutter 版本号配置文件
    _local_properties_path = "local.properties"
    # 格式化后的名称
    _format_apk_name = ""

    def __init__(self, path):
        self.path = path
        self.load()

    # 加载数据
    def load(self):
        print(os.getcwd())
        # 获取 applicationId
        path = os.path.join(self.path, self._app_build_gradle_path)
        con = open(path).read()
        app_id = re.search(r"applicationId\s\"(.*.\w+)\"", con).group(1)
        self.application_id = app_id
        # 获取版本信息
        read_path = os.path.join(self.path, self._local_properties_path)
        with open(read_path, "r") as f:
            values = {}
            for line in f.readlines():
                arr = line.strip("\n").split("=")
                values[arr[0]] = arr[1]
        self.version_code = values["flutter.versionCode"]
        self.version_name = values["flutter.versionName"]

    # 格式化apk输出名称
    def get_format_apk_name(self):
        if not len(self._format_apk_name):
            # 命名规则 = 包名最后一项 + 版本号 + 时间 + apk
            prefix = (
                    self.application_id.split(".")[-1]
                    + "_"
                    + self.version_name
                    + "_"
                    + self.version_code
                    + "_"
            )
            self._format_apk_name = (
                    prefix + time.strftime("%Y%m%d_%H.%M", time.localtime()) + ".apk"
            )
        return self._format_apk_name

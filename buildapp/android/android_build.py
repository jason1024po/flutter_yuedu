import subprocess
import os

from pathlib import Path
from pgyer.pgyer import upload_to_pgy

from android.android_project import AndroidProject


# 打包 Android 相关
class AndroidBuild:
    # 默认打包目录
    build_dir = "./build/app/outputs/apk/release/"
    # 默认打包名称
    default_apk_name = "app-release.apk"
    # 默认打包路径
    default_apk_path = os.path.join(build_dir, default_apk_name)

    # 加载 Android 项目信息
    android_project = None

    # 新的 apk 包名
    new_apk_name = ""

    # 新的 apk 路径
    new_apk_path = ""

    def __init__(self, path="android"):
        self.android_project = AndroidProject(path)
        self.new_apk_name = self.android_project.get_format_apk_name()
        self.new_apk_path = self.build_dir + self.new_apk_name

    # 重命名
    def _rename_apk(self):
        os.rename(self.default_apk_path, self.new_apk_path)

    # 清除旧包
    def _remove_all(self):
        print(self.build_dir)
        for name in os.listdir(self.build_dir):
            os.remove(os.path.join(self.build_dir, name))

    def build_test(self):
        # 删除旧包
        print("正在清除旧包...")
        self._remove_all()

        # 打包apk
        print("开始打包apk...")
        subprocess.call("flutter build apk", shell=True)

        print(os.getcwd())
        print(self.default_apk_path)

        # 判断文件是否成功
        if not Path(self.default_apk_path).is_file():
            print("文件不存在，打包失败")
        else:
            self._rename_apk()
            upload_to_pgy(self.new_apk_path)

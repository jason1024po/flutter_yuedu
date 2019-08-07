import subprocess
import os

from pathlib import Path
from pgyer.pgyer import upload_to_pgy

from android.android_project import AndroidProject

# 路径修复
if not os.path.exists(os.path.join(os.getcwd(), "android/app")):
    print("没有发现android工程目录，尝试修复路径")
    os.chdir("..")

# 默认打包目录
build_dir = "./build/app/outputs/apk/release/"
# 默认打包名称
default_apk_name = "app-release.apk"
# 默认打包路径
default_apk_path = os.path.join(build_dir, default_apk_name)

# 加载 Android 项目信息
android_project = AndroidProject("android")
android_project.load()

# 新的 apk 包名
new_apk_name = android_project.get_format_apk_name()

# 新的 apk 路径
new_apk_path = build_dir + new_apk_name


def rename_apk():
    os.rename(default_apk_path, new_apk_path)


def remove_all(path):
    print(path)
    for name in os.listdir(path):
        os.remove(os.path.join(path, name))


# 删除旧包
print("正在清除旧包...")
remove_all(build_dir)

# 打包apk
print("开始打包apk...")
subprocess.call("flutter build apk", shell=True)

print(os.getcwd())
print(default_apk_path)

# 判断文件是否成功
if not Path(default_apk_path).is_file():
    print("文件不存在，打包失败")
else:
    rename_apk()
    upload_to_pgy(new_apk_path)

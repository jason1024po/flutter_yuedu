import subprocess
import os
import time

from pathlib import Path
from pgyer import uploadIpaToPgyer


# 默认打包目录
buildDir = "./build/app/outputs/apk/release/"
# 默认打包名称
defaultApkName = "app-release.apk"
# 默认打包路径
defaultApkPath = buildDir + defaultApkName
# 新的 apk 包名
newApkName = time.strftime("%Y%m%d_%H.%M", time.localtime()) + ".apk"
# 新的 apk 路径
newApkpath = buildDir + newApkName


def renameApk():
    os.rename(defaultApkPath, newApkpath)


def removeAll(path):
    print(path)
    for name in os.listdir(path):
        os.remove(os.path.join(path, name))


# 删除旧包
print("正在清除旧包...")
removeAll(buildDir)


# 打包apk
print("开始打包apk...")
subprocess.call("flutter build apk", shell=True)

# 判断文件是否成功
if not Path(defaultApkPath).is_file():
    print("文件不存在，打包失败")
else:
    renameApk()
    uploadIpaToPgyer(newApkpath)

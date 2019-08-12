import os

from android.android_build import AndroidBuild
from ios.ios_build import IOSBuild

# 路径修复
if not os.path.exists(os.path.join(os.getcwd(), "android/app")):
    print("没有发现工程目录，尝试修复路径")
    os.chdir("..")

# 开始打包 android
AndroidBuild("android").build_test()

# IOSBuild().build_test()



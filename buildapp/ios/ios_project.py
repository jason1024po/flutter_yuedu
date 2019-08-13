import os
import re


class IOSProject:
    project_path: str
    application_id: str
    application_name: str
    version_name: str
    version_code: str
    info_plist_path: str = ""
    xcodeproj_name: str
    xcworkspace_name: str
    export_ipa_name: str
    # 是否加载错误
    is_load_error = False

    def __init__(self, path="ios"):
        self.project_path = os.path.abspath(path)
        # 加载信息
        self.load_info()

    #  加载工程及应用信息
    def load_info(self):
        # 1. 查找 plist
        self.find_plist_path(self.project_path, "Info.plist")
        # 1.1 判断是否加载成功
        self.is_load_error = not len(self.info_plist_path)
        if self.is_load_error:
            return
        # 1.2 读取 plist 内容
        info_con = open(self.info_plist_path).read()
        # 2. 读取应用名称
        pattern = r"<key>CFBundleDisplayName</key>.*\n.*<string>(.+)</string>"
        self.application_name = re.search(pattern, info_con).group(1)
        # 3. 读取版本号
        pattern = r"<key>CFBundleShortVersionString</key>[\s\n]*<string>([\.|\S]+)</string>"
        self.version_name = re.search(pattern, info_con).group(1)
        pattern = r"<key>CFBundleVersion</key>[\s\n]*<string>([\.|\S]+)</string>"
        self.version_code = re.search(pattern, info_con).group(1)
        # 4. 先读取工程信息
        self.load_xcode_project_info()
        # 5. 再读取应用 id
        self.load_application_id()
        # 6. 判断是否加载成功
        self.is_load_error = not len(self.application_id) or not len(self.application_name)

    # 加载 xcode 工程信息
    def load_xcode_project_info(self):
        items = os.listdir(self.project_path)
        for item in items:
            if item.endswith(".xcodeproj"):
                self.xcodeproj_name = item
            elif item.endswith(".xcworkspace"):
                self.xcworkspace_name = item

    # iOS 找到包名配置文件路径
    def get_project_pbxproj_path(self):
        return os.path.join(self.project_path, self.xcodeproj_name, "project.pbxproj")

    # 加载应用 包名配置
    def load_application_id(self):
        pattern = r"PRODUCT_BUNDLE_IDENTIFIER\s=\s(.*\.\w+);"
        con = open(self.get_project_pbxproj_path()).read()
        self.application_id = re.search(pattern, con).group(1)

    # 查找 plist - 递归5层目录查找
    def find_plist_path(self, root, target, depth=5):
        # 遍历到指定深度
        if depth < 0:
            return
        # 读取目录
        items = os.listdir(root)
        # 遍历目录
        for item in items:
            # 忽略隐藏目录
            if item.startswith("."):
                continue
            # 是目录接着往下找
            if os.path.isdir(os.path.join(root, item)):
                self.find_plist_path(os.path.join(root, item), target, depth=depth - 1)
            elif item == target:
                # 包涵 CFBundleDisplayName 才是真的
                if "CFBundleDisplayName" in open(os.path.join(root, item)).read():
                    self.info_plist_path = os.path.join(root, item)


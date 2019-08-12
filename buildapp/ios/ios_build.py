import subprocess


class IOSBuild:

    def __init__(self):
        pass

    def build_test(self):
        print("开始flutter build ios...")
        subprocess.call("flutter build ios", shell=True)

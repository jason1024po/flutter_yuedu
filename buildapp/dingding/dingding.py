import requests
import json

DD_ACCESS_TOKEN = "eafe92ea8d5b351eed8bca9f728c239413be743895ee02dc6c009ea1ed8f6b2c"

url = "https://oapi.dingtalk.com/robot/send?access_token=" + DD_ACCESS_TOKEN

# header 信息
headers = {"Content-Type": "application/json"}


def get_build_type(data):
    if data == "1":
        return "iOS"
    elif data == "2":
        return "Android"
    else:
        return "未知"


def send_with_pgy_response(data):
    print(json.dumps(data))
    # 内容
    text = """新版本提醒    
    名称：**{buildName}({buildType})**    
    版本：**{buildVersion}({buildVersionNo})**(Build {buildBuildVersion})    
    大小：{buildFileSize} MB    
    时间：{buildUpdated}   
    下载：[点击下载本次版本](https://www.pgyer.com/{buildKey})  
    内容：{buildContent}   
    """.format(
        buildName=data["buildName"],
        buildType=get_build_type(data["buildType"]),
        buildVersion=data["buildVersion"],
        buildVersionNo=data["buildVersionNo"],
        buildBuildVersion=data["buildBuildVersion"],
        buildFileSize=int(int(data["buildFileSize"]) / 1024 // 1024),
        buildUpdated=data["buildUpdated"],
        buildKey=data["buildKey"],
        buildContent="测试包"
    )

    body = {
        "msgtype": "actionCard",
        "actionCard": {
            "hideAvatar": "0",
            "btnOrientation": "0",
            "title": "{}".format(data["buildName"]),
            "singleTitle": "点击消息下载最新版本",
            "singleURL": "https://www.pgyer.com/{}".format(data["buildShortcutUrl"]),
            "text": text,
        },
    }

    response = requests.post(url=url, headers=headers, data=json.dumps(body))
    result = response.json()
    print(result)

import 'package:flutter/material.dart';

class StageDialog extends Dialog {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 320,
      ),
      child: Container(
          width: 300,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: Theme(
              data: ThemeData(
                  buttonTheme: ButtonThemeData(
                      buttonColor: Colors.red, disabledColor: Colors.red)),
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 12, top: 12),
                    child: Text(
                      "您的孩子处于",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                          decoration: TextDecoration.none),
                    ),
                  ),
                  FlatButton(
                    color: Colors.yellowAccent,
                    child: Text("0~3岁"),
                    onPressed: () => _buttonClick(1),
                  ),
                  FlatButton(
                    child: Text("4~6岁"),
                    onPressed: () => _buttonClick(1),
                  ),
                  FlatButton(
                    child: Text("7~8岁"),
                    onPressed: () => _buttonClick(1),
                  ),
                  FlatButton(
                    child: Text("9~10岁"),
                    onPressed: () => _buttonClick(1),
                  ),
                  FlatButton(
                    child: Text("11岁+"),
                    onPressed: () => _buttonClick(1),
                  ),
                ],
              ))),
    ));
  }

  _buttonClick(int index) {
    print(index);
  }
}

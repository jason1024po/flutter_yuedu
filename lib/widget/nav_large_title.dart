import 'package:flutter/material.dart';

class NavLargeTitle extends StatelessWidget {
  final String _title;

  NavLargeTitle(this._title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Text(_title,
          style: TextStyle(fontSize: 24, color: Color(0xff444444))),
    );
  }
}

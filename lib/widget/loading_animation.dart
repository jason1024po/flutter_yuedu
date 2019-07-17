import 'package:flutter/material.dart';

import 'animation_images.dart';

class LoadingAnimation extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final bool loading;
  // 动画图片上
  static List<Image> _loadingImages = List<Image>.generate(20, (index) {
    index++;
    if (index < 10) {
      return Image.asset("images/loading/book/book_swiping0$index.png");
    }
    return Image.asset("images/loading/book/book_swiping$index.png");
  });

  LoadingAnimation({this.child, this.padding, this.loading = true});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        child,
        Positioned(
            child: Padding(
          padding: padding ?? EdgeInsets.only(bottom: 60),
          child: loading ? AnimationImages(_loadingImages) : Container(),
        ))
      ],
    );
  }
}

import 'package:flutter/material.dart';

import 'animation_images.dart';

final loadingImages = List<Image>.generate(20, (index) {
  index++;
  if (index < 10) {
    return Image.asset("images/loading/book/book_swiping0$index.png");
  }
  return Image.asset("images/loading/book/book_swiping$index.png");
});

class LoadingAnimation extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final bool loading;

  LoadingAnimation({this.child, this.padding, this.loading = true});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        child,
        Positioned(
            child: Padding(
          padding: padding ?? EdgeInsets.only(bottom: 60),
          child: loading ? AnimationImages(loadingImages) : Container(),
        ))
      ],
    );
  }
}

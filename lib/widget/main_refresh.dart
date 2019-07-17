import 'package:flutter/material.dart';

import 'animation_images.dart';

class MainRefresh extends StatelessWidget {
  // 动画图片上
  static List<Image> _loadingImages = List<Image>.generate(9, (index) {
    index++;
    print(index);
    return Image.asset("images/loading/main/main_loading_frame$index.png");
  });

  @override
  Widget build(BuildContext context) {
    return AnimationImages(_loadingImages);
  }
}

import 'package:flutter/material.dart';

// 播放图片动画
class AnimationImages extends StatefulWidget {
  final List<Image> images;

  AnimationImages(this.images);

  @override
  _AnimationImagesState createState() => _AnimationImagesState();
}

class _AnimationImagesState extends State<AnimationImages> {
  // 显示的 image
  Image activeImage;

  bool _disposed;

  @override
  void initState() {
    super.initState();
    _disposed = false;

    activeImage = widget.images.last;

    _updateImage(widget.images.length, Duration(milliseconds: 40));
  }

  _updateImage(int count, Duration millisecond) {
    Future.delayed(millisecond, () {
      if (_disposed) return;
      setState(() {
        activeImage = widget.images[widget.images.length - count--];
      });
      if (count < 1) {
        count = widget.images.length;
      }
      _updateImage(count, millisecond);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _disposed = true;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: activeImage,
    );
  }
}

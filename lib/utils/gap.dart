import 'package:flutter/material.dart';

class Gap extends StatelessWidget {
  const Gap({
    super.key,
    this.width,
    this.height
  });

  final double? width;
  final double? height;

  const Gap.h(double width, {Key? key}): this(key: key, width: width);
  const Gap.v(double height, {Key? key}): this(key: key, height: height);
  const Gap.s(double square, {Key? key}): this(key: key, width: square, height: square);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
    );
  }
}

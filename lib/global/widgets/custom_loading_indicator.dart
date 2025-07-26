import 'package:flutter/material.dart';

class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({
    super.key,
    this.backColor = Colors.black,
    this.indicatorColor = Colors.white,
    this.height = 55, this.borderRadius = 8,
  });
  final Color backColor, indicatorColor;
  final double? height;
  final double borderRadius;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: height,
      decoration: BoxDecoration(
        color: backColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Center(
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(color: indicatorColor),
        ),
      ),
    );
  }
}

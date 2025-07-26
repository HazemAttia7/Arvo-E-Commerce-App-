import 'package:flutter/material.dart';

class CustomImageWithIndicatorWhileLoading extends StatelessWidget {
  const CustomImageWithIndicatorWhileLoading({
    super.key,
    required this.image,
    this.height = 170,
    this.width = 170,
    this.boxFit = BoxFit.cover,
  });
  final BoxFit? boxFit;
  final String? image;
  final double? height, width;
  @override
  Widget build(BuildContext context) {
    return Image.network(
      image ?? "assets/images/image placeholder.png",
      loadingBuilder: (
        BuildContext context,
        Widget actualImage,
        ImageChunkEvent? loadingProgress,
      ) {
        if (loadingProgress == null) {
          return actualImage;
        } else {
          return const Center(
            child: CircularProgressIndicator(color: Colors.black),
          );
        }
      },
      errorBuilder: (
        BuildContext context,
        Object error,
        StackTrace? stackTrace,
      ) {
        return Image.asset(
          "assets/images/image placeholder.png",
          height: height,
          width: width,
          fit: boxFit,
        );
      },
      height: height,
      width: width,
      fit: boxFit,
    );
  }
}

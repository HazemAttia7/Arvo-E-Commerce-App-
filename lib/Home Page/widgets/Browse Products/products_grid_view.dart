import 'package:flutter/material.dart';

class ProductsGridView extends StatelessWidget {
  const ProductsGridView({
    super.key,
    required this.itemBuilder,
    required this.itemCount,
    this.scrollPhysics = const NeverScrollableScrollPhysics(),
    this.crossAxisSpacing = 15,
    this.mainAxisSpacing = 25,
  });
  final Widget? Function(BuildContext, int) itemBuilder;
  final int itemCount;
  final ScrollPhysics? scrollPhysics;
  final double crossAxisSpacing, mainAxisSpacing;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      clipBehavior: Clip.none,
      physics: scrollPhysics,
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 170 / 230,
        crossAxisSpacing: crossAxisSpacing,
        mainAxisSpacing: mainAxisSpacing,
      ),
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );
  }
}

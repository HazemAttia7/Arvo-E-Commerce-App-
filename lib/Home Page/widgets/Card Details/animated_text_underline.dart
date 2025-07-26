import 'package:flutter/material.dart';

class AnimatedTextUnderline extends StatefulWidget {
  const AnimatedTextUnderline({super.key, this.index = 0});
  final int index;
  @override
  State<AnimatedTextUnderline> createState() => _AnimatedTextUnderlineState();
}

class _AnimatedTextUnderlineState extends State<AnimatedTextUnderline> {
  List<double> leftValues = [1, 98, 207.5];
  List<double> widthValues = [81, 93, 119];
  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      top: 25,
      left: leftValues[widget.index], // 1 , 98 , 207.5
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 400),
      child: Container(
        color: Colors.black,
        height: 3,
        width: widthValues[widget.index], //81 , 93 , 119
      ),
    );
  }
}

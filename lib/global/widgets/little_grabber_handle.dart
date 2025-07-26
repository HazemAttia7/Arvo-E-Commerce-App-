
import 'package:flutter/material.dart';

class LittleGrabberHandle extends StatelessWidget {
  const LittleGrabberHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2,
      width: 125,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black,
      ),
    );
  }
}

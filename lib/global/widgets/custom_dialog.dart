import 'package:flutter/material.dart';

// ignore: camel_case_types
enum enState { failure, success }

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.state,
  });
  final String title, subtitle, image;
  final enState state;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 14,
            top: 20,
            child: Container(
              width: 285,
              height: 205,
              decoration: BoxDecoration(
                color:
                    state == enState.success
                        ? const Color(0xff66DB96)
                        : const Color(0xFFDB6666),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          Container(
            width: 340,
            height: 205,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 15,
                  spreadRadius: 0,
                  offset: const Offset(0, 2),
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: -50,
                  left: 75,
                  child: Image.asset(image, width: 170),
                ),
                Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 100),
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

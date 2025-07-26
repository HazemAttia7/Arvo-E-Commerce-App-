import 'package:flutter/material.dart';

class QuantityWidget extends StatefulWidget {
  const QuantityWidget({
    super.key,
    required this.subOnTap,
    required this.addOnTap,
    required this.quantity, this.height = 35, this.width = 120,
  });
  final VoidCallback subOnTap;
  final VoidCallback addOnTap;
  final int quantity;
  final double? height , width;
  @override
  State<QuantityWidget> createState() => _QuantityWidgetState();
}

class _QuantityWidgetState extends State<QuantityWidget> {
  int getQuantity() {
    return widget.quantity;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: widget.subOnTap,
              child: Container(
                color: Colors.black,
                child: const Center(
                  child: Text(
                    "-",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      height: 1,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(border: Border.all()),
              child: Center(
                child: Text(
                  widget.quantity.toString(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    height: 1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: widget.addOnTap,
              child: Container(
                color: Colors.black,
                child: const Center(
                  child: Text(
                    "+",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      height: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

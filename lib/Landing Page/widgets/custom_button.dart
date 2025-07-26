import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
    this.backColor,
    this.textColor,
    this.fontWeight = FontWeight.bold,
    this.borderRadius = 8,
  });
  final String text;
  final void Function()? onTap;
  final Color? backColor;
  final Color? textColor;
  final FontWeight? fontWeight;
  final double borderRadius;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 55,
        decoration: BoxDecoration(
          color: widget.backColor ?? Colors.black,
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        child:
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : Center(
                  child: Text(
                    widget.text,
                    style: TextStyle(
                      color: widget.textColor ?? Colors.white,
                      fontWeight: widget.fontWeight,
                      fontSize: 18,
                    ),
                  ),
                ),
      ),
    );
  }
}

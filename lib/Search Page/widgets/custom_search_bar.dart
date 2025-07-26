import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key, required this.onChanged});
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(fontSize: 20),
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: "Search",
        hintStyle: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w500,
          color: Colors.grey,
        ),
        contentPadding: const EdgeInsets.all(10),
        prefixIcon: const Icon(Icons.search, size: 26),
        border: buildBorder(),
        enabledBorder: buildBorder(),
        focusedBorder: buildBorder(),
      ),
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: const BorderSide(color: Colors.black, width: 2),
    );
  }
}

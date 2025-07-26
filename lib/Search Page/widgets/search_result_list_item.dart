import 'package:e_commerce_app/Home%20Page/views/card_details_view.dart';
import 'package:e_commerce_app/global/models/product_model.dart';
import 'package:flutter/material.dart';

class SearchResultListItem extends StatelessWidget {
  const SearchResultListItem({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.search, color: Colors.grey),
          const SizedBox(width: 10),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CardDetailsView(product: product),
                  ),
                );
              },
              child: Text(
                product.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  height: 1,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

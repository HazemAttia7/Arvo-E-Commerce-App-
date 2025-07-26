import 'package:e_commerce_app/Search%20Page/widgets/search_result_list_item.dart';
import 'package:e_commerce_app/global/models/product_model.dart';
import 'package:flutter/material.dart';

class SearchResultListView extends StatelessWidget {
  const SearchResultListView({super.key, required this.productsList});

  final List<ProductModel> productsList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: productsList.length,
      itemBuilder: (BuildContext context, int index) {
        return SearchResultListItem(product: productsList[index]);
      },
    );
  }
}

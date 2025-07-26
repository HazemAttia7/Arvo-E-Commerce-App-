import 'package:e_commerce_app/Search%20Page/widgets/custom_search_bar.dart';
import 'package:e_commerce_app/Search%20Page/widgets/search_result_list_view.dart';
import 'package:e_commerce_app/global/models/product_model.dart';
import 'package:e_commerce_app/global/services/products_service.dart';
import 'package:flutter/material.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  String productToSearch = "";
  late Future<List<ProductModel>?> _initAllProducts;
  @override
  void initState() {
    super.initState();
    _initAllProducts = ProductsService().getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 25),
          const Text(
            "Find Product",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
          ),
          const SizedBox(height: 10),
          CustomSearchBar(
            onChanged: (data) {
              setState(() {
                productToSearch = data;
              });
            },
          ),
          if (productToSearch.isNotEmpty)
            Expanded(
              child: FutureBuilder<List<ProductModel>?>(
                future: _initAllProducts,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<ProductModel> productsList =
                        snapshot.data!
                            .where(
                              (product) => product.title.toLowerCase().contains(
                                productToSearch.toLowerCase(),
                              ),
                            )
                            .toList();
                    return SearchResultListView(productsList: productsList);
                  }
                  return const SizedBox(
                    child: Center(child: Text("No Products Found")),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

import 'package:e_commerce_app/Home%20Page/views/card_details_view.dart';
import 'package:e_commerce_app/Home%20Page/widgets/Browse%20Products/custom_product_card.dart';
import 'package:e_commerce_app/Home%20Page/widgets/Browse%20Products/products_grid_view.dart';
import 'package:e_commerce_app/Home%20Page/widgets/Browse%20Products/sub_categories_list_view.dart';
import 'package:e_commerce_app/Home%20Page/widgets/custom_back_button.dart';
import 'package:e_commerce_app/global/models/product_model.dart';
import 'package:e_commerce_app/global/providers/products_provider.dart';
import 'package:e_commerce_app/global/services/products_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BrowseProductsView extends ConsumerStatefulWidget {
  const BrowseProductsView({
    super.key,
    required this.serviceFunction,
    this.isCategorized = false,
    this.currentBigCategory,
  });
  final Future<List<ProductModel>?> serviceFunction;
  final bool isCategorized;
  final String? currentBigCategory;

  @override
  ConsumerState<BrowseProductsView> createState() => _BrowseProductsViewState();
}

class _BrowseProductsViewState extends ConsumerState<BrowseProductsView> {
  late List<String> _subCategoriesList;
  late Future<List<ProductModel>?> _initProductsList;
  @override
  void initState() {
    super.initState();
    if (widget.isCategorized) {
      _subCategoriesList =
          ProductsService
              .bigCategoryToSubcategoriesMap[widget.currentBigCategory]!
              .toList();
      _subCategoriesList.insert(0, "All");
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(selectedSubcategoryProvider.notifier).state = "All";
      });
    } else {
      _initProductsList = widget.serviceFunction;
    }
  }

  @override
  Widget build(BuildContext context) {
    final productsAsyncValue = ref.watch(
      filteredProductsProvider(widget.currentBigCategory),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Stack(
          children: [
            ListView(
              clipBehavior: Clip.none,
              children: [
                if (widget.isCategorized)
                  SubCategoriesListView(subCategoriesList: _subCategoriesList),
                if (widget.isCategorized) const SizedBox(height: 15),
                if (widget.isCategorized)
                  productsAsyncValue.when(
                    loading:
                        () => const Center(
                          child: CircularProgressIndicator(color: Colors.black),
                        ),
                    error:
                        (error, stackTrace) =>
                            Center(child: Text('Error: ${error.toString()}')),
                    data: (productsList) {
                      if (productsList == null || productsList.isEmpty) {
                        return const SizedBox(
                          height: 250,
                          child: Center(child: Text('No products found.')),
                        );
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: ProductsGridView(
                          scrollPhysics: const ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return CustomProductCard(
                              product: productsList[index],
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => CardDetailsView(
                                          product: productsList[index],
                                        ),
                                  ),
                                );
                              },
                            );
                          },
                          itemCount: productsList.length,
                        ),
                      );
                    },
                  ),
                if (!widget.isCategorized)
                  FutureBuilder<List<ProductModel>?>(
                    future: _initProductsList,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(color: Colors.black),
                        );
                      } else if (snapshot.hasData) {
                        List<ProductModel> productsList = snapshot.data!;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: ProductsGridView(
                            scrollPhysics: const ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return CustomProductCard(
                                product: productsList[index],
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => CardDetailsView(
                                            product: productsList[index],
                                          ),
                                    ),
                                  );
                                },
                              );
                            },
                            itemCount: productsList.length,
                          ),
                        );
                      } else {
                        return const SizedBox(
                          height: 250,
                          child: Center(child: Text('No products found.')),
                        );
                      }
                    },
                  ),
              ],
            ),
            const Positioned(
              top: -5,
              left: 15,
              child: CustomBackButton(),
            ),
          ],
        ),
      ),
    );
  }
}


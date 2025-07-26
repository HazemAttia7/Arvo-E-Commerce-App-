import 'package:e_commerce_app/Home%20Page/views/browse_products_view.dart';
import 'package:e_commerce_app/Home%20Page/widgets/Home%20View/custom_categories_card.dart';
import 'package:e_commerce_app/global/services/categories_service.dart';
import 'package:e_commerce_app/global/services/products_service.dart';
import 'package:flutter/material.dart';

class CategoriesListView extends StatefulWidget {
  const CategoriesListView({super.key});

  @override
  State<CategoriesListView> createState() => _CategoriesListViewState();
}

class _CategoriesListViewState extends State<CategoriesListView> {
  final Map<String, String> categoriesImages = const {
    "beauty": "assets/images/beauty image.jpg",
    "fragrances": "assets/images/fragrances image.jpg",
    "groceries": "assets/images/groceries image.jpg",
    "home & living": "assets/images/home decoration image.jpg",
    "men's-fashion": "assets/images/men's fashion image.jpg",
    "motorcycle": "assets/images/motorcycle image.jpg",
    "skin-care": "assets/images/skincare image.jpg",
    "sports-accessories": "assets/images/sports accessories image.jpg",
    "sunglasses": "assets/images/sunglasses image.jpg",
    "vehicle": "assets/images/vehicle image.jpg",
    "women's-fashion": "assets/images/women's fashion image.jpg",
    "electronics": "assets/images/electronics image.jpg",
  };

  late Future<List<String>?> _initAllCategoriesFilteredList;
  @override
  void initState() {
    super.initState();
    _initAllCategoriesFilteredList =
        CategoriesService().getAllCategoriesFiltered();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>?>(
      future: _initAllCategoriesFilteredList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<String> categoriesFilteredList = snapshot.data!;
          return SizedBox(
            height: 250,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 5),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoriesFilteredList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: SizedBox(
                      width: 250,
                      child: CustomCategoriesCard(
                        image: categoriesImages[categoriesFilteredList[index]]!,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => BrowseProductsView(
                                    isCategorized: ProductsService
                                        .bigCategoryToSubcategoriesMap
                                        .containsKey(
                                          categoriesFilteredList[index],
                                        ),
                                    currentBigCategory:
                                        categoriesFilteredList[index],
                                    serviceFunction: ProductsService()
                                        .getProductsByCategory(
                                          categoryName:
                                              categoriesFilteredList[index],
                                        ),
                                  ),
                            ),
                          );
                        },
                        text: categoriesFilteredList[index].replaceAll(
                          "-",
                          " ",
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        } else {
          return const SizedBox(
            height: 250, // Maintain height
            child: Center(child: Text('No categories found.')),
          );
        }
      },
    );
  }
}

import 'package:e_commerce_app/Home%20Page/views/browse_products_view.dart';
import 'package:e_commerce_app/Home%20Page/widgets/Home%20View/categories_list_view.dart';
import 'package:e_commerce_app/Home%20Page/widgets/Home%20View/custom_bordered_button.dart';
import 'package:e_commerce_app/Home%20Page/widgets/Home%20View/home_header.dart';
import 'package:e_commerce_app/Home%20Page/widgets/Home%20View/latest_products_grid_view.dart';
import 'package:e_commerce_app/Home%20Page/widgets/Home%20View/season_latest_page_view.dart';
import 'package:e_commerce_app/global/services/products_service.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static String route = "/Home";

  @override
  Widget build(BuildContext context) {
    return Scaffold (backgroundColor: Colors.white,body: ListView(
      padding: EdgeInsets.zero,
      children: [
        const HomeHeader(),
        const SizedBox(height: 5),
        const SeasonLatestPageView(),
        const SizedBox(height: 30),
        const LatestProductsGridView(),
        const SizedBox(height: 30),
        CustomBorderedButton(
          text: "check all latest",
          hPadding: 95,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => BrowseProductsView(
                      serviceFunction: ProductsService().getLatestProducts(
                        productsNum: 30,
                      ),
                    ),
              ),
            );
          },
        ),
        const SizedBox(height: 50),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            "Shop by Categories",
            style: TextStyle(
              fontFamily: "Playfair Display",
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 15),
        const CategoriesListView(),
        const SizedBox(height: 30),
        CustomBorderedButton(
          text: "browse all categories",
          hPadding: 60,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => BrowseProductsView(
                      serviceFunction: ProductsService().getAllProducts(),
                    ),
              ),
            );
          },
        ),
        const SizedBox(height: 100),
      ],
    ));
  }
}

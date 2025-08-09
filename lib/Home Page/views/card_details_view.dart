import 'package:e_commerce_app/Home%20Page/widgets/Card%20Details/custom_page_view_with_header.dart';
import 'package:e_commerce_app/Home%20Page/widgets/custom_playfair_text.dart';
import 'package:e_commerce_app/Home%20Page/widgets/Card%20Details/product_details_section.dart';
import 'package:e_commerce_app/global/models/product_model.dart';
import 'package:flutter/material.dart';

class CardDetailsView extends StatelessWidget {
  const CardDetailsView({
    super.key,
    required this.product,
    this.isPrevScreenCheckout = false,
  });
  final ProductModel product;
  final bool isPrevScreenCheckout;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 30,
        backgroundColor: Colors.transparent,
        title: const AppBarTitle(),
      ),
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 15),
                ProductDetailsSection(
                  product: product,
                  isPrevScreenCheckout: isPrevScreenCheckout,
                ),
                const SizedBox(height: 35),
                Expanded(
                  child: CustomPageViewWithHeader(
                    description: product.description,
                    shippingInfo: product.shippingInfo,
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

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Spacer(flex: 1),
        Align(
          alignment: Alignment.centerLeft,
          child: CustomPlayFairText(text: "Arvo"),
        ),
      ],
    );
  }
}

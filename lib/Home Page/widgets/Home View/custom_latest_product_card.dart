import 'package:e_commerce_app/Home%20Page/views/browse_products_view.dart';
import 'package:e_commerce_app/Home%20Page/widgets/custom_image_with_indicator_while_loading.dart';
import 'package:e_commerce_app/Home%20Page/widgets/clickable_modern_underlined_text.dart';
import 'package:e_commerce_app/global/models/product_model.dart';
import 'package:e_commerce_app/global/services/products_service.dart';
import 'package:flutter/material.dart';

class CustomLatestProductCard extends StatefulWidget {
  const CustomLatestProductCard({
    super.key,
    required this.product,
    required this.onTap,
  });
  final ProductModel product;
  final VoidCallback onTap;
  @override
  State<CustomLatestProductCard> createState() =>
      _CustomLatestProductCardState();
}

class _CustomLatestProductCardState extends State<CustomLatestProductCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.8),
              blurRadius: 20,
              spreadRadius: -9,
            ),
          ],
        ),
        child: Card(
          shadowColor: Colors.grey.withOpacity(0.25),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0.5,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomImageWithIndicatorWhileLoading(
                image:
                    widget.product.images[0] ??
                    "assets/images/image placeholder.png",
                height: 120,
                width: 120,
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  widget.product.brand ?? widget.product.title,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: "Playfair Display",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    height: 1,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              ClickableModernUnderlinedText(
                text: "shop now",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => BrowseProductsView(
                            serviceFunction: ProductsService()
                                .getLatestProducts(productsNum: 30),
                          ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

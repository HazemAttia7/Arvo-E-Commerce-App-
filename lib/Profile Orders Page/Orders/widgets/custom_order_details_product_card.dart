import 'package:e_commerce_app/Home%20Page/widgets/custom_image_with_indicator_while_loading.dart';
import 'package:e_commerce_app/Home%20Page/widgets/price_text.dart';
import 'package:e_commerce_app/global/models/product_model.dart';
import 'package:flutter/material.dart';

class CustomOrderDetailsProductCard extends StatefulWidget {
  const CustomOrderDetailsProductCard({
    super.key,
    required this.product,
    required this.onTap,
    required this.productsMap,
  });
  final ProductModel product;
  final VoidCallback onTap;
  final Map<ProductModel, int> productsMap;
  @override
  State<CustomOrderDetailsProductCard> createState() =>
      _CustomOrderDetailsProductCardState();
}

class _CustomOrderDetailsProductCardState
    extends State<CustomOrderDetailsProductCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 124,
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
          child: Row(
            children: [
              Expanded(
                child: CustomImageWithIndicatorWhileLoading(
                  image: widget.product.images[0],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 94, 94, 94),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    PriceText(
                      price: widget.product.price,
                      discountPercentage: widget.product.discountPercentage,
                      showDiscount: false,
                      totalPriceFontSize: 18,
                      fontWeight: FontWeight.w600,
                      mul: widget.productsMap[widget.product] ?? 0,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    "x${widget.productsMap[widget.product] ?? -1}",
                    style: const TextStyle(color: Colors.grey, fontSize: 28),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

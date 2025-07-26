import 'package:e_commerce_app/Home%20Page/widgets/custom_image_with_indicator_while_loading.dart';
import 'package:e_commerce_app/Home%20Page/widgets/price_text.dart';
import 'package:e_commerce_app/global/helper/data.dart';
import 'package:e_commerce_app/global/models/product_model.dart';
import 'package:e_commerce_app/global/services/products_service.dart';
import 'package:flutter/material.dart';

class CustomProductCard extends StatefulWidget {
  const CustomProductCard({
    super.key,
    required this.product,
    required this.onTap,
  });
  final ProductModel product;
  final VoidCallback onTap;
  @override
  State<CustomProductCard> createState() => _CustomLatestProductCardState();
}

class _CustomLatestProductCardState extends State<CustomProductCard> {
  late bool isFavorite;
  @override
  void initState() {
    isFavorite = currentUser?.favList.contains(widget.product) ?? false;
    super.initState();
  }

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
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomImageWithIndicatorWhileLoading(
                    image:
                        widget.product.images[2] ??
                        widget.product.images[1] ??
                        widget.product.images[0],
                    height: 120,
                    width: 120,
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      textAlign: TextAlign.center,
                      widget.product.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        fontFamily: "Playfair Display",
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        height: 1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  PriceText(
                    price: widget.product.price,
                    discountPercentage: 20,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
              Positioned(
                right: 10,
                top: 10,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                    if (!isFavorite) {
                      ProductsService().removeProductFromFavList(
                        context,
                        widget.product,
                      );
                    } else {
                      ProductsService().addProductToFavList(
                        context,
                        widget.product,
                      );
                    }
                  },
                  child:
                      isFavorite
                          ? const Icon(
                            Icons.favorite,
                            color: Color.fromARGB(255, 255, 118, 108),
                          )
                          : const Icon(Icons.favorite_border),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:e_commerce_app/Home%20Page/widgets/clickable_modern_underlined_text.dart';
import 'package:e_commerce_app/Home%20Page/widgets/custom_image_with_indicator_while_loading.dart';
import 'package:e_commerce_app/Home%20Page/widgets/custom_playfair_text.dart';
import 'package:e_commerce_app/global/models/product_model.dart';
import 'package:flutter/material.dart';

class FavProductCard extends StatelessWidget {
  const FavProductCard({
    super.key,
    required this.favProduct,
    required this.onRemoveClicked,
  });
  final ProductModel favProduct;
  final VoidCallback onRemoveClicked;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: CustomImageWithIndicatorWhileLoading(
            image:
                favProduct.images[0] ?? "assets/images/image placeholder.png",
            height: 130,
            boxFit: BoxFit.contain,
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              if (favProduct.brand != null)
                CustomPlayFairText(fontSize: 22, text: favProduct.brand!),
              Text(
                favProduct.title,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xff848484),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 15),
              ClickableModernUnderlinedText(
                text: "remove",
                underlineWidth: 70,
                onTap: onRemoveClicked,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

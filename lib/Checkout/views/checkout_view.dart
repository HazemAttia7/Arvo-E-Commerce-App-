import 'package:e_commerce_app/Checkout/views/custom_checkout_product_card.dart';
import 'package:e_commerce_app/Checkout/widgets/custom_payment_method_row.dart';
import 'package:e_commerce_app/Checkout/widgets/price_summary_row.dart';
import 'package:e_commerce_app/Home%20Page/views/card_details_view.dart';
import 'package:e_commerce_app/Home%20Page/widgets/custom_back_button.dart';
import 'package:e_commerce_app/Landing%20Page/widgets/custom_button.dart';
import 'package:e_commerce_app/Orders/services/orders_service.dart';
import 'package:e_commerce_app/global/helper/methods.dart';
import 'package:e_commerce_app/global/models/product_model.dart';
import 'package:e_commerce_app/global/services/products_service.dart';
import 'package:e_commerce_app/global/widgets/custom_loading_indicator.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CheckoutView extends StatefulWidget {
  CheckoutView({super.key, required this.productsMap});
  Map<ProductModel, int> productsMap;

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  void refreshCart() async {
    final updatedMap = await ProductsService().getShoppingCartList(context);
    if (mounted) {
      setState(() {
        widget.productsMap = updatedMap;
      });
    }
  }

  bool isLoading = false;
  bool cashSelected = false;
  bool visaSelected = false;
  final double shippingPrice = 7, taxes = 12.75;
  double subtotal = 0;
  @override
  Widget build(BuildContext context) {
    subtotal = widget.productsMap.entries.fold<double>(
      0,
      (sum, entry) =>
          sum +
          (_calculatePrice(entry.key.price, entry.key.discountPercentage) *
              entry.value),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 30),
                child: Stack(
                  children: [
                    CustomBackButton(),
                    Center(
                      child: Text(
                        "Checkout",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "Order Summary",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.productsMap.keys.length,
                itemBuilder: (context, index) {
                  ProductModel product = widget.productsMap.keys.elementAt(
                    index,
                  );
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: CustomCheckoutProductCard(
                      product: product,
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => CardDetailsView(product: product),
                          ),
                        );
                        refreshCart();
                      },
                      onQuantityChanged: refreshCart,
                      productsMap: widget.productsMap,
                    ),
                  );
                },
              ),
              const Text(
                "Payment Method",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              CustomPaymentMethodRow(
                cashSelected: cashSelected,
                onChanged:
                    (value) => setState(() {
                      cashSelected = value!;
                      if (cashSelected) visaSelected = false;
                    }),
                text: 'Cash',
              ),
              CustomPaymentMethodRow(
                cashSelected: visaSelected,
                onChanged:
                    (value) => setState(() {
                      visaSelected = value!;
                      if (visaSelected) cashSelected = false;
                    }),
                text: 'Visa',
              ),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),
              PriceSummaryRow(text: 'Subtotal', priceToShow: subtotal),
              const SizedBox(height: 5),
              PriceSummaryRow(text: 'Shipping', priceToShow: shippingPrice),
              const SizedBox(height: 5),

              PriceSummaryRow(text: 'Taxes', priceToShow: taxes),
              const SizedBox(height: 5),

              PriceSummaryRow(
                text: 'Total',
                priceToShow: subtotal + shippingPrice + taxes,
              ),
              const SizedBox(height: 35),
              isLoading
                  ? const CustomLoadingIndicator(borderRadius: 40)
                  : CustomButton(
                    text: "Place Order",
                    onTap: () async {
                      if (!(cashSelected || visaSelected)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          buildCustomSnackBar(
                            title: "Invalid Payment Method!",
                            message:
                                "Failed to place order , please select payment method .",
                          ),
                        );
                        return;
                      }
                      await OrdersService.addOrder(
                        context,
                        totalPrice: subtotal + shippingPrice + taxes,
                        triggerLoading: () {
                          setState(() {
                            isLoading = true;
                          });
                        },
                      );
                      await ProductsService().clearShoppingCart(context);
                      setState(() {
                        isLoading = false;
                      });
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        "/", // This refers to the home route
                        (route) => false,
                      );
                    },
                    borderRadius: 40,
                  ),
              const SizedBox(height: 35),
            ],
          ),
        ),
      ),
    );
  }
}

double _calculatePrice(double price, num discountPercentage) {
  return (price - price * (discountPercentage / 100));
}

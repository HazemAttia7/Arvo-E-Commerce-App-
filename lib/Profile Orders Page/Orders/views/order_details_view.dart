import 'package:e_commerce_app/Checkout/widgets/price_summary_row.dart';
import 'package:e_commerce_app/Home%20Page/views/card_details_view.dart';
import 'package:e_commerce_app/Home%20Page/widgets/custom_back_button.dart';
import 'package:e_commerce_app/Profile%20Orders%20Page/Orders/models/order_model.dart';
import 'package:e_commerce_app/Profile%20Orders%20Page/Orders/widgets/custom_order_details_product_card.dart';
import 'package:e_commerce_app/global/models/product_model.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class OrderDetailsView extends StatefulWidget {
  OrderDetailsView({super.key, required this.order});
  OrderModel order;

  @override
  State<OrderDetailsView> createState() => _OrderDetailsViewState();
}

class _OrderDetailsViewState extends State<OrderDetailsView> {
  bool isLoading = false;
  bool cashSelected = false;
  bool visaSelected = false;
  final double shippingPrice = 7, taxes = 12.75;
  double totalPrice = 0;
  double subtotal = 0;
  @override
  Widget build(BuildContext context) {
    subtotal = widget.order.products.entries.fold<double>(
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
          clipBehavior: Clip.none,
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
                        "Order Details",
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
              const SizedBox(height: 20),
              ListView.builder(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.order.products.keys.length,
                itemBuilder: (context, index) {
                  ProductModel product = widget.order.products.keys.elementAt(
                    index,
                  );
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: CustomOrderDetailsProductCard(
                      product: product,
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => CardDetailsView(product: product),
                          ),
                        );
                      },
                      productsMap: widget.order.products,
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Payment Method",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.order.paymentMethod == enPaymentMethod.visa
                        ? "Visa"
                        : "Cash",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
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
                priceToShow: totalPrice = subtotal + shippingPrice + taxes,
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

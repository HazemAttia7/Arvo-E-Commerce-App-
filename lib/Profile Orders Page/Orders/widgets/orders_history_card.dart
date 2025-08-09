import 'dart:math';

import 'package:e_commerce_app/Home%20Page/widgets/custom_image_with_indicator_while_loading.dart';
import 'package:e_commerce_app/Profile%20Orders%20Page/Orders/models/order_model.dart';
import 'package:e_commerce_app/Profile%20Orders%20Page/Orders/views/order_details_view.dart';
import 'package:e_commerce_app/global/models/product_model.dart';
import 'package:flutter/material.dart';

class OrdersHistoryCard extends StatefulWidget {
  const OrdersHistoryCard({super.key, required this.order});
  final OrderModel order;
  @override
  State<OrdersHistoryCard> createState() => _OrdersHistoryCard();
}

class _OrdersHistoryCard extends State<OrdersHistoryCard> {
  late List<ProductModel> productsList;
  @override
  void initState() {
    productsList = widget.order.products.keys.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderDetailsView(order: widget.order),
          ),
        );
      },
      child: SizedBox(
        height: 180,
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Center(
                  child: GridView.builder(
                    padding: EdgeInsets.zero,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1,
                        ),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: min(productsList.length, 4),
                    itemBuilder: (BuildContext context, int index) {
                      return (productsList.length > 4 && index == 3)
                          ? Stack(
                            children: [
                              CustomImageWithIndicatorWhileLoading(
                                image:
                                    productsList[index].images[0] ??
                                    "assets/images/image placeholder.png",
                                height: 130,
                                boxFit: BoxFit.contain,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.black45,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              Center(
                                child: Text(
                                  "+${productsList.length - 4}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 34,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          )
                          : CustomImageWithIndicatorWhileLoading(
                            image:
                                productsList[index].images[0] ??
                                "assets/images/image placeholder.png",
                            height: 130,
                            boxFit: BoxFit.contain,
                          );
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.order.orderId,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "${widget.order.orderDate.year}-${widget.order.orderDate.month}-${widget.order.orderDate.day}",
                    style: const TextStyle(
                      fontSize: 20,
                      color: Color(0xff848484),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    r"Total Price : $" + "${widget.order.totalPrice.toInt()}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Products Bought : ${productsList.length}",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xff848484),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "Quantity : ${widget.order.products.values.fold(0, (sum, quantity) => sum + quantity)}",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xff848484),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

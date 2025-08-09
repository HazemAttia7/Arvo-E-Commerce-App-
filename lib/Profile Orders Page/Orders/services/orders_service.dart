import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/Profile%20Orders%20Page/Orders/models/order_model.dart';
import 'package:e_commerce_app/global/helper/data.dart';
import 'package:e_commerce_app/global/helper/methods.dart';
import 'package:e_commerce_app/global/models/product_model.dart';
import 'package:e_commerce_app/global/services/products_service.dart';
import 'package:flutter/material.dart';

class OrdersService {
  static Future<List<OrderModel>> getOrders(BuildContext context) async {
    try {
      CollectionReference usersCollection = FirebaseFirestore.instance
          .collection(usersCollectionName);

      if (currentUser != null) {
        final querySnapshot =
            await usersCollection
                .where("Email", isEqualTo: currentUser!.email)
                .limit(1)
                .get();

        if (querySnapshot.docs.isNotEmpty) {
          final userData =
              querySnapshot.docs.first.data() as Map<String, dynamic>;
          final Map<String, dynamic> ordersData = userData["Orders"] ?? {};
          final List<OrderModel> orders = [];

          for (var entry in ordersData.entries) {
            final String orderId = entry.key;
            final Map<String, dynamic> orderData = entry.value;

            // Parse order date
            final DateTime orderDate =
                (orderData['orderDate'] as Timestamp).toDate();
            final double totalPrice =
                (orderData['totalPrice'] ?? 0.0).toDouble();
            // Parse payment method
            final String paymentMethodString =
                orderData['Payment Method'] ?? 'Cash';
            final enPaymentMethod paymentMethod =
                paymentMethodString == 'Visa'
                    ? enPaymentMethod.visa
                    : enPaymentMethod.cash;

            // Parse products
            final Map<String, dynamic> productsData =
                orderData['products'] ?? {};
            final Map<ProductModel, int> products = {};

            for (var productEntry in productsData.entries) {
              final int productID = int.parse(productEntry.key);
              final int quantity = productEntry.value;
              final ProductModel? product = await ProductsService()
                  .getProductById(productID);
              if (product != null) {
                products[product] = quantity;
              }
            }

            final OrderModel order = OrderModel(
              orderId: orderId,
              orderDate: orderDate,
              totalPrice: totalPrice,
              products: products,
              paymentMethod: paymentMethod, // Add payment method to constructor
            );

            orders.add(order);
          }

          // Sort orders by date (newest first)
          orders.sort((a, b) => b.orderDate.compareTo(a.orderDate));
          return orders;
        } else {
          return [];
        }
      } else {
        return [];
      }
    } catch (e) {
      print("Error getting orders: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        buildCustomSnackBar(
          title: "Oops!",
          message:
              "Something went wrong while fetching orders. Please try again.",
        ),
      );
      return [];
    }
  }

  static Future<String?> addOrder(
    BuildContext context, {
    bool showMessage = true,
    bool clearCart = true,
    required VoidCallback triggerLoading,
    required OrderModel order,
  }) async {
    try {
      triggerLoading();
      order.orderId = OrderModel.generateOrderId();
      CollectionReference usersCollection = FirebaseFirestore.instance
          .collection(usersCollectionName);

      final querySnapshot =
          await usersCollection
              .where("Email", isEqualTo: currentUser!.email)
              .limit(1)
              .get();

      if (querySnapshot.docs.isNotEmpty) {
        final DocumentReference userDocRef = querySnapshot.docs.first.reference;

        final Map<String, int> productsData = {};
        for (var entry in order.products.entries) {
          productsData[entry.key.id.toString()] = entry.value;
        }
        final String paymentMethodString =
            order.paymentMethod == enPaymentMethod.visa ? "Visa" : "Cash";

        // Prepare order data
        final Map<String, dynamic> orderData = {
          'orderDate': Timestamp.fromDate(order.orderDate),
          'totalPrice': order.totalPrice,
          'products': productsData,
          'Payment Method':
              paymentMethodString, // Add payment method to Firestore
        };

        // Add order to user's orders
        await userDocRef.update({"Orders.${order.orderId}": orderData});

        // Clear shopping cart if requested
        if (clearCart) {
          await userDocRef.update({"Shopping Cart": {}});
          currentUser!.shoppingCart.clear();
        }

        if (showMessage) {
          ScaffoldMessenger.of(context).showSnackBar(
            buildCustomSnackBar(
              message: "Order placed successfully!",
              title: "Success!",
              backColor: const Color.fromARGB(255, 100, 194, 123),
            ),
          );
        }
        return order.orderId;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          buildCustomSnackBar(
            message: "User document not found.",
            title: 'Failed!',
          ),
        );
        return null;
      }
    } catch (e) {
      print("Error adding order: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        buildCustomSnackBar(
          message: "Failed to place order. Please try again.",
          title: 'Failed!',
        ),
      );
      return null;
    }
  }
}

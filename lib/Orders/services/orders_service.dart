import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/Orders/models/order_model.dart';
import 'package:e_commerce_app/global/helper/methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/global/helper/data.dart';

class OrdersService {
  static Future<bool> addOrder(
    BuildContext context, {
    required double totalPrice,
    required VoidCallback triggerLoading,
  }) async {
    try {
      triggerLoading();

      final order = OrderModel(
        orderId: OrderModel.generateOrderId(),
        orderDate: DateTime.now(),
        totalPrice: totalPrice,
      );

      CollectionReference ordersCollection = FirebaseFirestore.instance
          .collection(ordersCollectionName);

      Map<String, dynamic> orderData = order.toMap();
      if (currentUser != null) orderData['User Email'] = currentUser!.email;

      await ordersCollection.add(orderData);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Order ${order.orderId} placed successfully!",
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),
          backgroundColor: Colors.green,
        ),
      );

      return true;
    } on FirebaseException catch (e) {
      showErrorMessage(
        context,
        title: "Order Failed",
        message: getFirebaseErrorMessage(e),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Oops something went wrong. Please try again."),
        ),
      );
    }
    return false;
  }

  static Future<List<OrderModel>> getAllOrders(BuildContext context) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        showErrorMessage(
          context,
          title: "Authentication Error",
          message: "Please log in to view orders.",
        );
        return [];
      }

      CollectionReference ordersCollection = FirebaseFirestore.instance
          .collection(ordersCollectionName);

      QuerySnapshot querySnapshot =
          await ordersCollection
              .where('User Email', isEqualTo: currentUser.email)
              .orderBy('Order Date', descending: true)
              .get();

      List<OrderModel> orders = [];
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        orders.add(OrderModel.fromJSON(data));
      }

      return orders;
    } on FirebaseException catch (e) {
      showErrorMessage(
        context,
        title: "Failed to Load Orders",
        message: getFirebaseErrorMessage(e),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Oops something went wrong. Please try again."),
        ),
      );
    }
    return [];
  }

  // Helper method to get Firebase error messages
  static String getFirebaseErrorMessage(FirebaseException e) {
    switch (e.code) {
      case 'permission-denied':
        return 'You do not have permission to perform this action.';
      case 'unavailable':
        return 'Service is currently unavailable. Please try again later.';
      case 'deadline-exceeded':
        return 'Request timed out. Please check your connection.';
      default:
        return 'An error occurred: ${e.message}';
    }
  }
}

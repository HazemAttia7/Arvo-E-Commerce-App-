import 'dart:math';
import 'package:e_commerce_app/global/models/product_model.dart';

// ignore: camel_case_types
enum enPaymentMethod { visa, cash }

class OrderModel {
  String orderId;
  final DateTime orderDate;
  final double totalPrice;
  Map<ProductModel, int> products;
  final enPaymentMethod paymentMethod;
  OrderModel({
    required this.paymentMethod,
    required this.products,
    this.orderId = "",
    required this.orderDate,
    required this.totalPrice,
  });

  // Generate unique order ID like #789XYZ
  static String generateOrderId() {
    final random = Random();
    final numbers = random.nextInt(900) + 100;
    final letters = String.fromCharCodes(
      List.generate(3, (index) => random.nextInt(26) + 65),
    );
    return '#$numbers$letters';
  }
}

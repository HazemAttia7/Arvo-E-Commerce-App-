import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String orderId;
  final DateTime orderDate;
  final double totalPrice;

  OrderModel({
    required this.orderId,
    required this.orderDate,
    required this.totalPrice,
  });

  Map<String, dynamic> toMap() {
    return {
      'Order ID': orderId,
      'Order Date': orderDate,
      'Total Price': totalPrice,
    };
  }

  factory OrderModel.fromJSON(json) {
    return OrderModel(
      orderId: json['Order ID'] ?? '',
      orderDate: (json['Order Date'] as Timestamp).toDate(),
      totalPrice: json['Total Price']?.toDouble() ?? 0.0,
    );
  }

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
import 'package:e_commerce_app/global/models/product_model.dart';

class TempUserModel {
  final String name;
  final String email;
  final String password;
   List<ProductModel> favList; 
   Map<ProductModel , int> shoppingCart; 
   
  TempUserModel({
    required this.favList,required this.shoppingCart,
    required this.name,
    required this.email,
    required this.password,
  });
}
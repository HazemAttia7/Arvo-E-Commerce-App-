import 'package:e_commerce_app/global/models/product_model.dart';

class UserModel {
  final String name;
  final String email;
   List<ProductModel> favList; 
   Map<ProductModel , int> shoppingCart; 
  UserModel({required this.name, required this.email,required this.favList,required this.shoppingCart });

}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/Create%20Account/models/temp_user_model.dart';
import 'package:e_commerce_app/global/models/product_model.dart';
import 'package:e_commerce_app/global/models/user_model.dart';
import 'package:e_commerce_app/global/helper/data.dart';
import 'package:e_commerce_app/global/helper/methods.dart';
import 'package:e_commerce_app/global/services/products_service.dart';
import 'package:e_commerce_app/global/services/realm_preference_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  static Future<UserModel?> performLogin(
    BuildContext context, {
    required String email,
    required String password,
    required VoidCallback triggerLoading,
  }) async {
    try {
      triggerLoading();
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      UserModel? user = await getUserProfileByEmail(context, email: email);
      if (user != null) {
        return user;
      }
    } on FirebaseAuthException catch (e) {
      showErrorMessage(
        context,
        title: "Login Failed",
        message: getErrorMessage(e),
      );
    } catch (e) {
      showDefaultErrorMessage(context);
    }
    return null;
  }

  static Future<UserModel?> getUserProfileByEmail(
    BuildContext context, {
    required String? email,
  }) async {
    if (email == null) {
      return null;
    }
    try {
      CollectionReference users = FirebaseFirestore.instance.collection(
        usersCollectionName,
      );
      final querySnapshot =
          await users.where('Email', isEqualTo: email).limit(1).get();

      if (querySnapshot.docs.isNotEmpty) {
        final userData =
            querySnapshot.docs.first.data() as Map<String, dynamic>;
        List<ProductModel> favList = await _getListFromJSON(
          userData,
          "Favorites List",
        );
        Map<ProductModel, int> shoppingCartMap = await _getMapFromJSON(
          userData,
          "Shopping Cart",
        );
        return UserModel(
          name: userData['Name'],
          email: email,
          favList: favList,
          shoppingCart: shoppingCartMap,
        );
      } else {
        return null; // Email not found
      }
    } catch (e) {
      showErrorMessage(context, title: "Oops!", message: "User not found");
      return null;
    }
  }

  static Future<List<ProductModel>> _getListFromJSON(
    Map<String, dynamic> userData,
    String listName,
  ) async {
    final List<dynamic> productsIDs = userData[listName];
    final List<ProductModel> productsList = [];
    for (var productID in productsIDs) {
      final ProductModel? product = await ProductsService().getProductById(
        productID,
      );
      if (product != null) productsList.add(product);
    }
    return productsList;
  }

  static Future<Map<ProductModel, int>> _getMapFromJSON(
    Map<String, dynamic> userData,
    String mapName,
  ) async {
    final Map<String, dynamic> productsData = userData[mapName] ?? {};
    final Map<ProductModel, int> productsMap = {};

    for (var entry in productsData.entries) {
      final int productID = int.parse(entry.key);
      final int quantity = entry.value;
      final ProductModel? product = await ProductsService().getProductById(
        productID,
      );
      if (product != null) {
        productsMap[product] = quantity;
      }
    }

    return productsMap;
  }

  static Future<bool> performCreateAccount(
    BuildContext context, {
    required TempUserModel userData,
    required VoidCallback triggerLoading,
  }) async {
    try {
      triggerLoading();
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userData.email.trim(),
        password: userData.password.trim(),
      );
      CollectionReference usersCollection = FirebaseFirestore.instance
          .collection(usersCollectionName);
      await usersCollection.add({
        "Name": userData.name,
        "Email": userData.email,
        "Favorites List": userData.favList,
      });
      return true;
    } on FirebaseAuthException catch (e) {
      showErrorMessage(
        context,
        title: "Account Creation Failed",
        message: getErrorMessage(e),
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

  static Future<bool> performLogout(
    BuildContext context, {
    required RealmPreferenceService realmPreferenceService,
    required VoidCallback triggerLoading,
  }) async {
    try {
      triggerLoading();
      await realmPreferenceService.clearRememberMePreference();
      await FirebaseAuth.instance.signOut();
      return true;
    } on FirebaseAuthException catch (e) {
      showErrorMessage(
        context,
        title: "Oops!",
        message: getErrorMessage(e.code),
      );
    } catch (e) {
      showDefaultErrorMessage(context);
    }
    return false;
  }

  static Future<bool> isEmailExist(
    BuildContext context, {
    required String email,
  }) async {
    try {
      CollectionReference users = FirebaseFirestore.instance.collection(
        usersCollectionName,
      );
      final querySnapshot =
          await users.where('Email', isEqualTo: email).limit(1).get();
      if (querySnapshot.docs.isNotEmpty) {
        return true;
      } else {
        showErrorMessage(context, title: "Oops!", message: "Email not found");
        return false;
      }
    } catch (e) {
      showErrorMessage(context, title: "Oops!", message: "Email not found");
      return false;
    }
  }

  static Future<bool> sendPasswordReset({
    required BuildContext context,
    required String email,
    required VoidCallback triggerLoading,
  }) async {
    try {
      triggerLoading();
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      showErrorMessage(
        context,
        title: "Oops!",
        message: getErrorMessage(e.code),
      );
      return false;
    } catch (e) {
      showErrorMessage(context, title: "Oops!", message: e.toString());
      return false;
    }
  }
}

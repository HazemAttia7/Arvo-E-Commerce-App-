import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce_app/global/helper/data.dart';
import 'package:e_commerce_app/global/helper/methods.dart';
import 'package:e_commerce_app/global/models/product_model.dart';
import 'package:e_commerce_app/global/models/user_model.dart';
import 'package:flutter/material.dart';

class ProductsService {
  final Dio dio = Dio();

  static const Map<String, List<String>> bigCategoryToSubcategoriesMap = {
    "men's-fashion": ["mens-shirts", "mens-shoes", "mens-watches"],
    "women's-fashion": [
      "womens-bags",
      "womens-dresses",
      "womens-jewellery",
      "womens-shoes",
      "womens-watches",
      "tops",
    ],
    "electronics": ["smartphones", "laptops", "mobile-accessories", "tablets"],
    "home & living": ["furniture", "home-decoration", "kitchen-accessories"],
  };

  static const Set<String> generalCategoriesSet = {
    "beauty",
    "fragrances",
    "groceries",
    "motorcycle",
    "skin-care",
    "sports-accessories",
    "sunglasses",
    "vehicle",
  };

  Future<List<ProductModel>?> getLatestProducts({
    double productsNum = 4,
  }) async {
    try {
      Response response = await dio.get(
        "https://dummyjson.com/products?limit=$productsNum&sortBy=id&order=desc",
      );
      Map<String, dynamic> jsonData = response.data;
      return ProductModel.getProductsListFromJSON(jsonData);
    } on DioException catch (e) {
      log('Error fetching products: ${e.message}', name: "Debug Error");
      return [];
    } catch (e) {
      log('An unexpected error occurred: $e', name: "Debug Error");
      return [];
    }
  }

  Future<List<ProductModel>?> getAllProducts() async {
    try {
      Response response = await dio.get(
        "https://dummyjson.com/products?limit=0",
      );
      Map<String, dynamic> jsonData = response.data;
      return ProductModel.getProductsListFromJSON(jsonData);
    } on DioException catch (e) {
      log('Error fetching products: ${e.message}', name: "Debug Error");
      return [];
    } catch (e) {
      log('An unexpected error occurred: $e', name: "Debug Error");
      return [];
    }
  }

  Future<List<ProductModel>?> getProductsByCategory({
    required String categoryName,
  }) async {
    List<ProductModel> allProducts = [];

    if (bigCategoryToSubcategoriesMap.containsKey(categoryName)) {
      List<String> subcategories = bigCategoryToSubcategoriesMap[categoryName]!;

      for (String subCategory in subcategories) {
        try {
          Response response = await dio.get(
            'https://dummyjson.com/products/category/$subCategory',
          );
          Map<String, dynamic> jsonData = response.data;
          List<ProductModel> products = ProductModel.getProductsListFromJSON(
            jsonData,
          );
          allProducts.addAll(products);
        } on DioException catch (e) {
          log(
            'Error fetching products for subcategory $subCategory: ${e.message}',
            name: "Debug Error",
          );
        } catch (e) {
          log(
            'An unexpected error occurred for subcategory $subCategory: $e',
            name: "Debug Error",
          );
        }
      }
      return allProducts;
    } else if (generalCategoriesSet.contains(categoryName) ||
        bigCategoryToSubcategoriesMap.values
            .expand((list) => list)
            .contains(categoryName)) {
      try {
        Response response = await dio.get(
          'https://dummyjson.com/products/category/$categoryName',
        );
        Map<String, dynamic> jsonData = response.data;
        return ProductModel.getProductsListFromJSON(jsonData);
      } on DioException catch (e) {
        log(
          'Error fetching products for category $categoryName: ${e.message}',
          name: "Debug Error",
        );
        return [];
      } catch (e) {
        log(
          'An unexpected error occurred for category $categoryName: $e',
          name: "Debug Error",
        );
        return [];
      }
    } else {
      log('Unknown category: $categoryName', name: "Debug Error");
      return [];
    }
  }

  Future<ProductModel?> getProductById(int productID) async {
    try {
      Response response = await dio.get(
        "https://dummyjson.com/products/$productID",
      );
      Map<String, dynamic> jsonData = response.data;
      return ProductModel.fromJSON(jsonData);
    } on DioException catch (e) {
      log('Error fetching products: ${e.message}', name: "Debug Error");
      return null;
    } catch (e) {
      log('An unexpected error occurred: $e', name: "Debug Error");
      return null;
    }
  }

  Future<List<ProductModel>> getFavList(BuildContext context) async {
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
          final List<dynamic> favProductsIDs = userData["Favorites List"];
          final List<ProductModel> favList = [];
          for (var productID in favProductsIDs) {
            final ProductModel? product = await getProductById(productID);
            if (product != null) favList.add(product);
          }
          if (currentUser != null) {
            currentUser = UserModel(
              name: userData['Name'],
              email: currentUser!.email,
              favList: favList,
              shoppingCart: currentUser!.shoppingCart,
            );
            return currentUser!.favList;
          }
        } else {
          return [];
        }
      } else {
        return [];
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        buildCustomSnackBar(
          title: "Oops!",
          message: "Something went wrong. Please try again.",
        ),
      );
    }
    return [];
  }

  Future<void> addProductToFavList(
    BuildContext context,
    ProductModel product,
  ) async {
    try {
      CollectionReference usersCollection = FirebaseFirestore.instance
          .collection(usersCollectionName);
      final querySnapshot =
          await usersCollection
              .where("Email", isEqualTo: currentUser!.email)
              .limit(1)
              .get();

      if (querySnapshot.docs.isNotEmpty) {
        final DocumentReference userDocRef = querySnapshot.docs.first.reference;
        final Map<String, dynamic> userData =
            querySnapshot.docs.first.data() as Map<String, dynamic>;
        final List<dynamic> currentFavListIds =
            userData['Favorites List'] as List<dynamic>? ?? [];

        if (currentFavListIds.contains(product.id)) {
          ScaffoldMessenger.of(context).showSnackBar(
            buildCustomSnackBar(
              message: "product is already in your favorites.",
              title: "Oops!",
            ),
          );
          return;
        }

        await userDocRef.update({
          "Favorites List": FieldValue.arrayUnion([product.id]),
        });
        currentUser!.favList.add(product);
        ScaffoldMessenger.of(context).showSnackBar(
          buildCustomSnackBar(
            message: "Product Added Successfully.",
            title: "Success!",
            backColor: const Color.fromARGB(255, 100, 194, 123),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          buildCustomSnackBar(
            message: "User document not found.",
            title: 'Failed!',
          ),
        );
      }
    } catch (e) {
      print("Error adding product to fav list: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        buildCustomSnackBar(
          message: "Failed to add product to favorites. Please try again.",
          title: 'Failed!',
        ),
      );
    }
  }

  Future<void> removeProductFromFavList(
    BuildContext context,
    ProductModel product,
  ) async {
    try {
      CollectionReference usersCollection = FirebaseFirestore.instance
          .collection(usersCollectionName);

      final querySnapshot =
          await usersCollection
              .where("Email", isEqualTo: currentUser!.email)
              .limit(1)
              .get();

      if (querySnapshot.docs.isNotEmpty) {
        final userDocRef = querySnapshot.docs.first.reference;

        await userDocRef.update({
          "Favorites List": FieldValue.arrayRemove([product.id]),
        });

        currentUser!.favList.removeWhere(
          (favProduct) => favProduct.id == product.id,
        );

        print(
          "Product ${product.id} removed from favorites for ${currentUser!.email}",
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          buildCustomSnackBar(
            message: "User document not found.",
            title: 'Failed!',
          ),
        );
      }
    } catch (e) {
      print("Error removing product from fav list: $e"); // Log the actual error
      ScaffoldMessenger.of(context).showSnackBar(
        buildCustomSnackBar(
          message: "Failed to remove product from favorites. Please try again.",
          title: 'Failed!',
        ),
      );
    }
  }

  Future<Map<ProductModel, int>> getShoppingCartList(
    BuildContext context,
  ) async {
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
          final Map<String, dynamic> cartData = userData["Shopping Cart"] ?? {};
          final Map<ProductModel, int> shoppingCart = {};

          for (var entry in cartData.entries) {
            final int productID = int.parse(entry.key);
            final int quantity = entry.value;
            final ProductModel? product = await getProductById(productID);
            if (product != null) {
              shoppingCart[product] = quantity;
            }
          }

          if (currentUser != null) {
            currentUser = UserModel(
              name: userData['Name'],
              email: currentUser!.email,
              favList: currentUser!.favList,
              shoppingCart: shoppingCart,
            );
            return currentUser!.shoppingCart;
          }
        } else {
          return {};
        }
      } else {
        return {};
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        buildCustomSnackBar(
          title: "Oops!",
          message: "Something went wrong. Please try again.",
        ),
      );
    }
    return {};
  }

  Future<void> addProductToShoppingCart(
    BuildContext context,
    ProductModel product, {
    bool showMessage = true,
  }) async {
    try {
      CollectionReference usersCollection = FirebaseFirestore.instance
          .collection(usersCollectionName);
      final querySnapshot =
          await usersCollection
              .where("Email", isEqualTo: currentUser!.email)
              .limit(1)
              .get();

      if (querySnapshot.docs.isNotEmpty) {
        final DocumentReference userDocRef = querySnapshot.docs.first.reference;
        final userData =
            querySnapshot.docs.first.data() as Map<String, dynamic>;

        // Get current quantity from database (0 if product doesn't exist)
        final Map<String, dynamic> shoppingCartData =
            userData["Shopping Cart"] ?? {};
        final currentQuantity = shoppingCartData[product.id.toString()] ?? 0;
        final newQuantity = currentQuantity + 1;

        await userDocRef.update({"Shopping Cart.${product.id}": newQuantity});

        currentUser!.shoppingCart[product] = newQuantity;

        if (showMessage) {
          ScaffoldMessenger.of(context).showSnackBar(
            buildCustomSnackBar(
              message: "Product Added Successfully.",
              title: "Success!",
              backColor: const Color.fromARGB(255, 100, 194, 123),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          buildCustomSnackBar(
            message: "User document not found.",
            title: 'Failed!',
          ),
        );
      }
    } catch (e) {
      print("Error adding product to shopping cart: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        buildCustomSnackBar(
          message: "Failed to add product to shopping cart. Please try again.",
          title: 'Failed!',
        ),
      );
    }
  }

  Future<void> removeProductFromShoppingCart(
    BuildContext context,
    ProductModel product,
  ) async {
    try {
      CollectionReference usersCollection = FirebaseFirestore.instance
          .collection(usersCollectionName);

      final querySnapshot =
          await usersCollection
              .where("Email", isEqualTo: currentUser!.email)
              .limit(1)
              .get();

      if (querySnapshot.docs.isNotEmpty) {
        final userDocRef = querySnapshot.docs.first.reference;

        // Get current quantity
        final currentQuantity = currentUser!.shoppingCart[product] ?? 0;

        if (currentQuantity > 1) {
          // Decrease quantity by 1
          await userDocRef.update({
            "Shopping Cart.${product.id}": currentQuantity - 1,
          });

          // Update local data
          currentUser!.shoppingCart[product] = currentQuantity - 1;
        } else {
          // Remove the product completely if quantity is 1 or less
          await userDocRef.update({
            "Shopping Cart.${product.id}": FieldValue.delete(),
          });

          currentUser!.shoppingCart.remove(product);
        }

        print(
          "Product ${product.id} quantity updated in Shopping Cart for ${currentUser!.email}",
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          buildCustomSnackBar(
            message: "User document not found.",
            title: 'Failed!',
          ),
        );
      }
    } catch (e) {
      print(
        "Error removing product from shopping cart: $e",
      ); // Log the actual error
      ScaffoldMessenger.of(context).showSnackBar(
        buildCustomSnackBar(
          message:
              "Failed to remove product from Shopping Cart. Please try again.",
          title: 'Failed!',
        ),
      );
    }
  }

  Future<void> clearShoppingCart(BuildContext context) async {
    try {
      CollectionReference usersCollection = FirebaseFirestore.instance
          .collection(usersCollectionName);

      final querySnapshot =
          await usersCollection
              .where("Email", isEqualTo: currentUser!.email)
              .limit(1)
              .get();

      if (querySnapshot.docs.isNotEmpty) {
        final userDocRef = querySnapshot.docs.first.reference;

        await userDocRef.update({"Shopping Cart": {}});

        currentUser!.shoppingCart.clear();

        print("Shopping cart cleared for ${currentUser!.email}");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          buildCustomSnackBar(
            message: "User document not found.",
            title: 'Failed!',
          ),
        );
      }
    } catch (e) {
      print("Error clearing shopping cart: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        buildCustomSnackBar(
          message: "Failed to clear shopping cart. Please try again.",
          title: 'Failed!',
        ),
      );
    }
  }

  Future<int> getTotalCartQuantityFromDatabaseFold(BuildContext context) async {
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
          final Map<String, dynamic> shoppingCartData =
              userData["Shopping Cart"] ?? {};

          // Sum all quantities using fold
          int sum = shoppingCartData.values.fold<int>(
            0,
            (sum, quantity) => sum + (quantity as int),
          );
          return sum;
        }
      }
      return 0;
    } catch (e) {
      print("Error getting total cart quantity: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        buildCustomSnackBar(
          title: "Error",
          message: "Failed to get cart total. Please try again.",
        ),
      );
      return 0;
    }
  }
}

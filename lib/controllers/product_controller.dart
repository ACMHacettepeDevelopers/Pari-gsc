import 'package:flutter/material.dart';
import 'package:pari_gsc/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductDetailsController extends ChangeNotifier {
  late ProductModel product;

  // Accept ProductModel as a parameter in the constructor
  ProductDetailsController({required ProductModel initialProduct}) {
    product = initialProduct;
  }

  void onFavoriteButtonPressed() {
    // TODO: Add logic for the favorite button
  }

  void onAddToCartPressed() {
    // TODO: Add logic for adding to the cart
    print('Adding ${product.productTitle} to the cart');
  }
}

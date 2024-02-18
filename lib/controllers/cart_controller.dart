import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pari_gsc/models/product_model.dart';

class CartController extends ChangeNotifier {
  List<ProductModel> products = [];
  var total = 0.0;

  CartController() {
    getCartProducts();
  }

  void onPurchaseNowPressed() {}

  void onDeletePressed(String productId) {}

  void getCartProducts() {
    products = [
      ProductModel(
        productId: '1',
        productOwner: 'Owner 1',
        productTitle: 'Product 1',
        productPhotos: ['photo1.jpg', 'photo2.jpg'],
        productDescription: 'Description 1',
        creationDate: Timestamp.now(),
        lastUpdateDate: Timestamp.now(),
        interestedUsers: ['user1', 'user2'],
      ),
      ProductModel(
        productId: '2',
        productOwner: 'Owner 2',
        productTitle: 'Product 2',
        productPhotos: ['photo3.jpg', 'photo4.jpg'],
        productDescription: 'Description 2',
        creationDate: Timestamp.now(),
        lastUpdateDate: Timestamp.now(),
        interestedUsers: ['user3', 'user4'],
      ),
    ];

    total = products.fold<double>(
      0,
      (p, c) => p + c.productPhotos.length * 10,
    );

    notifyListeners();
  }
}

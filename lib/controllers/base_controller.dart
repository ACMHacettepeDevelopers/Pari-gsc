import 'package:flutter/material.dart';

class BaseController extends ChangeNotifier {
  void onFavoriteButtonPressed({required int productId}) {
    print('Favorite button pressed for product id: $productId');
  }
}

import 'package:pari_gsc/controllers/cart_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cartControllerProvider = ChangeNotifierProvider<CartController>((ref) {
  return CartController();
});

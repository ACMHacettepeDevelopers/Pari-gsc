import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pari_gsc/components/custom_button.dart';
import 'package:pari_gsc/models/product_model.dart';

class ProductDetailsController extends ChangeNotifier {
  late ProductModel product;
  ProductDetailsController() {
    product = ProductModel(
      id: 1,
      name: 'Sample Product',
      price: 20,
      image: 'img',
      isFavorite: false,
    );
  }

  void onFavoriteButtonPressed() {
    // TODO burası eksik

    notifyListeners();
  }

  void onAddToCartPressed() {
    // TODO logic eksik
    print('Adding ${product.name} to the cart');
  }
}

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = ProductDetailsController();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: CustomButton(
                  text: 'Add to Cart',
                  onPressed: () => controller.onAddToCartPressed(),
                  fontSize: 16.sp,
                  radius: 12.r,
                  verticalPadding: 12.h,
                  hasShadow: true,
                  shadowColor: theme.primaryColor,
                  shadowOpacity: 0.3,
                  shadowBlurRadius: 4,
                  shadowSpreadRadius: 0,
                ).animate().fade().slideY(
                      duration: const Duration(milliseconds: 300),
                      begin: 1,
                      curve: Curves.easeInSine,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

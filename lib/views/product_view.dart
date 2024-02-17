import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pari_gsc/components/custom_button.dart';
import 'package:pari_gsc/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductDetailsController extends ChangeNotifier {
  late ProductModel product;
  ProductDetailsController() {
    product = ProductModel(
      productId: 'SampleProductId',
      productOwner: 'SampleOwner',
      productTitle: 'Sample Product',
      productPhotos: ['img1', 'img2'],
      productDescription: 'Sample description',
      creationDate: Timestamp.now(),
      lastUpdateDate: Timestamp.now(),
      interestedUsers: ['user1', 'user2'],
    );
  }

  void onFavoriteButtonPressed() {
    // TODO: Add logic for favorite button
  }

  void onAddToCartPressed() {
    // TODO: Add logic for adding to cart
    print('Adding ${product.productTitle} to the cart');
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
              20.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: CustomButton(
                  text: 'Favorite',
                  onPressed: () => controller.onFavoriteButtonPressed(),
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

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pari_gsc/controllers/base_controller.dart';
import 'package:pari_gsc/models/product_model.dart';

class ProductItem extends StatelessWidget {
  final ProductModel product;

  const ProductItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        // Navigate to product details screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(product: product),
          ),
        );
      },
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 200.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEDF1FA),
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                ),
                Positioned(
                  right: product.id == 2 ? 0 : 20.w,
                  bottom: -80.h,
                  child: Image.asset(
                    product.image,
                    height: 260.h,
                  ).animate().slideX(
                        duration: const Duration(milliseconds: 200),
                        begin: 1,
                        curve: Curves.easeInSine,
                      ),
                ),
                Positioned(
                  left: 15.w,
                  bottom: 20.h,
                  child: GestureDetector(
                    onTap: () {
                      // You can replace this with your favorite button logic
                      // Example: controller.onFavoriteButtonPressed(productId: product.id);
                      print(
                          'Favorite button pressed for product id: ${product.id}');
                    },
                    child: CircleAvatar(
                      radius: 18.r,
                      backgroundColor: Colors.white,
                      child: Icon(
                        product.isFavorite!
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: product.isFavorite! ? null : theme.primaryColor,
                      ),
                    ),
                  ),
                ).animate().fade(),
              ],
            ),
            10.verticalSpace,
            Text(
              product.name,
              style: theme.textTheme.bodyMedium,
            ).animate().fade().slideY(
                  duration: const Duration(milliseconds: 200),
                  begin: 1,
                  curve: Curves.easeInSine,
                ),
            5.verticalSpace,
            Text(
              '\$${product.price}',
              style: theme.textTheme.displaySmall,
            ).animate().fade().slideY(
                  duration: const Duration(milliseconds: 200),
                  begin: 2,
                  curve: Curves.easeInSine,
                ),
          ],
        ),
      ),
    );
  }
}

class ProductDetailsScreen extends StatelessWidget {
  final ProductModel product;

  const ProductDetailsScreen({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Add your product details screen UI here using the 'product' data
            Text('Product Name: ${product.name}',
                style: theme.textTheme.bodyMedium),
            Text('Price: \$${product.price}',
                style: theme.textTheme.bodyMedium),
            // ... other product details
          ],
        ),
      ),
    );
  }
}

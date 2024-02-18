import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pari_gsc/models/product_model.dart';
import '../../controllers/cart_controller.dart';

class CartItem extends StatelessWidget {
  final ProductModel product;

  const CartItem({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(25.r),
            child: Stack(
              children: [
                Container(
                  width: 105.w,
                  height: 125.h,
                  color: const Color(0xFFEDF1FA),
                ),
                Positioned(
                  left: 15.w,
                  bottom: -150.h,
                  child: Image.asset(
                    'assets/images/product1',
                    height: 250.h,
                  ),
                ),
              ],
            ),
          ),
          20.horizontalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              5.verticalSpace,
              Text(
                product.productTitle,
                style: theme.textTheme.displayMedium,
                overflow: TextOverflow.ellipsis,
              ),
              10.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    child: Icon(Icons.remove),
                  ),
                  10.horizontalSpace,
                  GestureDetector(
                    child: Icon(Icons.add),
                  ),
                ],
              ),
            ],
          ),
          Spacer(),
          InkWell(
            onTap: () => CartController().onDeletePressed(product.productId),
            customBorder: const CircleBorder(),
            child: Container(
              padding: EdgeInsets.all(10.r),
              child: Icon(
                Icons.cancel,
                size: 20.w,
                color: theme.textTheme.bodyMedium!.color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

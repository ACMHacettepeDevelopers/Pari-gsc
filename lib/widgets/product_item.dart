import 'package:flutter/material.dart';
import 'package:pari_gsc/models/product_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pari_gsc/views/product_view.dart';

class ProductItem extends StatefulWidget {
  final ProductModel product;

  const ProductItem({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  final theme = ThemeData();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailView(
              product: widget.product,
            ),
          ),
        );
      },
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
                right: widget.product.productId == 'SampleProductId' ? 0 : 20.w,
                bottom: -80.h,
                child: Image.asset(
                  widget.product.productPhotos![0],
                  height: 260.h,
                  fit: BoxFit.fitHeight,
                ),
              ),
              Positioned(
                left: 15.w,
                bottom: 20.h,
                child: GestureDetector(
                  onTap: () {
                    // TODO: Handle favorite button press
                    print(
                        'Favorite button pressed for product id: ${widget.product.productId}');
                  },
                  child: CircleAvatar(
                    radius: 18.r,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.favorite_border,
                      color: theme.primaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Text(widget.product.productTitle, style: theme.textTheme.bodyMedium),
        ],
      ),
    );
  }
}

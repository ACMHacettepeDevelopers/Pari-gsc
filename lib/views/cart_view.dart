import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartView extends StatelessWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> cartItems = ['Product 1', 'Product 2', 'Product 3'];
    final double total = 150.00;

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        actions: [
          IconButton(
            icon: Icon(Icons.comment),
            onPressed: () {
              //TODO view comments
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView(
          children: [
            SizedBox(height: 30.h),
            ...cartItems.map((item) => ListTile(
                  title: Text(item),
                  trailing: Icon(Icons.delete, color: Colors.red),
                  onTap: () {
                    // Action to remove item from cart
                  },
                )),
            SizedBox(height: 30.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total:',
                    style: TextStyle(
                        fontSize: 20.sp, fontWeight: FontWeight.bold)),
                Text('\$$total',
                    style: TextStyle(
                        fontSize: 20.sp, fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 30.h),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  //TODO purchase logic
                },
                child: Text('Purchase Now'),
                style: ElevatedButton.styleFrom(
                  padding:
                      EdgeInsets.symmetric(horizontal: 50.w, vertical: 15.h),
                  textStyle: TextStyle(fontSize: 18.sp),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add_shopping_cart),
      ),
    );
  }
}

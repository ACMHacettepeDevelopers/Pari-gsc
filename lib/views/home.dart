import 'package:flutter/material.dart';
import 'package:pari_gsc/models/product_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pari_gsc/widgets/product_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<ProductModel> products = [
    ProductModel(
      productId: '1',
      productOwner: 'Owner 1',
      productTitle: 'Product 1',
      productPhotos: [
        'assets/images/product1.png',
        'assets/images/product2.png'
      ],
      productDescription: 'Description 1',
      creationDate: Timestamp.now(),
      lastUpdateDate: Timestamp.now(),
      interestedUsers: ['user1', 'user2'],
    ),
    ProductModel(
      productId: '2',
      productOwner: 'Owner 2',
      productTitle: 'Product 2',
      productPhotos: [
        'assets/images/product2.png',
        'assets/images/product1.png'
      ],
      productDescription: 'Description 2',
      creationDate: Timestamp.now(),
      lastUpdateDate: Timestamp.now(),
      interestedUsers: ['user3', 'user4'],
    ),
    ProductModel(
      productId: '3',
      productOwner: 'Owner 3',
      productTitle: 'Product 3',
      productPhotos: [
        'assets/images/product3.png',
        'assets/images/product1.png'
      ],
      productDescription: 'Description 3',
      creationDate: Timestamp.now(),
      lastUpdateDate: Timestamp.now(),
      interestedUsers: ['user5', 'user6'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView(
          children: [
            30.verticalSpace,
            const ScreenTitle(
              title: 'Home',
            ),
            20.verticalSpace,
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15.w,
                mainAxisSpacing: 15.h,
                mainAxisExtent: 260.h,
              ),
              shrinkWrap: true,
              primary: false,
              itemCount: products.length,
              itemBuilder: (context, index) => ProductItem(
                product: products[index],
              ),
            ),
            10.verticalSpace,
          ],
        ),
      ),
    );
  }
}

class ScreenTitle extends StatelessWidget {
  final String title;

  const ScreenTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headline6,
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pari_gsc/models/product_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pari_gsc/widgets/product_item.dart';

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
      productTitle: 'Hoodie',
      productPhotos: [
        'assets/images/product1.png',
        'assets/images/product2.png',
        'assets/images/product3.png',
      ],
      productDescription:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      creationDate: Timestamp.now(),
      lastUpdateDate: Timestamp.now(),
      interestedUsers: ['user1', 'user2'],
    ),
    ProductModel(
      productId: '2',
      productOwner: 'Owner 2',
      productTitle: 'Navy Blue Hoodie (Serious offers only!!111)',
      productPhotos: [
        'assets/images/product2.png',
        'assets/images/product1.png',
        'assets/images/product3.png',
      ],
      productDescription:
          "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?",
      creationDate: Timestamp.now(),
      lastUpdateDate: Timestamp.now(),
      interestedUsers: ['user3', 'user4'],
    ),
    ProductModel(
      productId: '3',
      productOwner: 'Owner 3',
      productTitle: 'Yellow Hoodie barely used',
      productPhotos: [
        'assets/images/product3.png',
        'assets/images/product1.png'
      ],
      productDescription:
          '"But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure, but because those who do not know how to pursue pleasure rationally encounter consequences that are extremely painful. Nor again is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain, but because occasionally circumstances occur in which toil and pain can procure him some great pleasure. To take a trivial example, which of us ever undertakes laborious physical exercise, except to obtain some advantage from it? But who has any right to find fault with a man who chooses to enjoy a pleasure that has no annoying consequences, or one who avoids a pain that produces no resultant pleasure?"',
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
            Center(
              child: const ScreenTitle(
                title: 'Explore',
                fontSize: 28.0,
                fontWeight: FontWeight.w500,
                fontFamily: 'Roboto',
              ),
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
  final double fontSize;
  final FontWeight fontWeight;
  final String fontFamily;

  const ScreenTitle({
    Key? key,
    required this.title,
    this.fontSize = 24.0,
    this.fontWeight = FontWeight.normal,
    this.fontFamily = 'Roboto',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontFamily: fontFamily,
      ),
    );
  }
}

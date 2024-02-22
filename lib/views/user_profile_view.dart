import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:pari_gsc/models/product_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pari_gsc/views/userScreen.dart';
import 'package:pari_gsc/widgets/product_item.dart';

class UserProfileView extends StatelessWidget {
  const UserProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> tabs = <String>['Posts', 'Profile'];
    final List<ProductModel> products = [
      ProductModel(
        productId: '1',
        productOwner: 'Owner 1',
        productTitle: 'Product 1',
        productPhotos: [
          'assets/images/product1.png',
          'assets/images/product2.png',
          'assets/images/product3.png',
        ],
        productDescription: 'Description 1',
        creationDate: Timestamp.now(),
        lastUpdateDate: Timestamp.now(),
        interestedUsers: ['user1', 'user2'],
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
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  expandedHeight: 200.0,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    title: const Text('Zeynep Yeşilkaya'),
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        const DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(0.0, 1),
                              end: Alignment(0.0, 0.0),
                              colors: <Color>[
                                Color(0x60000000),
                                Color(0x00000000),
                              ],
                            ),
                          ),
                        ),
                        Center(
                          child: ClipOval(
                            child: BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                              child: Container(
                                width: 100.0,
                                height: 100.0,
                                decoration: BoxDecoration(
                                  color:
                                      Colors.deepPurpleAccent.withOpacity(0.2),
                                ),
                                child: Center(
                                  child: Image.asset(
                                    "assets/images/female_icon.png",
                                    height: 260.h,
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    tabs: tabs.map((String name) => Tab(text: name)).toList(),
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: TabBarView(
            children: [
              // Posts Tab
              Center(
                child: Scaffold(
                  body: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: ListView(
                      children: [
                        70.verticalSpace,
                        GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
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
                ),
              ),

              // Profile Tab
              UserView(),
            ],
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this.tabBar);

  final TabBar tabBar;

  @override
  double get minExtent => tabBar.preferredSize.height;
  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

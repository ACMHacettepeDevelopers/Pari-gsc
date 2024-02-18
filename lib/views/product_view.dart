import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:pari_gsc/models/comment_model.dart';
import 'package:pari_gsc/models/product_model.dart';
import 'package:pari_gsc/views/comment_view.dart';

class ProductDetailView extends StatefulWidget {
  final ProductModel product;

  const ProductDetailView({Key? key, required this.product}) : super(key: key);

  @override
  _ProductDetailViewState createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  int _current = 0;
  final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.productTitle!),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: widget.product.productPhotos!.map((item) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Image.asset(item, fit: BoxFit.fitHeight),
                    );
                  },
                );
              }).toList(),
              carouselController: _carouselController,
              options: CarouselOptions(
                  autoPlay: false,
                  enlargeCenterPage: true,
                  aspectRatio: 1.0,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_current > 0) // Left arrow button
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios, size: 24),
                    onPressed: () => _carouselController.previousPage(),
                  ),
                if (_current <
                    widget.product.productPhotos!.length -
                        1) // Right arrow button
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios, size: 24),
                    onPressed: () => _carouselController.nextPage(),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.product.productTitle!,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(widget.product.productDescription!),
            ),
            /* Row(
              children: [
                CommentView(
                  postcomments: [
                    CommentModel(
                      commentID: '1',
                      postID: widget.product.productId,
                      username: 'User1',
                      timestamp: DateTime.now().subtract(Duration(days: 1)),
                      content: 'Great product, really loved it!',
                      UID: 'uid1',
                    ),
                    CommentModel(
                      commentID: '2',
                      postID: widget.product.productId,
                      username: 'User2',
                      timestamp: DateTime.now().subtract(Duration(hours: 2)),
                      content: 'Does it come in different colors?',
                      UID: 'uid2',
                    ),
                  ],
                  postID: widget.product.productId,
                ),
              ],
            ),*/
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO add-to-cart logic here
        },
        child: Icon(Icons.shopping_basket),
      ),
    );
  }
}

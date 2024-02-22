import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:pari_gsc/models/comment_model.dart';
import 'package:pari_gsc/models/product_model.dart';
import 'package:pari_gsc/views/chat_room.dart';
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
        centerTitle: true,
        title: Text(
          widget.product.productTitle!,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
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
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
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
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        icon: Icon(Icons.shopping_basket, size: 32),
                        onPressed: () => {},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        icon: Icon(Icons.chat_bubble, size: 32),
                        onPressed: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              ChatRoom(postId: "8VvQ1uEHM0QlSZM9hTrM"),
                        )),
                      ),
                    ),
                  ],
                ),
                Row(
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
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                widget.product.productDescription!,
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 18),
              ),
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
    );
  }
}

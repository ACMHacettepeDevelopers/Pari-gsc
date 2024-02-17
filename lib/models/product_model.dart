import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String productId;
  final String productOwner;
  final String productTitle;
  final List<String> productPhotos;
  final String productDescription;
  final Timestamp creationDate;
  final Timestamp lastUpdateDate;
  final List<String> interestedUsers;

  ProductModel({
    required this.productId,
    required this.productOwner,
    required this.productTitle,
    required this.productPhotos,
    required this.productDescription,
    required this.creationDate,
    required this.lastUpdateDate,
    required this.interestedUsers,
  });
}

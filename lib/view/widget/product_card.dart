import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:task_interview/const.dart';
import 'package:task_interview/view/product_details_screen.dart';

import '../../models/product_model.dart';

class ProductCard extends StatelessWidget {
  final ProductElement product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsScreen(product: product,),));
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey.shade200,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              offset: const Offset(0, 2),
              blurRadius: 4.0,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
      
          children: [
            // Image section
            Stack(
              children: [
                Container(
                  height: mWidth * 0.3,
                  width: mWidth * 0.3,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(8),
                    // image: DecorationImage(image: NetworkImage(product.thumbnail))
                  ),
                  child: CachedNetworkImage(
                    imageUrl: product.thumbnail,
                    imageBuilder: (context, _) {
                      return Image.network(
                        product.thumbnail,
                        height: 250,
                        width: 164,
                        fit: BoxFit.fill,
                        alignment: Alignment.topCenter,
                      );
                    },
                    placeholder: (context, url) => const SizedBox(
                      height: 250,
                      width: 164,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                ),
                // Discount badge
                !(product.discountPercentage > 0) ? Container() : Positioned(
                  left:0,
                  top: 5,
                  child: Transform.rotate(
                    angle: -0.5, // Rotate the badge to match your image
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                      color: Colors.red,
                      child:  Text(
                        "${product.discountPercentage}%",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
             SizedBox(width: mWidth * 0.02),
            // Product details section
             Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: mWidth * 0.12),
                  // Brand name
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.brand ?? "",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                      Text(
                        product.price.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
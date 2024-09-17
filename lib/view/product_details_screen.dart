import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_interview/const.dart';
import 'package:task_interview/models/product_model.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductElement product;
   const ProductDetailsScreen({super.key,required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.product.title),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: widget.product.thumbnail,
                imageBuilder: (context, _) {
                  return Image.network(
                    widget.product.thumbnail,
                    height: mHeight / 3,
                    width: mWidth,
                    fit: BoxFit.fill,
                    alignment: Alignment.topCenter,
                  );
                },
                placeholder: (context, url) => SizedBox(
                  height: mHeight / 3,
                  width: mWidth,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              Text(widget.product.description),
        
              SizedBox(height: mHeight * 0.03,),
              const Text("Reviews",
              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.product.reviews.length,
                itemBuilder: (context, index) {
                  Review review = widget.product.reviews[index];
                return Card(

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text.rich(
                            TextSpan(
                                text: review.reviewerName,
                                style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                                children: <InlineSpan>[
                                  const TextSpan(
                                    text: ' on ',
                                style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),
                                  ),TextSpan(
                                    text: DateFormat('d MMM y').format(review.date),
                                    style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
                                  )
                                ]
                            )
                        ),
                        RatingBar.readOnly(
                          filledIcon: Icons.star,
                          emptyIcon: Icons.star_border,
                          initialRating: double.parse(review.rating.toString()),
                          maxRating: 5,
                        ),
                        Text(review.comment)
                      ],
                    ),
                  )

                );
              },),
            ],
          ),
        ),
      ),
    );
  }
}

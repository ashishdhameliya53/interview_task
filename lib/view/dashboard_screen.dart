import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_interview/provider/product_provider.dart';
import 'package:task_interview/view/widget/category_widget.dart';
import 'package:task_interview/view/widget/filter_dialog.dart';
import 'package:task_interview/view/widget/product_card.dart';

import '../models/product_model.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  late ProductProvider productProvider;

  @override
  void initState() {
    super.initState();
    productProvider = context.read<ProductProvider>();
    context.read<ProductProvider>().categoryFetch();
    context.read<ProductProvider>().brandFetch();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        actions: [
           TextButton.icon(onPressed: () {
           showDialog(context: context, builder: (context) {
             return const CategoryDialog();
           },);
         }, label: const Text("Filter"),
         icon: const Icon(Icons.filter_alt),)
        ],
      ),
      body: Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
        return productProvider.showLoader ? const Center(child: CircularProgressIndicator()) : Column(
          children: [
            Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CategoryWidget(productProvider.categoryList),),

                Expanded(child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: productProvider.filtertList.length,
                  itemBuilder: (context, index) {
                    ProductElement product = productProvider.filtertList[index];
                  return  ProductCard(product: product,);


                  },))


          ],
        );
      },),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_interview/provider/product_provider.dart';

class CategoryWidget extends StatelessWidget {
  List<String> categoryList;
   CategoryWidget(this.categoryList);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoryList.length,
        itemBuilder: (context, index) {
          String cat = categoryList[index];
          return Padding(
              padding: EdgeInsets.all(4),
              child: GestureDetector(
                onTap: (){
                  context.read<ProductProvider>().selectCat(cat);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.amberAccent,
                     border: context.read<ProductProvider>().selectedCat.contains(cat) ?  Border.all() : null,
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text(cat),
                  ),
                ),
              ));
        },
      ),
    );
  }
}

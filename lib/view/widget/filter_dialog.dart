import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_interview/const.dart';
import 'package:task_interview/provider/product_provider.dart';

class CategoryDialog extends StatefulWidget {
  const CategoryDialog({
    super.key,
  });

  @override
  _CategoryDialogState createState() => _CategoryDialogState();
}

class _CategoryDialogState extends State<CategoryDialog> {

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (BuildContext context, ProductProvider provider, Widget? child) {
        return AlertDialog(
          title: const Text('Categories'),
          content: SizedBox(
            height: mHeight * 0.2,
            width: mHeight * 0.2,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: provider.brandList.length,
              itemBuilder: (context, index) {
                final brand = provider.brandList[index];
                return CheckboxListTile(
                  title: Text(brand),
                  value: provider.selectedBrand.contains(brand),
                  onChanged: (value) {
                    setState(() {
                      if (value!) {
                        provider.addBrand(brand);
                      } else {
                        provider.removeBrand(brand);

                      }
                    });
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),TextButton(
              onPressed: () {
                provider.clearFilter();
                Navigator.of(context).pop();
              },
              child: const Text('Clear'),
            ),
            TextButton(
              onPressed: () async{
                await provider.applyFilter();
                Navigator.pop(context);
              },
              child: const Text('Apply'),
            ),
          ],
        );
      },
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:task_interview/models/product_model.dart';
import 'package:task_interview/service/api_handle.dart';

class ProductProvider with ChangeNotifier{
 List<ProductElement> _productList = [];
 List<ProductElement> get  productList => _productList;

 List<ProductElement> _filtertList = [];
 List<ProductElement> get  filtertList => _filtertList;

 List<String> _categoryList = [];
 List<String> get categoryList => _categoryList;

 List<String> _brandList = [];
 List<String> get brandList => _brandList;

 List<String> _selectedBrand = [];
 List<String> get selectedBrand => _selectedBrand;

 List<String> _selectedCat = [];
 List<String> get selectedCat=> _selectedCat;

 bool _showLoader = false;
 bool get showLoader => _showLoader;

  fetchProduct() async{
   var res = await ApiService.fetchProducts();
   if(res != null){
     Product data = res;
     _productList = data.products;
     _filtertList = _productList;
   }
    notifyListeners();
  }

  categoryFetch() async{
    _showLoader = true;
   await fetchProduct();
   for (var element in _productList) {
     if(!_categoryList.contains(element.category.name)){
       _categoryList.add(element.category.name);
     }
   }
    _showLoader = false;
   notifyListeners();
  }

  brandFetch() async{
   await fetchProduct();
   for (var element in _productList) {
     if(!_brandList.contains(element.brand ?? "")){
       if(element.brand != null){
         _brandList.add(element.brand!);
       }
     }
   }
   notifyListeners();
  }


  addBrand(String name){
    _selectedBrand.add(name);
    notifyListeners();
  }
  removeBrand(String name){
    _selectedBrand.remove(name);
    notifyListeners();
  }
  selectCat(String name) async{
    if(_selectedCat.contains(name)){
      _selectedCat.remove(name);
      await applyFilter();
    }else{
      _selectedCat.add(name);
     await applyFilter();
    }
    notifyListeners();
  }

  filterWithCategory(){
    for (var element in _filtertList) {
      if(_selectedCat.contains(element.category.name) || _selectedBrand.contains(element.brand ?? "")){
        _filtertList.add(element);
      }
    }
    notifyListeners();
  }

  applyFilter(){
    _filtertList = [];
    for (var element in _productList) {
      if(_selectedBrand.contains(element.brand ?? "") || (_selectedCat.contains(element.category.name))){
        _filtertList.add(element);
      }
    }
    notifyListeners();
  }

  clearFilter() async{
    _showLoader = true;
    _selectedBrand = [];
    _filtertList = _productList;
    _showLoader = false;
    notifyListeners();
  }

}
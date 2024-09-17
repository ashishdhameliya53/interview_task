import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:task_interview/const.dart';
import 'package:task_interview/models/product_model.dart';

class ApiService{

 static getApi(String endUrl) async{
   try{
     var res = await http.get(Uri.parse(BASE_URL+endUrl));
     if(res.statusCode == 200){
      return res.body;
     }
   }catch(e){
     if (kDebugMode) {
       print(e.toString());
     }
   }
 }


 static fetchProducts() async{
   var res = await getApi(product_url);
   if(res != null){
     return productFromJson(res);
   }
 }

}
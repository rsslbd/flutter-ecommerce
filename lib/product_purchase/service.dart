import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:e_commerce_site/product_purchase/post_model.dart';

class ApiService{
  Future<List<PurchaseModel>?> getPosts() async {
    try {
      var url = Uri.parse("http://192.168.20.38:8080/api/posts");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<PurchaseModel> _model = purchaseFromJson(response.body);
        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
  }
Future<void> deletePosts(int? id) async {
    try {
      var url = Uri.parse(
         "http://192.168.20.38:8080/api/posts/" + '${id}');
      var response = await http.delete(url);

      // Response res = await delete('$apiUrl/$id');

      if (response.statusCode == 200) {
        print("Case deleted");
      } else {
        throw "Failed to delete a case.";
      }
    } catch (e) {
      log(e.toString());
    }
  }

 Future<void> createPosts(PurchaseModel purchaseModel) async {
    try {
      var url = Uri.parse("http://192.168.20.38:8080/api/posts");
      var response = await http.post(url,
      headers:{"Content-Type":"application/json"},
      body: jsonEncode(purchaseModel));

      if (response.statusCode == 200) {
      print("Updated");
      }else{
        print("Updated fail");
      }
    } catch (e) {
      log(e.toString());
    }
  }
   
}
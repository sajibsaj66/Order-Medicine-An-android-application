import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_defense_project/Model/product_model.dart';
import 'package:flutter/cupertino.dart';

class ProductProvider with ChangeNotifier{
  List<ProductModel> productList=[];
   late ProductModel productModel;

  fetchProductData() async {
    List<ProductModel> newList = [];
    QuerySnapshot value = await FirebaseFirestore.instance.collection("product_data").get();
    value.docs.forEach((element) {
      productModel = ProductModel(
          productImage: element.get("image"),
          productName: element.get("name"),
          productPrice: element.get("price"),
          productID: element.get("ID"),
          productStock: element.get("stock"),
      );
      newList.add(productModel);
    });
    productList = newList;
    notifyListeners();
  }

  List<ProductModel>  get getProductDataList{
    return productList;
  }
}
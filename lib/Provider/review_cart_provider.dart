import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_defense_project/Model/review_cart_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
class ReviewCartProvider with ChangeNotifier{
  void addReviewCartData({
    String? cartId,
    String? cartName,
    String? cartImage,
    int? cartPrice,
    int? cartQuantity,
}) async {
    FirebaseFirestore.instance.collection("ReviewCart").doc(FirebaseAuth.instance.currentUser?.uid).collection("Your Review Cart").doc(cartId).set({
      "cartID": cartId,
      "cartName": cartName,
      "cartImage": cartImage,
      "cartPrice": cartPrice,
      "cartQuantity": cartQuantity,
    });
  }

  List<ReviewCartModel> reviewCartDataList= [];
  late ReviewCartModel reviewCartModel;
  void getRevieCartData() async {
    List<ReviewCartModel> newList = [];
    QuerySnapshot reviewCartValue = await FirebaseFirestore.instance.
    collection("ReviewCart").
    doc(FirebaseAuth.instance.currentUser?.uid).
    collection("Your Review Cart").get();

    reviewCartValue.docs.forEach((element) {
      reviewCartModel = ReviewCartModel(
          cartID: element.get("cartID"),
          cartImage: element.get("cartImage"),
          cartName: element.get("cartName"),
          cartPrice: element.get("cartPrice"),
          cartQuantity: element.get("cartQuantity"),
      );
      newList.add(reviewCartModel);
    });
    reviewCartDataList = newList;
    notifyListeners();
  }
  List<ReviewCartModel> get getReviewCartDataList{
    return reviewCartDataList;
  }
  // Get Total price function//

  getTotalPrice(){
    double total=0.0;
    reviewCartDataList.forEach((element) {
      total+= element.cartPrice*element.cartQuantity;
    });
    return total;
  }

  // Review cart data delete function//
  reviewCartDataDelete(cartId){
    FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("Your Review Cart")
        .doc(cartId)
        .delete();
    notifyListeners();
  }
}
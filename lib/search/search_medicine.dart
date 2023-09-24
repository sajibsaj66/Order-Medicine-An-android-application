import 'package:final_defense_project/Order%20system/order_medicine.dart';
import 'package:final_defense_project/Model/product_model.dart';
import 'package:final_defense_project/review_cart.dart';
import 'package:final_defense_project/Widget/single_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
enum SinginCharecter{lowToHigh,highTOLow,alphabetically}
class searchMedicine extends StatefulWidget {
  //const searchMedicine({Key? key, required this.search}) : super(key: key);

  final List<ProductModel> search;
  searchMedicine({required this.search});

  @override
  _searchMedicineState createState() => _searchMedicineState();
}

class _searchMedicineState extends State<searchMedicine> {

  String query = "";
  SinginCharecter _charecter = SinginCharecter.alphabetically;
  searchItem(String query){
    List<ProductModel> searchM = widget.search.where((element){
      return element.productName.toLowerCase().contains(query);
    }).toList();
    return searchM;
  }

  @override
  Widget build(BuildContext context) {
    List<ProductModel> searhItem = searchItem(query);
    return Scaffold(
      bottomNavigationBar: ListTile(
        title: SizedBox(
          width: 160,
          child: MaterialButton(
            onPressed: (){
              Navigator.push(context,MaterialPageRoute(builder: (context)=> reviewCart()));
            },
            color: Colors.lightBlueAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Text("Review Cart",style: TextStyle(fontSize: 18),),
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(24, 24, 24,0),
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child: const Icon(
                      Icons.arrow_back_rounded,
                      size: 32,
                      color: Colors.green,
                    ),
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=> const orderMedicine()));
                    },
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 5),
                    width: MediaQuery.of(context).size.width-80,
                    height: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.lightBlueAccent,
                    ),
                    child: TextField(
                      onChanged: (value){
                        setState(() {
                          query = value;
                        });
                      },
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.black26,
                        ),
                        hintText: "Search Medicine...",
                        hintStyle: TextStyle(color: Colors.black26),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10,),

            Column(
              children: searhItem.map((data){
                return singleItem(
                  isbool: false,
                  productImage: data.productImage,
                  productName: data.productName,
                  productPrice: data.productPrice,
                  productId: data.productID,
                  productQuantity: 1,
                  index: 1,
                  productStock: data.productStock,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

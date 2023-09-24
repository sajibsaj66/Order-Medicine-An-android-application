import 'package:final_defense_project/Model/review_cart_model.dart';
import 'package:final_defense_project/Provider/review_cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';


class singleItem extends StatefulWidget {
  //const singleItem({Key? key}) : super(key: key);
  bool isbool = false;
  String productImage;
  String productName;
  String productId;
  int productStock;
  int productQuantity;
  int productPrice;
  int index;
  singleItem({required this.productStock ,required this.index ,required this.isbool,required this.productImage,required this.productName,required this.productPrice,required this.productId,required this.productQuantity});

  @override
  State<singleItem> createState() => _singleItemState();
}

class _singleItemState extends State<singleItem> {
  late ReviewCartProvider reviewCartProvider;
  int cnt=1;
  showAlertDialog(BuildContext context,ReviewCartModel delete) {

    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("No"),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Yes"),
      onPressed:  () {
        reviewCartProvider.reviewCartDataDelete(delete.cartID);
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Cart Product"),
      content: const Text("Are you sure you want to delete this product?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    reviewCartProvider = Provider.of(context);
    int q=widget.productQuantity;
    int stock = widget.productStock;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Expanded(child: SizedBox(
                height: 100,
                child: Center(
                  child: Image.network(widget.productImage),
                ),
              )),
              Expanded(child: SizedBox(
                height: 100,
                child: Column(
                  mainAxisAlignment: widget.isbool==false
                      ? MainAxisAlignment.spaceAround
                      :MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Text(widget.productName,style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        const SizedBox(height: 10,),
                        Text("Price: ${widget.productPrice} TK",style: const TextStyle(color: Colors.black,),),
                      ],
                    ),
                    // isbool==false? Container(
                    //   margin: EdgeInsets.only(right: 15),
                    //   padding: EdgeInsets.symmetric(horizontal: 10),
                    //   height: 35,
                    //   decoration: BoxDecoration(
                    //     border: Border.all(color: Colors.grey),
                    //     borderRadius: BorderRadius.circular(30),
                    //   ),
                    //   child: Row(
                    //     children: [
                    //       Expanded(
                    //           child: Text("50 TK 100 gm",
                    //             style: TextStyle(color: Colors.grey,fontSize: 14),),
                    //       ),
                    //       Center(
                    //         child: Icon(Icons.arrow_drop_down,size: 10,color: Colors.black,),
                    //       )
                    //     ],
                    //   ),
                    // ):Text("50 gram")
                  ],
                ),
              )),
              widget.isbool == false? Column(
                children: [
                  Text("Available : $stock",style: const TextStyle(color: Colors.black87,fontWeight: FontWeight.bold),),
                  const SizedBox(height: 10,),
                  Container(
                    height: 25,
                    width: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                            onTap: (){
                              setState(() {
                                if(cnt>1){
                                  cnt--;
                                }
                              }
                              );
                            },
                            child: const Icon(Icons.remove,size: 15,color: Color(0xffd0b84c))
                        ),
                        Text(
                          "$cnt",
                          style: const TextStyle(
                            color: Color(0xffd0b84c),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        InkWell(
                            onTap: (){
                              setState(() {
                                if(cnt>=stock){
                                  Fluttertoast.showToast(msg: "Stock out, Sorry");
                                }
                                else{
                                  cnt++;
                                }
                              });
                            },
                            child: const Icon(Icons.add,size: 15,color: Color(0xffd0b84c),)
                        ),
                      ],
                    ),
                  ),
                ],
              ):Container(),
              Expanded(child: Container(
                height: 100,
                padding: widget.isbool==false
                    ?const EdgeInsets.symmetric(horizontal: 15,vertical: 32)
                    :const EdgeInsets.only(left: 15,right: 15),
                child: widget.isbool==false ? Container(
                  height: 35,
                  width: 50,

                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: InkWell(
                      onTap: (){
                        if(cnt>stock){
                          Fluttertoast.showToast(msg: "Stock out, Sorry");
                        }
                        else{
                          reviewCartProvider.addReviewCartData(
                            cartId: widget.productId,
                            cartImage: widget.productImage,
                            cartName: widget.productName,
                            cartPrice: widget.productPrice,
                            cartQuantity: cnt,
                          );
                          Fluttertoast.showToast(msg: "Product added to cart list successfully");
                        }
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            size: 20,
                            color: Colors.lightBlueAccent,
                          ),
                          Text("ADD",style: TextStyle(color: Colors.lightBlueAccent,),),
                        ],
                      ),
                    ),
                  ),
                ):Column(
                  children: [
                    Text("Quantity: $q",style: const TextStyle(color: Colors.black87,fontWeight: FontWeight.bold),),
                    const SizedBox(height: 20,),
                    InkWell(
                      onTap: (){
                        ReviewCartModel data = reviewCartProvider.getReviewCartDataList[widget.index];
                        showAlertDialog(context,data);
                      },
                      child: const Icon(
                        Icons.delete,
                        size: 30,
                        color: Colors.black54,
                      ),
                    ),
                    //SizedBox(height: 5,),
                    // Container(
                    //   height: 35,
                    //   width: 70,
                    //   decoration: BoxDecoration(
                    //     border: Border.all(color: Colors.grey),
                    //     borderRadius: BorderRadius.circular(30),
                    //   ),
                    //   child: Center(
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         Icon(
                    //           Icons.add,
                    //           size: 20,
                    //           color: Colors.lightBlueAccent,
                    //         ),
                    //         Text("ADD",style: TextStyle(color: Colors.lightBlueAccent,),),
                    //       ],
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              )),
            ],
          ),
        ),
        widget.isbool == false
            ?Container()
            :const Divider(
          height: 1,
          color: Colors.black45,
        )
      ],
    );
  }
}

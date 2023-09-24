import 'dart:io';

import 'package:final_defense_project/Provider/product_provider.dart';
import 'package:final_defense_project/search/search_medicine.dart';
import 'package:final_defense_project/Order%20system/upload_prescription.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../home_page.dart';

class orderMedicine extends StatefulWidget {
  const orderMedicine({Key? key}) : super(key: key);

  @override
  _orderMedicineState createState() => _orderMedicineState();
}

class _orderMedicineState extends State<orderMedicine> {
  late ProductProvider productProvider;
  late File _image;
  final picker = ImagePicker();

  Future imagePicker() async {

      final pick = await picker.pickImage(source: ImageSource.gallery);
      setState(() {
        if(pick!=null){
          _image = File(pick.path);
        }
      });
  }

  @override
  void initState() {
    ProductProvider productProvider = Provider.of(context,listen: false);
    productProvider.fetchProductData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of(context);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Order Medicine'),
          leading: BackButton(
            onPressed:(){
              Navigator.push(context,MaterialPageRoute(builder: (context)=> home()));
            },
          ),
          //backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Center(
          child: Column(
            children: [
              const Image(image: AssetImage('assets/order_M.jpg'),fit: BoxFit.cover,),
              const SizedBox(height: 70,),
              InkWell(
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=> searchMedicine(
                    search: productProvider.getProductDataList,
                  )));
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 5),
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.lightBlueAccent,
                  ),
                  child: const TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.black26,
                      ),
                      hintText: "Search Medicine for order",
                      hintStyle: TextStyle(color: Colors.black87),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50,),

              MaterialButton(
                color: Colors.lightBlue,
                minWidth: 120,
                height: 50,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                onPressed: (){
                  //imagePicker();
                  //_showPicker(context);
                  Navigator.push(context,MaterialPageRoute(builder: (context)=> const uploadPrescription()));
                },
                child: const Text('Upload Prescription',style: TextStyle(color: Colors.white,fontSize: 20),),
              ),

              // ElevatedButton(
              //   child: Text('Upload Prescription'),
              //   onPressed: (){
              //     Navigator.push(context,MaterialPageRoute(builder: (context)=> uploadPrescription()));
              //   },
              // )
            ],
          ),
        ),

      ),
    );
  }
}

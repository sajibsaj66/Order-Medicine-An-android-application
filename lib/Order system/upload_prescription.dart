import 'dart:io';
import 'dart:typed_data';
import 'package:final_defense_project/Order%20system/order_address.dart';
import 'package:final_defense_project/Order%20system/order_medicine.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class uploadPrescription extends StatefulWidget {
  const uploadPrescription({Key? key}) : super(key: key);

  @override
  _uploadPrescriptionState createState() => _uploadPrescriptionState();
}

class _uploadPrescriptionState extends State<uploadPrescription> {

  XFile? file;
  String? selectedFile ;
  Uint8List? selectedImageInBytes;
  List<Uint8List> pickedImagesInBytes = [];
  List<String> imageUrls = [];

  void _showPicker(BuildContext context) {
    showModalBottomSheet(
      //backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.15,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: Wrap(
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                ListTile(
                    leading: const Icon(
                      Icons.photo_library,
                    ),
                    title: const Text(
                      'Gallery',
                      style: TextStyle(),
                    ),
                    onTap: () {
                      _selectFile(true);
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(
                    Icons.photo_camera,
                  ),
                  title: const Text(
                    'Camera',
                    style: TextStyle(),
                  ),
                  onTap: () {
                    _selectFile(false);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  _selectFile(bool imageFrom) async {
    file = await ImagePicker().pickImage(
        source: imageFrom? ImageSource.gallery: ImageSource.camera,
    );
    if(file!=null){
      setState(() {
        selectedFile = file!.name;
      });
    }
  }
  uploadFILE() async {
    try{
      firebase_storage.UploadTask uploadTask;
      String? id = FirebaseAuth.instance.currentUser?.uid;
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref().child('Prescription').child(id!).child('/'+file!.name);
      uploadTask = ref.putFile(File(file!.path));

      await uploadTask.whenComplete(() => null);
      String imagreUrl = await ref.getDownloadURL();

    }catch(e){
      print(e);
    }
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Prescription'),
          leading: BackButton(
            onPressed:(){
              Navigator.push(context,MaterialPageRoute(builder: (context)=> orderMedicine()));
            },
          ),
          //backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Center(
          child: Column(
            children: [
              selectedFile == null ? const Image(image: AssetImage('assets/prescription.jpg'),height: 340,width: 340,)
                  :Image.file(
                File(file!.path),
                height: 340,
                width: 340,
                fit: BoxFit.fill,
              ),
              const SizedBox(height: 40,),
              MaterialButton(
                color: Colors.lightBlue,
                minWidth: 120,
                height: 50,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                onPressed: (){
                  //imagePicker();
                  _showPicker(context);
                  //Navigator.push(context,MaterialPageRoute(builder: (context)=> uploadPrescription()));
                },
                child: const Text('Choose Prescription',style: TextStyle(color: Colors.white,fontSize: 20),),
              ),
              const SizedBox(height: 20,),
              MaterialButton(
                color: Colors.lightBlue,
                minWidth: 120,
                height: 50,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                onPressed: (){
                  //imagePicker();
                  //_showPicker(context);
                  if(file!=null){
                    uploadFILE();
                    Fluttertoast.showToast(msg: "Prescription uploaded successfully");
                  }
                  else{
                    Fluttertoast.showToast(msg: "Please select prescription fast");
                  }
                  //Navigator.push(context,MaterialPageRoute(builder: (context)=> uploadPrescription()));
                },
                child: const Text('Upload Prescription',style: TextStyle(color: Colors.white,fontSize: 20),),
              ),
              const SizedBox(height: 40,),
              MaterialButton(
                color: Colors.lightBlue,
                minWidth: 120,
                height: 50,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                onPressed: (){
                  //imagePicker();
                  //_showPicker(context);
                  if(file==null){
                    Fluttertoast.showToast(msg: "Please upload prescription fast");
                  }
                  else{
                    Navigator.push(context,MaterialPageRoute(builder: (context)=> orderAddress()));
                  }
                },
                child: const Text('Submit Order',style: TextStyle(color: Colors.white,fontSize: 20),),
              ),
            ],
          ),
        )
        //body: const Center(child: Text('Demo Prescription')),
      ),
    );
  }
}

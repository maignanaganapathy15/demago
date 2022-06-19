import 'dart:collection';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demago/constants.dart';
import 'package:demago/model/ProductModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import '../Home_page.dart';

class UploadData extends StatefulWidget {
  //const UploadData({Key? key}) : super(key: key);
  //String currentEmail;
  //UploadData(this.currentEmail);
  @override
  State<UploadData> createState() => _UploadDataState();
}

class _UploadDataState extends State<UploadData> {
  // String currentEmail;
  // _UploadDataState(this.currentEmail);
  var _image;
  String? img;
  String? email;
  final picker = ImagePicker();
  var FormKey = GlobalKey<FormState>();
  late String CompanyName, Category, Prize, Quantity;
  late String cn, cat, pri, qua;
//   initState() {
//     super.initState();

//     final cn = ProductModel.fromMap(maping).companyName;
// //    final cat = ProductModel.fromMap);
//     print(cn);
//   }

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgcolor2,
        title: Text(
          "Upload Data",
          style: TextStyle(color: fgcolor),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => Home_page(email!)));
              // Navigator.pop(context);
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (BuildContext context) => Home_page(email)));
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Form(
        key: FormKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(padding: EdgeInsets.only(top: 15)),
              Center(
                child: _image == null
                    ? Text('No image selected.')
                    : Image.file(
                        _image,
                        height: 100,
                        width: 100,
                      ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    flex: 1,
                    child: Theme(
                      data: ThemeData(
                        hintColor: Colors.indigoAccent,
                      ),
                      child: TextFormField(
                        validator: (value) {
                          if (value?.isNotEmpty == false) {
                            return 'Please enter company name';
                          } else {
                            CompanyName = value!;
                          }
                        },
                        style: TextStyle(color: fontcolor),
                        decoration: InputDecoration(
                          labelText: 'Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: fgcolor,
                              width: 1,
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: fgcolor,
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: fgcolor,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: fgcolor,
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    flex: 1,
                    child: Theme(
                      data: ThemeData(
                        hintColor: Colors.indigoAccent,
                      ),
                      child: TextFormField(
                        validator: (value) {
                          if (value?.isNotEmpty == false) {
                            return 'Please enter category';
                          } else {
                            Category = value!;
                          }
                        },
                        style: TextStyle(color: fontcolor),
                        decoration: InputDecoration(
                          labelText: 'Category',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: fgcolor,
                              width: 1,
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: fgcolor,
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: fgcolor,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: fgcolor,
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    flex: 1,
                    child: Theme(
                      data: ThemeData(
                        hintColor: Colors.indigoAccent,
                      ),
                      child: TextFormField(
                        validator: (value) {
                          if (value?.isNotEmpty == false) {
                            return 'Please enter prize of the product';
                          } else {
                            Prize = value!;
                          }
                        },
                        style: TextStyle(color: fontcolor),
                        decoration: InputDecoration(
                          labelText: 'Prize',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: fgcolor,
                              width: 1,
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: fgcolor,
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: fgcolor,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: fgcolor,
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    flex: 1,
                    child: Theme(
                      data: ThemeData(
                        hintColor: Colors.indigoAccent,
                      ),
                      child: TextFormField(
                        validator: (value) {
                          if (value?.isNotEmpty == false) {
                            return 'Please enter quantity';
                          } else {
                            Quantity = value!;
                          }
                        },
                        style: TextStyle(color: fontcolor),
                        decoration: InputDecoration(
                          labelText: 'Quantity',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: fgcolor,
                              width: 1,
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: fgcolor,
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: fgcolor,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: fgcolor,
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  )
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButton: Stack(
        children: [
          Align(
            child: FloatingActionButton(
              onPressed: getImage,
              tooltip: 'Pick Image',
              child: Icon(Icons.add_a_photo),
              elevation: 20,
              highlightElevation: 50,
            ),
            alignment: Alignment.bottomRight,
          ),
          Padding(
            padding: EdgeInsets.only(left: 30),
            child: Align(
              child: FloatingActionButton(
                elevation: 20,
                highlightElevation: 50,
                onPressed: () {
                  if (_image == null) {
                    Fluttertoast.showToast(
                      msg: 'Please select an image',
                      gravity: ToastGravity.CENTER,
                      toastLength: Toast.LENGTH_LONG,
                      timeInSecForIosWeb: 3,
                    );
                  } else {
                    uploadfirebase();
                  }
                },
                child: Icon(Icons.upload_file_rounded),
              ),
              alignment: Alignment.bottomLeft,
            ),
          ),
        ],
      ),
    );
  }

  postProductDetailsToFireStore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    final _auth = FirebaseAuth.instance;
    User? user = _auth.currentUser;
    email = user?.email;
    // final emailid = user?.email;
    // email = emailid ?? "default email";

    ProductModel productModel = ProductModel();
    productModel.companyName = CompanyName;
    productModel.category = Category;
    productModel.Prize = Prize;
    productModel.img = img;
    productModel.Quantity = Quantity;

    await firebaseFirestore
        .collection("ProductDetails")
        .add(productModel.toMap());
    // .collection("ProductDetails")
    // .doc('product')
    // .set(productModel.toMap());

    Fluttertoast.showToast(msg: "Data uploaded successfully");
  }

  // Future getUserList() async {
  //   final CollectionReference productList =
  //       FirebaseFirestore.instance.collection("ProductList");
  //   List itemlist = [];
  //   try {
  //     await productList.getDocuments().then((querySnapshot) {
  //       querySnapshot.documents.Foreach((element) {
  //         itemlist.add(element.data);
  //       });
  //     });
  //   } catch (e) {
  //     printf(e.toString());
  //     return null;
  //   }
  // }

  Future<void> uploadfirebase() async {
    if (FormKey.currentState!.validate()) {
      final reference = FirebaseStorage.instance.ref().child("images").child(
          new DateTime.now().millisecondsSinceEpoch.toString() +
              "." +
              _image.path);
      final uploadTask = reference.putFile(_image);

      Fluttertoast.showToast(
          msg: 'Image uploaded successfully', toastLength: Toast.LENGTH_SHORT);
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (BuildContext context) => Home_page(email!)));

      var imgurl = await (await uploadTask).ref.getDownloadURL();
      img = imgurl.toString();
      postProductDetailsToFireStore();
    }
  }
}

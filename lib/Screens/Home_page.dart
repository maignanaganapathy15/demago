import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demago/Screens/Home_page_controller.dart';
import 'package:demago/model/ProductModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants.dart';
import 'Backend/UploadData.dart';
import 'Login_page.dart';

class Home_page extends StatefulWidget {
  // const Home_page({Key? key}) : super(key: key);

  String currentEmail;
  Home_page(this.currentEmail);

  @override
  State<Home_page> createState() => _Home_pageState(currentEmail);
}

class _Home_pageState extends State<Home_page> {
  String currentEmail;
  _Home_pageState(this.currentEmail);
  FirebaseAuth auth = FirebaseAuth.instance;
  //List<ProductModel>? productData = HomePageController.productData;

  Future<void> logOut() async {
    auth.signOut().then((value) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => Login_page()));
    });
  }

  // void initState(){
  //   super.initState();

  // }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomePageController());
  //  print(controller.productData);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: bgcolor2,
          title: Text('Welcome'),
          centerTitle: true,
          actions: [
            TextButton.icon(
              onPressed: () {
                logOut();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Login_page()));
              },
              icon: Icon(Icons.person),
              label: Text("Log out"),
            )
          ],
        ),
        drawer: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                color: bgcolor2,
                width: double.infinity,
                height: 200,
                child: Column(children: [
                  Padding(padding: EdgeInsets.only(top: 30)),
                  Image(
                    image: AssetImage("assets/shop2.webp"),
                    fit: BoxFit.fitHeight,
                    height: 100,
                    width: 100,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    currentEmail,
                    style: TextStyle(color: Colors.black),
                  )
                ]),
              ),
              ListTile(
                  title: Text("Upload"),
                  leading: Icon(Icons.cloud_upload),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => UploadData()));
                  }),
              // ListTile(
              //   title: Text("My favourite"),
              //   leading: Icon(Icons.favorite),
              // ),
              // ListTile(
              //   title: Text("My Profile"),
              //   leading: Icon(Icons.person),
              // ),
              // Divider(
              //   color: Colors.red,
              //   indent: 20,
              //   endIndent: 20,
              // ),
              // ListTile(
              //   title: Text("Contact Us"),
              //   leading: Icon(Icons.email),
              // ),
            ],
          ),
        ),
        body: Container(
          child: SafeArea(
            child: controller == null
                ? Center(
                    child: Text('No data available'),
                  )
                : ListView.builder(
                    itemCount: controller.productData.length,
                    itemBuilder: (_, index) {
                      final data = controller.productData[index];
                      return CardUI(
                          data.companyName.toString(),
                          data.category.toString(),
                          data.img.toString(),
                          data.Prize.toString(),
                          data.Quantity.toString());
                    }),
          ),
        ));
  }
}

Widget CardUI(String companyName, String category, String image, String prize,
    String quanity) {
  return Card(
    margin: EdgeInsets.all(15),
    color: Colors.lightBlueAccent[200],
    child: Container(
      color: Colors.white,
      margin: EdgeInsets.all(1.5),
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Image.network(
            image,
            fit: BoxFit.cover,
            height: 100,
          ),
          SizedBox(
            height: 2,
          ),
          Text(
            companyName,
            style: TextStyle(color: Colors.black),
          ),
          SizedBox(
            height: 2,
          ),
          Text('category: $category'),
          SizedBox(
            height: 2,
          ),
          Text('Prize: $prize'),
          SizedBox(
            height: 2,
          ),
          Text('Quantity: $quanity'),
          SizedBox(
            height: 2,
          ),
        ],
      ),
    ),
  );
}

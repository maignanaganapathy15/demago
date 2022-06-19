import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demago/model/ProductModel.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {
  late List<ProductModel> productData;

  // List<ProductModel> defaultpd= proutomap()
  // final List<ProductModel> pd = productData;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isLoading = true;

  void getData() async {
    await Future.wait([getBannerData()]).then((value) {
      print("Data");
      print(productData[0].companyName);
      print(productData[0].Prize);
    });
    isLoading = false;
    update();
  }

  Future<void> getBannerData() async {
    await _firestore.collection('ProductDetails').get().then((value) {
      productData =
          value.docs.map((e) => ProductModel.fromJson(e.data())).toList();
    });
  }

  void onInit() {
    super.onInit();
    getData();
  }
}

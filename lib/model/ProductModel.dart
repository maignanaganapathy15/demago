class ProductModel {
  String? companyName;
  String? category;
  String? Prize;
  String? Quantity;
  String? img;

  ProductModel(
      {this.companyName, this.category, this.Prize, this.Quantity, this.img});

  ProductModel.fromJson(Map<String, dynamic> map) {
    companyName = map['companyName'];
    category = map['category'];
    Prize = map['Prize'];
    Quantity = map['Quantity'];
    img = map['img'];
  }
  // //data from the server
  // factory ProductModel.fromMap(map) {
  //   return ProductModel(
  //       companyName: map['companyName'],
  //       category: map['category'],
  //       Prize: map['Prize'],
  //       Quantity: map['Quantity'],
  //       img: map['img']);
  // }

//sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'companyName': companyName,
      'category': category,
      'Prize': Prize,
      'Quantity': Quantity,
      'img': img,
    };
  }
}

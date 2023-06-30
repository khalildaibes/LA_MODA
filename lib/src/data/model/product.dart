import 'inventory.dart';

class Product {
  String? pid;
  String? title;
  String? description;
  double? price;
  int? amountProduct;
  String? createAt;
  bool? isLike;
  Map<String, String>? urlImage;
  Map<String, String>? category;
  List<Inventory>? inventory;

  Product(
      {this.pid,
      this.title,
      this.description,
      this.price,
      this.amountProduct,
      this.createAt,
      this.isLike,
      this.urlImage,
      this.category,
      this.inventory});

  Product.fromJson(Map<String, dynamic> json) {
    pid = json['pid'];
    title = json['title'];
    description = json['description'];
    price = double.parse(json['price']);
    amountProduct = int.parse(json['amountProduct']);
    createAt = json['createAt'];
    urlImage = json['urlImage'].cast<String, String>();
    category = json['category'].cast<String, String>();
    if (json['inventory'] != null) {
      inventory = [];
      json['inventory'].forEach((v) {
        inventory?.add(new Inventory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pid'] = this.pid;
    data['title'] = this.title;
    data['description'] = this.description;
    data['price'] = this.price;
    data['amountProduct'] = this.amountProduct;
    data['createAt'] = this.createAt;
    data['isLike'] = this.isLike;
    data['urlImage'] = this.urlImage;
    data['category'] = this.category;
    if (this.inventory != null) {
      data['inventory'] = this.inventory?.map((v) => v.toJson()).toList();
    }
    return data;
  }

  Product copyWith(
      {String? pid,
      String? title,
      String? description,
      double? price,
      int? amountProduct,
      int? isLike,
      List<String>? urlImage,
      List<String>? category,
      List<Inventory>? inventory}) {
    return Product(
      pid: pid ?? this.pid,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      amountProduct: amountProduct ?? this.amountProduct,
      urlImage: this.urlImage,
      category: this.category,
      inventory: inventory ?? this.inventory,
    );
  }
}

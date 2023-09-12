import 'package:flutter/material.dart';

class Category {
  String? cid;
  String? name;
  String? slogan;
  String? description;

  Category(
      {@required this.cid, @required this.name, this.slogan, this.description});

  Category.fromJson(Map<String, dynamic> json) {
    cid = json['cid'];
    name = json['name'];
    slogan = json['slogan'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cid'] = this.cid;
    data['name'] = this.name;
    data['slogan'] = this.slogan;
    data['description'] = this.description;
    return data;
  }
}

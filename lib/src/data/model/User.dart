import 'package:cloud_firestore/cloud_firestore.dart';

import 'inventory.dart';

class App_User {
  String? id;
  String? name;
  String? rank;
  double? balance;
  String? phone;
  List<String>? notifications;

  App_User(
      {required this.id,
      required this.name,
      required this.rank,
      required this.balance,
      required this.phone,
      required this.notifications});

  factory App_User.fromFirestore(QueryDocumentSnapshot snapshot) {
    Map<String, dynamic> json = snapshot.data() as Map<String, dynamic>;
    return App_User(
        id: json['id'],
        name: json['name'],
        rank: json['rank'],
        balance: json['balance'],
        phone: json['phone'],
        notifications: json['notifications']);
  }
  App_User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    rank = json['rank'];
    balance = json['balance'];
    phone = json['phone'];
    notifications = json['notifications'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['rank'] = this.rank;
    data['balance'] = this.balance;
    data['phone'] = this.phone;
    data['notifications'] = this.notifications;
    return data;
  }

  App_User copyWith({
    String? id,
    String? name,
    String? rank,
    double? blance,
    List<String>? notifications,
    String? phone,
  }) {
    return App_User(
      id: id ?? this.id,
      name: name ?? this.name,
      rank: rank ?? this.rank,
      notifications: notifications ?? this.notifications,
      phone: phone ?? this.phone,
      balance: balance ?? this.balance,
    );
  }
}

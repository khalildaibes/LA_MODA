class Inventory {
  String? pid;
  String? colors;
  String? colors_hex;
  String? size;
  int? stockQuantity;

  Inventory(
      {this.pid, this.colors, this.colors_hex, this.size, this.stockQuantity});

  Inventory.fromJson(Map<String, dynamic> json) {
    pid = json['pid'];
    colors = json['colors'];
    colors_hex = json['colors_hex'];
    size = json['size'];
    stockQuantity = int.parse(json['stock_quantity']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pid'] = this.pid;
    data['colors'] = this.colors;
    data['colors_hex'] = this.colors_hex;
    data['size'] = this.size;
    data['stock_quantity'] = this.stockQuantity;
    return data;
  }

  Inventory copyWith({
    String? pid,
    String? colors,
    String? colors_hex,
    String? size,
    int? stockQuantity,
  }) {
    return Inventory(
        pid: pid ?? this.pid,
        stockQuantity: stockQuantity ?? this.stockQuantity);
  }
}

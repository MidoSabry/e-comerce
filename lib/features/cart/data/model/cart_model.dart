class Cart {
  int? id;
  int? userId;
  String? date;
  List<CartProducts>? cartProducts;
  int? iV;

  Cart({this.id, this.userId, this.date, this.cartProducts, this.iV});

  Cart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    date = json['date'];
    if (json['products'] != null) {
      cartProducts = <CartProducts>[];
      json['products'].forEach((v) {
        cartProducts!.add(new CartProducts.fromJson(v));
      });
    }
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['date'] = this.date;
    if (this.cartProducts != null) {
      data['products'] = this.cartProducts!.map((v) => v.toJson()).toList();
    }
    data['__v'] = this.iV;
    return data;
  }
}

class CartProducts {
  int? productId;
  int? quantity;

  CartProducts({this.productId, this.quantity});

  CartProducts.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.productId;
    data['quantity'] = this.quantity;
    return data;
  }
}
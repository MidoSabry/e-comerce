import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AddToCart {
  int productId;
  int ProductQuantity;
  AddToCart({
    required this.productId,
    required this.ProductQuantity,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productId': productId,
      'ProductQuantity': ProductQuantity,
    };
  }

  factory AddToCart.fromMap(Map<String, dynamic> map) {
    return AddToCart(
      productId: map['productId'] as int,
      ProductQuantity: map['ProductQuantity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddToCart.fromJson(String source) => AddToCart.fromMap(json.decode(source) as Map<String, dynamic>);
}

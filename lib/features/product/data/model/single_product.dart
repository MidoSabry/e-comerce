class SingleProduct {
  String? title;
  double? price;
  String? description;
  String? image;
  String? category;

  SingleProduct(
      {this.title, this.price, this.description, this.image, this.category});

  SingleProduct.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    price = json['price'];
    description = json['description'];
    image = json['image'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['price'] = this.price;
    data['description'] = this.description;
    data['image'] = this.image;
    data['category'] = this.category;
    return data;
  }
}
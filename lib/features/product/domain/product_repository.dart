import 'package:ecomerce/features/product/data/model/single_product.dart';

abstract class ProductRepository {
  Future addSingleProduct(SingleProduct singleProduct);
  Future updateSingleProduct(SingleProduct singleProduct,int productId);
  Future deleteSingleProduct(int productId);
}

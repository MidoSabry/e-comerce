import 'package:ecomerce/features/home/data/repositories/models/products.dart';

abstract class HomeRepository {
  Future<List<String>> getAllCategories();

  Future<List<Products>> getProductsWithLimit(int limit);

}

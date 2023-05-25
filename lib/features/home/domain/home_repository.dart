import 'package:ecomerce/features/home/data/repositories/models/products.dart';

abstract class HomeRepository {
  Future<List<String>> getAllCategories();

  Future<List<Products>> getProductsWithLimit(int limit);

  Future<List<Products>> getAllProducts();

  Future<List<Products>> getProductsOfEachCategory(String categoryName);

  Future<List<Products>> getProductsAfterSort(String url,String sortKind);

  Future<Products> getSingleProductData(int productId);

}

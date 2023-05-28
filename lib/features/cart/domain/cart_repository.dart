import '../data/model/add_cart_model.dart';
import '../data/model/cart_model.dart';

abstract class CartRepository{
  Future<List<Cart>> getUserCart(int userId);
  Future addProductToCart(int userId, String date, List<AddToCart> produtsData);
}
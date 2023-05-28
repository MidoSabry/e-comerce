import '../data/model/cart_model.dart';

abstract class CartRepository{
  Future<List<Cart>> getUserCart(int userId);
}
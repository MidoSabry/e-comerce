import 'package:ecomerce/features/cart/data/model/add_cart_model.dart';
import 'package:ecomerce/features/cart/data/model/cart_model.dart';
import 'package:ecomerce/features/cart/domain/cart_repository.dart';

import '../../../../core/constants/end_points.dart';
import '../../../../core/utils/dio_helper.dart';

class CartRepositoryImp extends CartRepository {
  ////////////////Get user cart/////////////////////
  @override
  Future<List<Cart>> getUserCart(int userId) async {
    var result;
    result = await DioHelper.getData(path: '${EndPoints.userCart}/$userId');

    List<dynamic> resultData = result.data;

    // print(resultData);

    List<Cart> userCartList =
        resultData.map((item) => Cart.fromJson(item)).toList();

    // print(userCartList[0].cartProducts![0].productId);
    // print(userCartList[0].cartProducts![0].quantity);

    return userCartList;
  }

  /////////////////////add product to cart api//////////////////////

  @override
  Future addProductToCart(
      int userId, String date, List<AddToCart> produtsData) async {
    List<Map<String, dynamic>> data = [];

    produtsData.forEach((element) {
      data.add({
        "productId": element.productId,
        "quantity": element.ProductQuantity,
      });
    });

    print(data);
    var result = await DioHelper.postData(
        path: EndPoints.cart,
        data: {"userId": userId, "date": date, "products": data});

    print(result);
  }
}

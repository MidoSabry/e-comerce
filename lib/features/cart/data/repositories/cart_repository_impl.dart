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
}

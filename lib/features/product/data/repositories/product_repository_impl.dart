import 'package:ecomerce/features/product/data/model/single_product.dart';
import 'package:ecomerce/features/product/domain/product_repository.dart';

import '../../../../core/constants/end_points.dart';
import '../../../../core/utils/dio_helper.dart';

class ProductRepositoryImpl extends ProductRepository {
  ///////////////add single product///////////////////
  @override
  Future addSingleProduct(SingleProduct singleProduct) async {
    var result;
    result = await DioHelper.postData(path: EndPoints.getProducts, data: {
      "title": singleProduct.title,
      "price": singleProduct.price,
      "description": singleProduct.description,
      "image": singleProduct.image,
      "category": singleProduct.category
    });

    print(result);
  }

  /////////////////update Single product/////////////////
  @override
  Future updateSingleProduct(SingleProduct singleProduct, int productId) async {
    var result;
    result = await DioHelper.putDataWithoutToken(
        path: '${EndPoints.getProducts}/$productId',
        data: {
          "title": singleProduct.title,
          "price": singleProduct.price,
          "description": singleProduct.description,
          "image": singleProduct.image,
          "category": singleProduct.category
        });

    print(result);
  }

  @override
  Future deleteSingleProduct(int productId) async {
    var result;
    result = await DioHelper.deleteDataWithoutToken(
        path: '${EndPoints.getProducts}/$productId');
    print(result);
  }
}

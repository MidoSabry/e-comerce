import 'package:ecomerce/features/auth/domain/auth_repository.dart';

import '../../../../core/constants/end_points.dart';
import '../../../../core/utils/dio_helper.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<String> loginUser(String userName, String password) async {
    var result;
    result = await DioHelper.postData(
        path: EndPoints.loginPath,
        data: {"username": userName, "password": password});

    // print(result.runtimeType);
    // print(result.data.runtimeType);
    // print(result.data["token"]);

    return result.data["token"];
  }
}

import 'package:ecomerce/features/auth/data/model/user_model.dart';
import 'package:ecomerce/features/auth/domain/auth_repository.dart';

import '../../../../core/constants/end_points.dart';
import '../../../../core/utils/dio_helper.dart';

class AuthRepositoryImpl extends AuthRepository {

  ////////////////Login user/////////////////////////////
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

 ///////////////////get user data////////////////////
  @override
  Future<User> getUserData(int userId) async{
    var result;
    result =
        await DioHelper.getData(path: '${EndPoints.users}/$userId');
        print(result);
    User user = User.fromJson(result.data);
    print("/////////");
    print(user.email);

    return user;
  }
}

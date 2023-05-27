import '../data/model/user_model.dart';

abstract class AuthRepository{
  Future<String> loginUser(String userName,String password);

  Future<User> getUserData(int userId);
}
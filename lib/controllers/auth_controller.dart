import 'package:bukuku/models/auth/user.dart';
import 'package:get/get.dart';

import '../models/auth/login_model.dart';
import '../models/auth/register_model.dart';
import '../services/auth_service.dart';

class AuthController extends GetxController{
  var isLoading = false.obs;

  final _registerResponse = Rxn<RegisterResponseModel?>();
  RegisterResponseModel? get registerResponse => _registerResponse.value;

  final _loginResponse = Rxn<LoginResponseModel?>();
  LoginResponseModel? get loginResponse => _loginResponse.value;

  Future<bool> registerUser(RegisterRequestModel registerData) async {
    isLoading(true);

    try{
      var registerUser = await AuthService().register(registerData);
      _registerResponse.value = registerUser;

      if(registerResponse?.user == null){
        return false;
      }

      return true;

    } catch(e) {
      isLoading(false);
      rethrow;

    } finally {
      isLoading(false);
    }
  }

  Future<bool> loginUser(LoginRequestModel loginData) async {
    isLoading(true);

    try{
      var loginUser = await AuthService().login(loginData);
      _loginResponse.value = loginUser;

      if(loginResponse?.token == null){
        return false;
      }

      return true;

    } catch(e) {
      isLoading(false);
      rethrow;

    } finally {
      isLoading(false);
    }

  }

  clearState(){
    Get.delete<AuthController>(force: true);
  }

}
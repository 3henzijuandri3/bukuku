import 'package:bukuku/models/auth/login_model.dart';
import 'package:bukuku/models/auth/user.dart';
import 'package:bukuku/models/book/book_model.dart';
import 'package:bukuku/services/book_service.dart';
import 'package:get/get.dart';

import '../services/auth_service.dart';

class HomeController extends GetxController{
  var isLoading = false.obs;

  final _userDataResponse = Rxn<UserModel?>();
  UserModel? get userDataResponse => _userDataResponse.value;

  final _listBookResponse = Rxn<ListBookModel?>();
  ListBookModel? get listBookResponse => _listBookResponse.value;

  final _logoutResponse = Rxn<LogoutResponseModel?>();
  LogoutResponseModel? get logoutResponse => _logoutResponse.value;

  Future<bool> logout() async {
    isLoading(true);

    try{
      var logout = await AuthService().logout();
      _logoutResponse.value = logout;

      if(logout.message != null){
        return true;
      }

      return false;

    } catch(e) {
      isLoading(false);
      rethrow;

    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchHomeData() async {
    isLoading(true);

    try{
      var userData = await AuthService().getUserData();
      _userDataResponse.value = userData;

      var listBook = await BookService().getListBook();
      _listBookResponse.value = listBook;

    } catch(e) {
      isLoading(false);
      rethrow;

    } finally {
      isLoading(false);
    }
  }

  clearState(){
    Get.delete<HomeController>(force: true);
  }

}
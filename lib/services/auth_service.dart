import 'dart:convert';
import 'package:bukuku/models/auth/user.dart';
import 'package:bukuku/shared/dio_service.dart';
import 'package:dio/dio.dart';
import 'package:bukuku/models/auth/register_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/auth/login_model.dart';

class AuthService {
  final Dio _dio = DioService.getInstance();

  Future<RegisterResponseModel> register( RegisterRequestModel registerData) async {
    try {
      final res = await _dio.post(
        '/register',
        data: registerData.toJson(),
      );

      RegisterResponseModel registerResponse = RegisterResponseModel.fromJson(jsonDecode(res.toString()));
      return registerResponse;

    } catch (e) {
      if (e is DioException) {
        return RegisterResponseModel.fromJson(jsonDecode(e.response.toString()));
      }

      rethrow;
    }
  }

  Future<LoginResponseModel> login(LoginRequestModel loginData) async {
    try{

      final res = await _dio.post(
        '/login',
        data: loginData.toJson(),
      );

      LoginResponseModel loginResponse = LoginResponseModel.fromJson(jsonDecode(res.toString()));
      String? userToken = loginResponse.token;

      if(userToken != null){
        await storeUserTokenToLocal(userToken);
      }

      return loginResponse;

    } catch (e) {
      if (e is DioException) {
        return LoginResponseModel.fromJson(jsonDecode(e.response.toString()));
      }

      rethrow;
    }
  }

  Future<UserModel> getUserData() async {
    try{

      String authToken = await getToken();

      DioService.setAuthToken(authToken);

      final res = await _dio.get(
        '/user',
      );

      UserModel userResponse = UserModel.fromJson(jsonDecode(res.toString()));
      return userResponse;

    } catch (e) {
      if (e is DioException) {
        rethrow;
      }

      rethrow;
    }
  }

  Future<void> storeUserTokenToLocal(String userToken) async {

    try{

      const storage = FlutterSecureStorage();
      await storage.write(key: 'token', value: userToken);

    } catch(e) {
      rethrow;
    }

  }

  Future<String> getToken() async {

    try{
      String token = '';

      const storage = FlutterSecureStorage();
      String? values = await storage.read(key: 'token');

      if(values != null){
        token = 'Bearer $values';
      }

      return token;

    } catch(e){
      rethrow;
    }

  }

  Future<void> clearLocalStorage() async {
    const storage = FlutterSecureStorage();
    await storage.deleteAll();
  }
}

import 'dart:convert';

import 'package:bukuku/models/book/book_model.dart';
import 'package:bukuku/shared/dio_service.dart';
import 'package:dio/dio.dart';

import 'auth_service.dart';

class BookService{
  final Dio _dio = DioService.getInstance();

  Future<ListBookModel> getListBook() async {
    try{
      String authToken = await AuthService().getToken();

      DioService.setAuthToken(authToken);

      final res = await _dio.get(
        '/books',
      );

      ListBookModel listBookResponse = ListBookModel.fromJson(jsonDecode(res.toString()));
      return listBookResponse;

    } catch (e) {
      if (e is DioException) {
        rethrow;
      }

      rethrow;
    }
  }

  Future<AddBookResponse> addBook(BookModel bookData) async {
    try{
      String authToken = await AuthService().getToken();

      DioService.setAuthToken(authToken);

      final res = await _dio.post(
        '/books',
        data: bookData.toJson()
      );

      AddBookResponse addBookResponse = AddBookResponse.fromJson(jsonDecode(res.toString()));
      return addBookResponse;

    } catch (e) {
      if (e is DioException) {
        rethrow;
      }

      rethrow;
    }

  }
}
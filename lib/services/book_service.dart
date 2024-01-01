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
        '/books/add',
        data: bookData.toJson()
      );

      AddBookResponse addBookResponse = AddBookResponse.fromJson(jsonDecode(res.toString()));
      return addBookResponse;

    } catch (e) {
      if (e is DioException) {
        return AddBookResponse.fromJson(jsonDecode(e.response.toString()));
      }

      rethrow;
    }

  }

  Future<BookModel> getBookDetail(String bookId) async {
    try{
      String authToken = await AuthService().getToken();

      DioService.setAuthToken(authToken);

      final res = await _dio.get(
        '/books/$bookId',
      );

      BookModel bookDetailResponse = BookModel.fromJson(jsonDecode(res.toString()));
      return bookDetailResponse;

    } catch (e) {
      if (e is DioException) {
        rethrow;
      }

      rethrow;
    }
  }

  Future<AddBookResponse> editBook(BookModel bookData, String bookId) async {
    try{
      String authToken = await AuthService().getToken();

      DioService.setAuthToken(authToken);

      final res = await _dio.put(
          '/books/$bookId/edit',
          data: bookData.toJson()
      );

      AddBookResponse addBookResponse = AddBookResponse.fromJson(jsonDecode(res.toString()));
      return addBookResponse;

    } catch (e) {
      if (e is DioException) {
        return AddBookResponse.fromJson(jsonDecode(e.response.toString()));
      }

      rethrow;
    }

  }
}
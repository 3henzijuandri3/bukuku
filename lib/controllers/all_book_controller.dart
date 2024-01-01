import 'package:get/get.dart';

import '../models/book/book_model.dart';
import '../services/book_service.dart';

class AllBookController extends GetxController{
  var isLoading = false.obs;

  final _listBookResponse = Rxn<ListBookModel?>();
  ListBookModel? get listBookResponse => _listBookResponse.value;

  Future<void> fetchAllBookData() async {
    isLoading(true);

    try{
      var listBook = await BookService().getListBook();
      _listBookResponse.value = listBook;

    } catch(e) {
      isLoading(false);
      rethrow;

    } finally {
      isLoading(false);
    }
  }
}
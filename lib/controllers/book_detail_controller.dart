import 'package:bukuku/models/book/book_model.dart';
import 'package:bukuku/services/book_service.dart';
import 'package:get/get.dart';

class BookDetailController extends GetxController{
  var isLoading = false.obs;

  final _bookDetailResponse = Rxn<BookModel?>();
  BookModel? get bookDetailResponse => _bookDetailResponse.value;

  Future<void> fetchBookDetail(String bookId) async {
    isLoading(true);

    try{
      var bookDetailData = await BookService().getBookDetail(bookId);
      _bookDetailResponse.value = bookDetailData;

    } catch(e) {
      isLoading(false);
      rethrow;

    } finally {
      isLoading(false);
    }
  }

  clearState(){
    Get.delete<BookDetailController>(force: true);
  }
}
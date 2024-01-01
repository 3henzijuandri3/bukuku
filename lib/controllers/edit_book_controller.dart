import 'package:bukuku/models/book/book_model.dart';
import 'package:bukuku/services/book_service.dart';
import 'package:get/get.dart';

class EditBookController extends GetxController{
  var isLoading = false.obs;
  var isUploading = false.obs;

  final _bookDetailResponse = Rxn<BookModel?>();
  BookModel? get bookDetailResponse => _bookDetailResponse.value;

  final _editBookResponse = Rxn<AddBookResponse?>();
  AddBookResponse? get editBookResponse => _editBookResponse.value;

  Future<bool> editBook(BookModel bookData, String bookId) async {
    isUploading(true);

    try{
      var editBook = await BookService().editBook(bookData, bookId);
      _editBookResponse.value = editBook;

      if(editBookResponse?.book == null){
        return false;
      }

      return true;

    } catch(e) {
      isUploading(false);
      rethrow;

    } finally {
      isUploading(false);
    }
  }

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
}
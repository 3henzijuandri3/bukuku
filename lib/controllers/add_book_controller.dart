import 'package:bukuku/models/book/book_model.dart';
import 'package:bukuku/services/book_service.dart';
import 'package:get/get.dart';

class AddBookController extends GetxController{
  var isLoading = false.obs;

  final _addBookResponse = Rxn<AddBookResponse?>();
  AddBookResponse? get addBookResponse => _addBookResponse.value;

  Future<bool> addBook(BookModel bookData) async {
    isLoading(true);

    try{
      var addBook = await BookService().addBook(bookData);
      _addBookResponse.value = addBook;

      if(addBookResponse?.book == null){
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
}
import 'package:bukuku/controllers/book_detail_controller.dart';
import 'package:bukuku/controllers/edit_book_controller.dart';
import 'package:bukuku/controllers/home_controller.dart';
import 'package:flutter/material.dart';

import '../../models/book/book_model.dart';
import '../../shared/methods.dart';
import '../../shared/theme.dart';
import '../widgets/button_custom.dart';
import '../widgets/input_form_custom.dart';
import 'package:d_info/d_info.dart';
import 'package:get/get.dart';

class EditBookPage extends StatefulWidget {
  final String bookId;
  const EditBookPage({super.key, required this.bookId});

  @override
  State<EditBookPage> createState() => _EditBookPageState();
}

class _EditBookPageState extends State<EditBookPage> {
  final editBookStateController = Get.put(EditBookController());

  final isbnController = TextEditingController(text: '');
  final titleController = TextEditingController(text: '');
  final subtitleController = TextEditingController(text: '');
  final authorController = TextEditingController(text: '');
  final publisherController = TextEditingController(text: '');
  final pagesController = TextEditingController(text: '');
  final descriptionController = TextEditingController(text: '');
  final websiteLinkController = TextEditingController(text: '');
  String? publishDate;

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    setState(() {
      publishDate = formatDate(picked.toString());
    });
  }

  storeEditBook(BookModel bookData) async {

    final editBookSuccess = await editBookStateController.editBook(
        BookModel(
          isbn: isbnController.text,
          title: titleController.text,
          subtitle: subtitleController.text,
          author: authorController.text,
          publisher: publisherController.text,
          description: descriptionController.text,
          website: websiteLinkController.text,
          pages: int.tryParse(pagesController.text) ?? 0,
          published: publishDate,
        ),
      bookData.id.toString(),
    );

    if(editBookSuccess){
      if(!context.mounted) return;
      DInfo.dialogSuccess(context, 'Edit Book Success');
      DInfo.closeDialog(
          context,
          durationBeforeClose: const Duration(seconds: 1),
          actionAfterClose: (){
            final detailStateController = Get.find<BookDetailController>();
            final homeStateController = Get.find<HomeController>();

            detailStateController.fetchBookDetail(bookData.id.toString());
            homeStateController.fetchHomeData();
            Get.back();
          }
      );

    } else {
      if(!context.mounted) return;
      final addBookResponseMessage = editBookStateController.editBookResponse!.message.toString();
      DInfo.dialogError(context, addBookResponseMessage);
      DInfo.closeDialog(
        context,
        durationBeforeClose: const Duration(milliseconds: 1600),
      );
    }

  }

  @override
  void initState() {
    super.initState();
    editBookStateController.fetchBookDetail(Get.arguments as String);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Book'),
        ),

        body: Obx((){
          final isLoading = editBookStateController.isLoading.value;
          final isUploading = editBookStateController.isUploading.value;
          final editBookDetail = editBookStateController.bookDetailResponse;

          if(isLoading){
            return const Center(child: CircularProgressIndicator());
          }

          if(editBookDetail != null){
            if(publishDate == null){
              isbnController.text = editBookDetail.isbn.toString();
              titleController.text = editBookDetail.title.toString();
              subtitleController.text = editBookDetail.subtitle.toString();
              authorController.text = editBookDetail.author.toString();
              publisherController.text = editBookDetail.publisher.toString();
              pagesController.text = editBookDetail.pages.toString();
              descriptionController.text = editBookDetail.description.toString();
              websiteLinkController.text = editBookDetail.website.toString();
              publishDate = editBookDetail.published.toString();
            }

            return Stack(
              children: [
                // Main Content
                ListView(
                  padding: const EdgeInsets.all(22),
                  children: [
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 50),
                      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 24),
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(20),
                      ),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Book ISBN
                          AddBookFormCustom(
                            formLabel: 'Book ISBN',
                            controller: isbnController,
                            type: TextInputType.number,
                          ),
                          const SizedBox(height: 16),

                          // Book Title
                          AddBookFormCustom(
                            formLabel: 'Book Title',
                            controller: titleController,
                          ),
                          const SizedBox(height: 16),

                          // Book Subtitle
                          AddBookFormCustom(
                            formLabel: 'Book Subtitle',
                            controller: subtitleController,
                          ),
                          const SizedBox(height: 16),

                          // Book Author
                          AddBookFormCustom(
                            formLabel: 'Book Author',
                            controller: authorController,
                          ),
                          const SizedBox(height: 16),

                          // Book Publisher
                          AddBookFormCustom(
                            formLabel: 'Book Publisher',
                            controller: publisherController,
                          ),
                          const SizedBox(height: 16),

                          // Book Pages
                          AddBookFormCustom(
                            formLabel: 'Book Pages',
                            controller: pagesController,
                            type: TextInputType.number,
                          ),
                          const SizedBox(height: 16),

                          // Book Link
                          AddBookFormCustom(
                            formLabel: 'Book Website Link',
                            controller: websiteLinkController,
                          ),

                          const SizedBox(height: 16),

                          // Book Description
                          AddBookFormCustom(
                            formLabel: 'Book Description',
                            controller: descriptionController,
                            maxLine: 5,
                          ),
                          const SizedBox(height: 16),

                          // Book Publish Date
                          GestureDetector(
                            onTap: (){
                              selectDate(context);
                            },
                            child: Container(
                              width: double.infinity,
                              height: 50,

                              decoration: BoxDecoration(
                                  color: whiteColor,
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                      width: 1,
                                      color: greyColor
                                  )
                              ),

                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    formatDate(editBookDetail.published!),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 30),

                          // Button Add Book
                          FilledButtonCustom(
                            width: double.infinity,
                            height: 50,
                            label: 'Edit Book',
                            onTap: (){
                              storeEditBook(editBookDetail);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Loading Bar
                if(isUploading)
                  Stack(
                    children: [
                      // Overlay
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: Colors.black.withOpacity(0.2),
                      ),

                      // Circular Bar
                      const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ],
                  ),
              ],
            );
          }

          return const Center(child: Text('Something Went Wrong :('),);
        })
    );
  }
}


import 'package:bukuku/controllers/add_book_controller.dart';
import 'package:bukuku/models/book/book_model.dart';
import 'package:bukuku/shared/methods.dart';
import 'package:bukuku/ui/widgets/button_custom.dart';
import 'package:bukuku/ui/widgets/input_form_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:d_info/d_info.dart';

import '../../shared/theme.dart';

class AddBookPage extends StatefulWidget {
  const AddBookPage({super.key});

  @override
  State<AddBookPage> createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final addBookStateController = Get.put(AddBookController());
  
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

    publishDate = formatDate(picked.toString());

    setState(() {

    });
  }

  bool validate() {
    return ![
      isbnController,
      titleController,
      subtitleController,
      authorController,
      publisherController,
      pagesController,
      descriptionController,
      websiteLinkController,
    ].any((controller) => controller.text.isEmpty) && publishDate != null;
  }

  storeBook() async {

    final addBookSuccess = await addBookStateController.addBook(
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
      )
    );

    if(addBookSuccess){
      if(!context.mounted) return;
      DInfo.dialogSuccess(context, 'Store Book Success');
      DInfo.closeDialog(
          context,
          durationBeforeClose: const Duration(seconds: 1),
          actionAfterClose: (){
            Get.offAllNamed('/home');
          }
      );

    } else {
      if(!context.mounted) return;
      final addBookResponseMessage = addBookStateController.addBookResponse!.message.toString();
      DInfo.dialogError(context, addBookResponseMessage);
      DInfo.closeDialog(
        context,
        durationBeforeClose: const Duration(milliseconds: 1600),
      );
    }

  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Book'),
      ),

      body: Obx((){
        final isLoading = addBookStateController.isLoading.value;

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
                                publishDate == null
                                    ? 'Pick Book Publish Date' : publishDate!,
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
                        label: 'Add Book',
                        onTap: (){
                          if(validate()){
                            storeBook();
                          } else {
                            DInfo.dialogError(context, 'Do not leave the form empty');
                            DInfo.closeDialog(context, durationBeforeClose: const Duration(milliseconds: 1500));
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Loading Bar
            if(isLoading)
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
      })
    );
  }
}

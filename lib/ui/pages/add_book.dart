import 'package:bukuku/ui/widgets/button_custom.dart';
import 'package:bukuku/ui/widgets/input_form_custom.dart';
import 'package:flutter/material.dart';
import 'package:d_info/d_info.dart';

import '../../shared/theme.dart';

class AddBookPage extends StatefulWidget {
  const AddBookPage({super.key});

  @override
  State<AddBookPage> createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final isbnController = TextEditingController(text: '');
  final titleController = TextEditingController(text: '');
  final subtitleController = TextEditingController(text: '');
  final authorController = TextEditingController(text: '');
  final publisherController = TextEditingController(text: '');
  final publishDateController = TextEditingController(text: '');
  final descriptionController = TextEditingController(text: '');
  final websiteLinkController = TextEditingController(text: '');

  bool validate() {
    return ![
      isbnController,
      titleController,
      subtitleController,
      authorController,
      publisherController,
      publishDateController,
      descriptionController,
      websiteLinkController,
    ].any((controller) => controller.text.isEmpty);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Book'),
      ),
      body: ListView(
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
                  formLabel: 'Book Publish Date',
                  controller: publishDateController,
                ),
                const SizedBox(height: 16),

                // Book Description
                AddBookFormCustom(
                  formLabel: 'Book Description',
                  controller: descriptionController,
                ),
                const SizedBox(height: 16),

                // Book Link
                AddBookFormCustom(
                  formLabel: 'Book Website Link',
                  controller: websiteLinkController,
                ),
                const SizedBox(height: 30),

                // Button Add Book
                FilledButtonCustom(
                  width: double.infinity,
                  height: 50,
                  label: 'Add Book',
                  onTap: (){
                    if(validate()){

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
    );
  }
}

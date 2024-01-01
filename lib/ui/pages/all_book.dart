import 'package:bukuku/controllers/all_book_controller.dart';
import 'package:bukuku/models/book/book_model.dart';
import 'package:bukuku/ui/widgets/card_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllBookPage extends StatefulWidget {
  const AllBookPage({super.key});

  @override
  State<AllBookPage> createState() => _AllBookPageState();
}

class _AllBookPageState extends State<AllBookPage> {
  final allBookStateController = Get.put(AllBookController());

  @override
  void initState() {
    super.initState();
    allBookStateController.fetchAllBookData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Book'),
      ),

      body: GetX(
          init: allBookStateController,
          builder: (controller){
            final isLoading = controller.isLoading.value;
            final listBookResponse = controller.listBookResponse;

            if(isLoading){
              return const Center(child: CircularProgressIndicator());
            }

            if(listBookResponse != null){
              if(listBookResponse.total != 0){
                List<BookModel?> listBook = listBookResponse.data!.toList();
                return GridView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    itemCount: listBook.length,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: (MediaQuery.of(context).size.width) / 2, // Adjust the padding and spacing
                      childAspectRatio: 2 / 3, // Assuming a typical book cover aspect ratio
                      crossAxisSpacing: 16,
                    ),

                    itemBuilder: (context, index){
                      return GestureDetector(
                        onTap: (){
                          Get.toNamed('/detail', arguments: listBook[index]!.id.toString());
                        },
                        child: AllCardCustom(
                            height: 200,
                            bookTitle: listBook[index]!.title.toString(),
                            author: listBook[index]!.author.toString()
                        ),
                      );
                    }
                );

              } else {
                return Center(child: Text('No Book Data'),);
              }
            }

            return const Center(child: Text('Somethibg Went Wrong :('));
          }),
    );
  }
}
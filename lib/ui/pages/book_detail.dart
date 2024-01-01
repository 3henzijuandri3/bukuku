import 'package:bukuku/controllers/book_detail_controller.dart';
import 'package:bukuku/shared/methods.dart';
import 'package:bukuku/shared/theme.dart';
import 'package:bukuku/ui/widgets/button_custom.dart';
import 'package:bukuku/ui/widgets/card_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class BookDetailPage extends StatefulWidget {
  final String bookId;

  const BookDetailPage({super.key, required this.bookId});

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  final detailStateController = Get.put(BookDetailController());
  String? bookId;

  @override
  void initState() {
    super.initState();
    detailStateController.fetchBookDetail(Get.arguments as String);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book's Detail"),
      ),

      body: GetX(
          init: detailStateController,
          builder: (controller){
            final isLoading = controller.isLoading.value;
            final detailBookResponse = controller.bookDetailResponse;

            if(isLoading){
              return const Center(child: CircularProgressIndicator());
            }

            if(detailBookResponse != null){
              return ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  const SizedBox(height: 20),

                  // Title, Subtitle, and Author
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Book Image & Title
                      DetailBookImageCard(
                        width: MediaQuery.of(context).size.width * 0.33,
                        height: 180,
                        bookTitle: detailBookResponse.title.toString(),
                      ),

                      // Book Author & Subtitle
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Book Author
                              Text(
                                detailBookResponse.author.toString(),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: blackTextStyle.copyWith(
                                  fontSize: 20,
                                  fontWeight: semiBold,
                                ),
                              ),

                              // Book Subtitle
                              Text(
                                detailBookResponse.subtitle.toString(),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: greyTextStyle.copyWith(
                                  fontSize: 16,
                                  fontWeight: medium,
                                ),
                              ),

                              const SizedBox(height: 10),

                              // Book Link
                              InkWell(
                                onTap: (){
                                  launchUrl(Uri.parse(detailBookResponse.website.toString()));
                                },
                                child: const SmallButtonCustom(
                                    paddingX: 14,
                                    paddingY: 6,
                                    label: 'See Online',
                                    customFontSize: 13
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // Pages, Publisher, and Publish Date
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14),

                    decoration: BoxDecoration(
                        border: Border.symmetric(
                            horizontal: BorderSide(color: greyColor, width: 0.5)
                        )
                    ),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Publish Date
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.calendar_month,
                              color: greyColor,
                              size: 20,
                            ),

                            const SizedBox(width: 4),

                            Text(
                              formatDate(detailBookResponse.published.toString()),
                              style: greyTextStyle.copyWith(
                                  fontSize: 14,
                                  fontWeight: medium
                              ),
                            )
                          ],
                        ),

                        // Publisher
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.store,
                              color: greyColor,
                              size: 20,
                            ),

                            const SizedBox(width: 4),

                            Text(
                              detailBookResponse.publisher.toString(),
                              style: greyTextStyle.copyWith(
                                  fontSize: 14,
                                  fontWeight: medium
                              ),
                            )
                          ],
                        ),

                        // Pages
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.menu_book_outlined,
                              color: greyColor,
                              size: 20,
                            ),

                            const SizedBox(width: 4),

                            Text(
                              '${detailBookResponse.pages.toString()} Pages',
                              style: greyTextStyle.copyWith(
                                  fontSize: 14,
                                  fontWeight: medium
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Book Details
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Book Description Text
                      Text(
                        'Book Description',
                        style: blackTextStyle.copyWith(
                            fontSize: 18,
                            fontWeight: semiBold
                        ),
                      ),

                      const SizedBox(height: 4),

                      // Book Description Content
                      Text(
                        detailBookResponse.description.toString(),
                        textAlign: TextAlign.justify,
                        style: blackTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: light,
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Button Edit and Information
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Book Edit
                          InkWell(
                            onTap: (){
                              Get.toNamed('/edit', arguments: detailBookResponse.id.toString());
                            },
                            child: const SmallButtonCustom(
                                paddingX: 14,
                                paddingY: 6,
                                label: 'Edit Book',
                                customFontSize: 13
                            ),
                          ),

                          // Added & Updated
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              // Book Added
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'Added :',
                                    textAlign: TextAlign.justify,
                                    style: blackTextStyle.copyWith(
                                      fontSize: 14,
                                      fontWeight: semiBold,
                                    ),
                                  ),

                                  const SizedBox(width: 4),

                                  Text(
                                    formatDate(detailBookResponse.createdAt.toString()),
                                    style: blackTextStyle.copyWith(
                                      fontSize: 14,
                                      fontWeight: light,
                                    ),
                                  ),
                                ],
                              ),

                              // Book Updated
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'Updated :',
                                    textAlign: TextAlign.justify,
                                    style: blackTextStyle.copyWith(
                                      fontSize: 14,
                                      fontWeight: semiBold,
                                    ),
                                  ),

                                  const SizedBox(width: 4),

                                  Text(
                                    formatDate(detailBookResponse.updatedAt.toString()),
                                    style: blackTextStyle.copyWith(
                                      fontSize: 14,
                                      fontWeight: light,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              );
            }

            return const Center(child: Text('Something Went Wrong :('));

          }),
    );
  }
}

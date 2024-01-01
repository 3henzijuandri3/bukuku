
import 'package:bukuku/controllers/home_controller.dart';
import 'package:bukuku/models/book/book_model.dart';
import 'package:bukuku/shared/values.dart';
import 'package:bukuku/ui/widgets/button_custom.dart';
import 'package:bukuku/ui/widgets/card_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:d_info/d_info.dart';
import '../../shared/theme.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeStateController = Get.put(HomeController());

  logout() async {
    final logoutSuccess = await homeStateController.logout();

    if(logoutSuccess){
      if(!context.mounted) return;
      final loginResponseMessage = homeStateController.logoutResponse!.message.toString();
      DInfo.toastSuccess(loginResponseMessage);
      Get.offAllNamed('/onboarding');

    } else {
      if(!context.mounted) return;
      final loginResponseMessage = homeStateController.logoutResponse!.message.toString();
      DInfo.dialogError(context, loginResponseMessage);
      DInfo.closeDialog(
        context,
        durationBeforeClose: const Duration(milliseconds: 1600),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    homeStateController.fetchHomeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX(
          init: homeStateController,
          builder: (controller){
            final isLoading = controller.isLoading.value;
            final userDataResponse = controller.userDataResponse;
            final listBookResponse = controller.listBookResponse;

            if(isLoading){
              return const Center(child: CircularProgressIndicator(),);
            }

            if(userDataResponse != null){
              if(listBookResponse!.total != 0){
                final getRecentBook = listBookResponse.data!.last;
                final getLatestBook = listBookResponse.data!.reversed.take(5).toList();

                return SafeArea(
                  child: ListView(
                    padding: const EdgeInsets.all(22),
                    children: [

                      // Profile Section
                      profileSection(userDataResponse.name.toString()),

                      const SizedBox(height: 32),

                      // Recent Book
                      addBookBanner(),

                      const SizedBox(height: 30),

                      optionMenu(),

                      const SizedBox(height: 30),

                      // Recently Added Book
                      recentlyAddedBook(getRecentBook!),

                      const SizedBox(height: 30),

                      // Random Book
                      latestBook(getLatestBook),

                      const SizedBox(height: 20),
                    ],
                  ),
                );

              }
              else {
                return SafeArea(
                  child: ListView(
                    padding: const EdgeInsets.all(22),
                    children: [

                      // Profile Section
                      profileSection(userDataResponse.name.toString()),

                      const SizedBox(height: 32),

                      // Recent Book
                      addBookBanner(),

                      const SizedBox(height: 30),

                      // Option Menu
                      optionMenu(),
                    ],
                  ),
                );
              }
            }

            return const Center(child: Text('Something Went Wrong :('));

          }),
    );
  }

  Widget profileSection(String username){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        // Name
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome Back',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: greyTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: regular
              ),
            ),

            SizedBox(
              width: 250,
              child: Text(
                username,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: blackTextStyle.copyWith(
                    fontSize: 26,
                    fontWeight: semiBold
                ),
              ),
            ),
          ],
        ),

        // Profile
        GestureDetector(
          onTap: (){
            showDialog(context: context, builder: (context) => moreDialog());
          },

          child: Container(
            width: 60,
            height: 60,

            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(userProfile),
              ),
            ),
          ),
        )

      ],
    );
  }

  Widget addBookBanner(){
    return Container(
      width: double.infinity,
      height: 250,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(bgRecentBook),
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.35),
                BlendMode.multiply
            )
        ),
      ),

      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Start Track Your\nBook Reading',
                textAlign: TextAlign.center,
                style: whiteTextStyle.copyWith(
                    fontSize: 28,
                    fontWeight: semiBold
                ),
              ),

              const SizedBox(height: 18),

              GestureDetector(
                onTap: (){
                  Get.toNamed('/addBook');
                },
                child: const SmallButtonCustom(
                    paddingX: 26,
                    paddingY: 10,
                    label: 'Add Book',
                    customFontSize: 16
                ),
              )
            ],
          )
      ),
    );
  }

  Widget optionMenu(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Do Something',
          style: blackTextStyle.copyWith(
              fontSize: 18,
              fontWeight: semiBold
          ),
        ),

        const SizedBox(height: 14),

        // Option Menu
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            MenuButtonCutom(
                icon: Icons.shelves,
                label: 'All Book',
                onTap: (){
                  Get.toNamed('/allBook');
                }
            ),

            MenuButtonCutom(
                icon: Icons.book_outlined,
                label: 'Add Book',
                onTap: (){
                  Get.toNamed('/addBook');
                }
            ),
          ],
        ),
      ],
    );
  }

  Widget latestBook(List<BookModel?> listBook){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        // Random Book Text
        Text(
          'Your Latest Book',
          style: blackTextStyle.copyWith(
            fontSize: 18,
            fontWeight: semiBold,
          ),
        ),

        const SizedBox(height: 14),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: listBook.map((book)
            =>
                InkWell(
                  onTap: (){
                    Get.toNamed('/detail', arguments: book.id.toString());
                  },
                  child: LatestCardCustom(
                      author: book!.author.toString(),
                      title: book.title.toString(),
                  ),
                )).toList(),
          ),
        )
      ],
    );
  }

  Widget recentlyAddedBook(BookModel book){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text
        Text(
          'Recently Added Book',
          style: blackTextStyle.copyWith(
            fontSize: 18,
            fontWeight: semiBold,
          ),
        ),

        const SizedBox(height: 14),

        // Recent Book Container
        InkWell(
          onTap: (){
            Get.toNamed('/detail', arguments: book.id.toString());
          },

          child: RecentBookCardCustom(
            bookTitle: book.title.toString(),
            bookDescription: book.description.toString(),
          ),
        ),
      ],
    );
  }

  Widget moreDialog(){
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      alignment: Alignment.center,

      content: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 180,

        decoration: BoxDecoration(
          color: lightBackgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Text
            Text(
              'Do you want to Logout?',
              style: blackTextStyle.copyWith(
                  fontSize: 22,
                  fontWeight: semiBold
              ),
            ),

            const SizedBox(height: 10),

            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },

              child: Text(
                'No',
                style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium
                ),
              ),
            ),

            const SizedBox(height: 14),

            GestureDetector(
              onTap: (){
                Get.back();
                logout();
              },

              child: const SmallButtonCustom(paddingX: 18, paddingY: 8, label: 'Yes', customFontSize: 16),
            ),

          ],
        ),
      ),
    );
  }
}

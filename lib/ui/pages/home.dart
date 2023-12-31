import 'package:bukuku/controllers/home_controller.dart';
import 'package:bukuku/shared/values.dart';
import 'package:bukuku/ui/widgets/button_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../shared/theme.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeStateController = Get.put(HomeController());

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

            if(userDataResponse != null && listBookResponse != null){
              return SafeArea(
                child: listBookResponse.total != 0

                    ? // If There is book data
                ListView(
                  padding: const EdgeInsets.all(22),
                  children: [

                    // Profile Section
                    profileSection(userDataResponse.name.toString()),

                  ],
                )
                    : // If no Book data
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'There is Currently No Data\nStart Track Your Reading',
                        textAlign: TextAlign.center,
                        style: blackTextStyle.copyWith(
                          fontSize: 20,
                          fontWeight: semiBold
                        ),
                      ),

                      const SizedBox(height: 20),

                      FilledButtonCustom(
                          width: 200,
                          height: 50,
                          label: 'Continue',
                          onTap: (){
                            Get.toNamed('/addBook');
                          }
                      )
                    ],
                  ),
                ),
              );
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
            Container(
              width: 250,
              child: Text(
                'Hello $username',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: greyTextStyle.copyWith(
                    fontSize: 17,
                    fontWeight: regular
                ),
              ),
            ),

            Text(
              "Let's Discover",
              style: blackTextStyle.copyWith(
                  fontSize: 28,
                  fontWeight: semiBold
              ),
            ),
          ],
        ),

        // Profile
        GestureDetector(
          onTap: (){

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
}
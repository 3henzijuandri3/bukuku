import 'dart:math';

import 'package:flutter/material.dart';

import '../../shared/theme.dart';
import '../../shared/values.dart';

class LatestCardCustom extends StatelessWidget {
  final String author;
  final String title;

  const LatestCardCustom({super.key, required this.author, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // Book Image
          const BookImageCard(width: 120, height: 150),

          const SizedBox(height: 6),

          SizedBox(
            width: 120,
            child: Text(
              author,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: greyTextStyle.copyWith(
                  fontSize: 15,
                  fontWeight: medium
              ),
            ),
          ),

          SizedBox(
            width: 120,
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: blackTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: medium
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RecentBookCardCustom extends StatelessWidget {
  final String bookTitle;
  final String bookDescription;

  const RecentBookCardCustom({super.key, required this.bookTitle, required this.bookDescription});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.09), // Adjust opacity for a more subtle effect
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Book Image
          const BookImageCard(width: 90, height: 110),

          const SizedBox(width: 14),

          // Book Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Book Title
                Text(
                  bookTitle,
                  style: blackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold
                  ),
                ),

                const SizedBox(height: 6),

                // Book Description
                Text(
                  bookDescription,
                  textAlign: TextAlign.justify,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  style: blackTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: regular
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class BookImageCard extends StatelessWidget {
  final double width;
  final double height;

  const BookImageCard({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,

      decoration: BoxDecoration(
          color: Colors.red,
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(bookCovers[Random().nextInt(4)]),
          )
      ),
    );
  }
}

class DetailBookImageCard extends StatelessWidget {
  final double width;
  final double height;
  final String bookTitle;

  const DetailBookImageCard({super.key, required this.width, required this.height, required this.bookTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,

      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),

          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(bookCovers[Random().nextInt(4)]),
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.35),
                  BlendMode.multiply
              )
          ),
      ),

      child: Center(
        child: Text(
          bookTitle,
          textAlign: TextAlign.center,
          maxLines: 6,
          overflow: TextOverflow.ellipsis,
          style: whiteTextStyle.copyWith(
            fontSize: 18,
            fontWeight: semiBold
          ),
        ),
      ),
    );
  }
}

class AllCardCustom extends StatelessWidget {
  final String bookTitle;
  final String author;
  final double height;

  const AllCardCustom({
    super.key,
    required this.bookTitle,
    required this.author,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Book Image
        Container(
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(bookCovers[Random().nextInt(4)]),
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.35),
                    BlendMode.multiply
                )
            ),
          ),

          child: Center(
            child: Text(
              bookTitle,
              textAlign: TextAlign.center,
              maxLines: 6,
              overflow: TextOverflow.ellipsis,
              style: whiteTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: semiBold
              ),
            ),
          ),
        ),

        const SizedBox(height: 6),

        // Book Author
        Text(
          author,
          textAlign: TextAlign.center,
          maxLines: 1,
          style: blackTextStyle.copyWith(
            fontSize: 16,
            fontWeight: semiBold
          ),
        )
      ],
    );
  }
}
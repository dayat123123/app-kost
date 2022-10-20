// ignore_for_file: unnecessary_string_interpolations, unnecessary_const

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:real_sokost/rating_item.dart';
import 'theme.dart';

class DetailKost extends StatefulWidget {
  final String id;
  final String name;
  final String imageUrl;
  final String price;
  final String city;
  final String country;
  final String rating;
  final String address;
  final String phone;
  final String mapUrl;
  final String photos;
  final String status;
  final String numberOfKitchens;
  final String numberOfBedrooms;
  final String numberOfCupboards;
  const DetailKost(
      {Key key,
      this.id,
      this.name,
      this.imageUrl,
      this.price,
      this.city,
      this.country,
      this.rating,
      this.address,
      this.phone,
      this.mapUrl,
      this.photos,
      this.status,
      this.numberOfBedrooms,
      this.numberOfKitchens,
      this.numberOfCupboards})
      : super(key: key);

  @override
  State<DetailKost> createState() => _DetailKostState();
}

class _DetailKostState extends State<DetailKost> {
  @override
  Widget build(BuildContext context) {
    var ratingbase = widget.rating;
    var rating_akhir = double.tryParse(ratingbase);
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0.0,
      //   centerTitle: true,
      //   leading: IconButton(
      //     icon: const Icon(
      //       Icons.arrow_back,
      //       color: Colors.black,
      //     ),
      //     onPressed: () {
      //       Navigator.of(context).pop();
      //     },
      //   ),
      //   title: Text(
      //     'Detail Page',
      //     style: blackTextStyle.copyWith(fontSize: 22),
      //   ),
      // ),
      backgroundColor: whiteColor,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Image.asset(
              'assets/${widget.imageUrl}',
              width: MediaQuery.of(context).size.width,
              height: 350,
              fit: BoxFit.cover,
            ),
            ListView(
              children: [
                const SizedBox(
                  height: 328,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    color: Color(0xffFFFFFF),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: edge,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.name,
                                  style: blackTextStyle.copyWith(
                                    fontSize: 22,
                                  ),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Text.rich(
                                  TextSpan(
                                    text: 'Rp. ${widget.price}',
                                    style: purpleTextStyle.copyWith(
                                      fontSize: 16,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: ' / bulan',
                                        style: greyTextStyle.copyWith(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [1, 2, 3, 4, 5].map((index) {
                                return Container(
                                  // ignore: prefer_const_constructors
                                  margin: EdgeInsets.only(
                                    left: 2,
                                  ),
                                  child: RatingItem(
                                    index: index,
                                    rating: rating_akhir,
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      // NOTE: MAIN FACILITIES
                      Padding(
                        padding: EdgeInsets.only(left: edge),
                        child: Text(
                          'Fasilitas Utama',
                          style: regularTextStyle.copyWith(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: edge),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  'assets/${widget.imageUrl}',
                                  width: 50,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text.rich(
                                  TextSpan(
                                    text: '${widget.name}',
                                    style: purpleTextStyle.copyWith(
                                      fontSize: 14,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: ' ${widget.name}',
                                        style: greyTextStyle.copyWith(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

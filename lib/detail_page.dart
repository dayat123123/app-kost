// ignore_for_file: unnecessary_string_interpolations, unnecessary_const, deprecated_member_use

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:real_sokost/rating_item.dart';
import 'facility_item.dart';
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
    var nobdbase = widget.numberOfBedrooms;
    var nobd_akhir = int.parse(nobdbase);
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
                      top: Radius.circular(50),
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
                                    fontSize: 18,
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
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      widget.rating,
                                      style:
                                          blackTextStyle.copyWith(fontSize: 13),
                                    ),
                                    Text(
                                      " (188)",
                                      style:
                                          greyTextStyle.copyWith(fontSize: 12),
                                    )
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
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
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
                        height: 8,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: edge),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FacilityItem(
                              name: 'kitchen',
                              imageUrl: 'assets/icon_kitchen.png',
                              total: nobd_akhir,
                            ),
                            FacilityItem(
                              name: 'bedroom',
                              imageUrl: 'assets/icon_bedroom.png',
                              total: nobd_akhir,
                            ),
                            FacilityItem(
                              name: 'Lemari',
                              imageUrl: 'assets/icon_cupboard.png',
                              total: nobd_akhir,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: edge),
                        child: Text(
                          'Photo',
                          style: regularTextStyle.copyWith(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      SizedBox(
                        height: 88,
                        child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              Container(
                                // ignore: prefer_const_constructors
                                margin: EdgeInsets.only(
                                  left: 24,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.asset(
                                    "assets/photo1.png",
                                    width: 110,
                                    height: 88,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            ]),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: edge),
                        child: Text(
                          'Lokasi',
                          style: regularTextStyle.copyWith(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: edge),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${widget.address}\n${widget.city}',
                              style: greyTextStyle,
                            ),
                            InkWell(
                              onTap: () {
                                // // launchUrl(
                                // //     'https://goo.gl/maps/SyZx2yjWB1yR6AeH8');

                                // launchUrl(widget.mapUrl);
                              },
                              child: Image.asset(
                                'assets/btn_map.png',
                                width: 40,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: edge,
                        ),
                        height: 45,
                        width: MediaQuery.of(context).size.width - (2 * edge),
                        child: FlatButton(
                          onPressed: () {
                            // handleBook(widget.space);
                          },
                          color: purpleColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17),
                          ),
                          child: Text(
                            'Book Now',
                            style: whiteTextStyle.copyWith(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: edge,
                vertical: 30,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      'assets/btn_back.png',
                      width: 40,
                    ),
                  ),
                  // Image.asset(
                  //   'assets/btn_wishlist.png',
                  //   width: 40,
                  // ),
                  if (widget.status == "1")
                    InkWell(
                      onTap: () {
                        print("Ini aktiv");
                      },
                      child: Image.asset(
                        'assets/btn_wishlist_active.png',
                        width: 40,
                      ),
                    ),
                  if (widget.status != "1")
                    InkWell(
                      onTap: () {
                        print("ini tidak aktiv");
                      },
                      child: Image.asset(
                        'assets/btn_wishlist.png',
                        width: 40,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

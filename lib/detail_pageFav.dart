// ignore_for_file: unnecessary_string_interpolations, unnecessary_const, deprecated_member_use, non_constant_identifier_names, avoid_unnecessary_containers, unused_local_variable, avoid_print, missing_required_param, file_names

// import 'dart:ffi';
import 'dart:convert';

// import 'package:get/get.dart';
// import 'package:map_launcher/map_launcher.dart';
import 'package:flutter/material.dart';
import 'package:real_sokost/favorite.dart';
import 'package:real_sokost/homepage.dart';
import 'package:real_sokost/rating_item.dart';
import 'package:url_launcher/url_launcher.dart';
import 'facility_item.dart';
import 'package:rating_bar/rating_bar.dart';
import 'theme.dart';
import 'package:flutter_launch/flutter_launch.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DetailKostFav extends StatefulWidget {
  final String id;
  final String id_favorit;
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
  const DetailKostFav(
      {Key key,
      this.id,
      this.id_favorit,
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
  State<DetailKostFav> createState() => _DetailKostFavState();
}

class _DetailKostFavState extends State<DetailKostFav> {
  _showAlertDialog(BuildContext context) {
    Widget okButton = FlatButton(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text(
                "Batal",
                style: blackTextStyle.copyWith(fontSize: 15),
              )),
          InkWell(
              onTap: () {
                _deleteFav();
              },
              child: Text(
                "OK",
                style: blackTextStyle.copyWith(fontSize: 15),
              )),
        ],
      ),
    );
    AlertDialog alert = AlertDialog(
      title: Text(
        "Hapus Dari Favorit",
        style: blackTextStyle.copyWith(fontSize: 18),
      ),
      content: Row(
        children: [
          Image.asset(
            'assets/${widget.imageUrl}',
            height: 50,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            widget.name,
            style: blackTextStyle.copyWith(fontSize: 15),
          ),
          // Text(
          //   "/ Rp.${widget.price}",
          //   style: TextStyle(color: purpleColor),
          // ),
        ],
      ),
      actions: [
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  // batas

  // batas bawah

  _deleteFav() async {
    const String sUrl = "http://sofiaal.slkbankum.com/api/deleteFavorit.php";
    final prefs = await SharedPreferences.getInstance();
    var params = "?id_favorit=" + widget.id_favorit;

    try {
      var res = await http.get(Uri.parse(sUrl + params));
      if (res.statusCode == 200) {
        var response = json.decode(res.body);
        if (response['response_status'] == "OK") {
          prefs.setBool('slogin', true);
          Widget okButton = FlatButton(
            child: Text(
              "OK",
              style: blackTextStyle.copyWith(fontSize: 20),
            ),
            onPressed: () => Navigator.of(context, rootNavigator: true)
                .pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const FavPage()),
                    (Route<dynamic> route) => false),
          );
          AlertDialog alert = AlertDialog(
            title: Text(
              "Notifikasi",
              style: blackTextStyle.copyWith(fontSize: 18),
            ),
            content: Text(
              "Data ${widget.name} berhasil di hapus dari Favorit",
              style: greyTextStyle.copyWith(fontSize: 14),
            ),
            actions: [
              okButton,
            ],
          );
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return alert;
            },
          );
        } else {
          print("Gagal");
          // _showAlertDialog(context, response['response_message']);
        }
      }
    } catch (e) {
      print("gaagal");
    }
  }
  // batas dialog

  // openMapsSheet(context) async {
  //   try {
  //     var latitude = 37.759392;
  //     var coords = Coords(latitude, -122.5107336);
  //     final title = "${widget.name}";
  //     final availableMaps = await MapLauncher.installedMaps;

  //     showModalBottomSheet(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return SafeArea(
  //           child: SingleChildScrollView(
  //             child: Container(
  //               child: Wrap(
  //                 children: <Widget>[
  //                   for (var map in availableMaps)
  //                     ListTile(
  //                       onTap: () => map.showMarker(
  //                         coords: coords,
  //                         title: title,
  //                       ),
  //                       title: Text(map.mapName),
  //                       leading: Image.asset(
  //                         'assets/city1.png',
  //                         height: 30.0,
  //                         width: 30.0,
  //                       ),
  //                     ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         );
  //       },
  //     );
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  void googleMapada() async {
    String googleUrl =
        "https://www.google.com/maps/search/?api=1&query=${widget.address}";
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw ("Could't open google maps");
    }
  }

  @override
  Widget build(BuildContext context) {
    var ratingbase = widget.rating;
    var rating_akhir = double.tryParse(ratingbase);
    var nobdbase = widget.numberOfBedrooms;
    var nobd_akhir = int.parse(nobdbase);
    return Scaffold(
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
                  height: 300,
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
                                  // children: [1, 2, 3, 4, 5].map((index) {
                                  //   return Container(
                                  //     // ignore: prefer_const_constructors
                                  //     margin: EdgeInsets.only(
                                  //       left: 2,
                                  //     ),
                                  //     child: RatingItem(
                                  //       index: index,
                                  //       rating: rating_akhir,
                                  //     ),
                                  //   );
                                  // }).toList(),
                                  children: [
                                    RatingBar.readOnly(
                                      initialRating: rating_akhir,
                                      isHalfAllowed: true,
                                      halfFilledIcon: Icons.star_half,
                                      filledIcon: Icons.star,
                                      emptyIcon: Icons.star_border,
                                      size: 18,
                                      filledColor: const Color.fromARGB(
                                          255, 252, 109, 37),
                                    ),
                                  ],
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
                                googleMapada();
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
                          onPressed: () async {
                            await FlutterLaunch.launchWhatsapp(
                              phone: '6282388623670',
                              message:
                                  'Hi ${widget.id},Saya mau order ${widget.name} untuk hari ini, apakah tersedia?',
                            );
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

                  InkWell(
                    onTap: () {
                      _showAlertDialog(context);
                    },
                    child: Image.asset(
                      'assets/btn_wishlist_active.png',
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

import 'package:flutter/material.dart';
import 'package:real_sokost/detail_pageFav.dart';
import 'package:real_sokost/profil_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'button_navbar_item.dart';
// import 'detail_page.dart';
import 'fav_space.dart';
import 'homepage.dart';
// import 'space.dart';
import 'theme.dart';
import 'package:http/http.dart' as http;

class FavPage extends StatefulWidget {
  const FavPage({Key key}) : super(key: key);
  @override
  State<FavPage> createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
  Future<List<FavSpace>> getFav() async {
    final response = await http
        .get(Uri.parse('http://sofiaal.slkbankum.com/api/list_favkost.php'));

    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse
          .map((data) => FavSpace.fromJson(data))
          .where((data) => data.id_user == id_user)
          .toList();
    } else {
      throw Exception("Failed to load data");
    }
  }

  bool slogin = false;
  String id_user = "";
  String username = "";
  _cekLogin() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      slogin = prefs.getBool('slogin') ?? false;
      username = prefs.getString('username') ?? "";
      id_user = prefs.getString('id_user') ?? "";
      print("ID Login : ${id_user}");
    });
  }

  @override
  void initState() {
    super.initState();
    _cekLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        bottom: false,
        child: ListView(
          children: [
            SizedBox(
              height: edge,
            ),
            Padding(
              padding: EdgeInsets.only(left: edge),
              child: Text(
                'Wish List',
                style: blackTextStyle.copyWith(fontSize: 24),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(left: edge),
              child: Text(
                'List Kost',
                style: regularTextStyle.copyWith(
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            FutureBuilder(
                future: getFav(),
                builder: (context, data) {
                  if (data.hasError) {
                    return Text("${data.hasError}");
                  } else if (data.hasData) {
                    var isiData = data.data as List<FavSpace>;
                    return Scrollbar(
                      child: ListView.builder(
                        // controller: _scroll,
                        shrinkWrap: true,
                        itemCount: isiData.length,
                        itemBuilder: (context, index) {
                          return _buildCard(isiData[index], context);
                        },
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                })
          ],
        ),
      ),
      floatingActionButton: Container(
        height: 65,
        width: MediaQuery.of(context).size.width - (2 * edge),
        margin: EdgeInsets.symmetric(
          horizontal: edge,
        ),
        decoration: BoxDecoration(
          color: const Color(0xffF6F7F8),
          borderRadius: BorderRadius.circular(23),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const HomePage()));
              },
              child: BottomNavbarItem(
                imageUrl: 'assets/home (1).png',
                isActive: false,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const FavPage()));
              },
              child: BottomNavbarItem(
                imageUrl: 'assets/love (1).png',
                isActive: true,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ProfilPage()));
              },
              child: BottomNavbarItem(
                imageUrl: 'assets/user (1).png',
                isActive: false,
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildCard(
    FavSpace space,
    context,
  ) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return DetailKostFav(
                id: space.id_kost,
                id_favorit: space.id_favorit,
                name: space.name,
                imageUrl: space.imageUrl,
                price: space.price,
                city: space.city,
                country: space.country,
                rating: space.rating,
                address: space.address,
                phone: space.phone,
                mapUrl: space.mapUrl,
                photos: space.photos,
                status: space.status,
                numberOfKitchens: space.numberOfKitchens,
                numberOfBedrooms: space.numberOfBedrooms,
                numberOfCupboards: space.numberOfCupboards,
              );
            }));
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: edge),
            child: Column(
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Image.asset(
                                'assets/${space.imageUrl}',
                                width: 90,
                              ),
                              if (space.status == "Cowok")
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    width: 50,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: purpleColor,
                                      borderRadius: const BorderRadius.only(
                                        // ignore: unnecessary_const
                                        bottomRight: Radius.circular(36),
                                      ),
                                    ),
                                    child: Center(
                                      child: Image.asset(
                                        'assets/ml.png',
                                        height: 23,
                                        width: 35,
                                      ),
                                    ),
                                  ),
                                ),
                              if (space.status == "Cewek")
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    width: 50,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: purpleColor,
                                      borderRadius: const BorderRadius.only(
                                        // ignore: unnecessary_const
                                        bottomRight: Radius.circular(36),
                                      ),
                                    ),
                                    child: Center(
                                      child: Image.asset(
                                        'assets/woman12.png',
                                        height: 23,
                                        width: 35,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(
                            height: 31,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          space.name,
                          style: blackTextStyle.copyWith(fontSize: 14),
                        ),
                        const SizedBox(
                          height: 1.5,
                        ),
                        Text(
                          "Rp. ${space.price}",
                          style: greyTextStyle.copyWith(fontSize: 13),
                        ),
                        Text(
                          "Rating : ${space.rating}",
                          style: greyTextStyle.copyWith(fontSize: 13),
                        ),
                        Text(
                          space.address,
                          style: greyTextStyle.copyWith(fontSize: 13),
                        ),
                        // Text(
                        //   "Gender : ${space.id}",
                        //   style: greyTextStyle.copyWith(fontSize: 13),
                        // ),
                        const SizedBox(height: 30)
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return DetailKostFav(
                              id: space.id_kost,
                              id_favorit: space.id_favorit,
                              name: space.name,
                              imageUrl: space.imageUrl,
                              price: space.price,
                              city: space.city,
                              country: space.country,
                              rating: space.rating,
                              address: space.address,
                              phone: space.phone,
                              mapUrl: space.mapUrl,
                              photos: space.photos,
                              status: space.status,
                              numberOfKitchens: space.numberOfKitchens,
                              numberOfBedrooms: space.numberOfBedrooms,
                              numberOfCupboards: space.numberOfCupboards,
                            );
                          }));
                        },
                        icon: Icon(
                          Icons.chevron_right,
                          color: greyColor,
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

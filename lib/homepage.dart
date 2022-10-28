// ignore_for_file: unnecessary_string_interpolations

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:rating_bar/rating_bar.dart';
import 'button_navbar_item.dart';
import 'detail_page.dart';
import 'fav_space.dart';
import 'favorite.dart';
import 'kost_based_kecamatan.dart';
import 'space.dart';
import 'theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List kecamatan;
  bool loading = true;
  getkecamatan() async {
    final response = await http
        .get(Uri.parse('http://sofiaal.slkbankum.com/api/kecamatan.php'));
    if (response.statusCode == 200) {
      setState(() {
        kecamatan = jsonDecode(response.body);
        loading = false;
      });
    } else {
      throw Exception("Failed to load data");
    }
  }

  // Future<List<FavSpace>> getFav() async {
  //   final response = await http
  //       .get(Uri.parse('http://sofiaal.slkbankum.com/api/list_favkost.php'));

  //   if (response.statusCode == 200) {
  //     List jsonResponse = jsonDecode(response.body);

  //     return jsonResponse
  //         .map((data) => FavSpace.fromJson(data))
  //         .where((data) => data.id_user == '1')
  //         .toList();
  //   } else {
  //     throw Exception("Failed to load data");
  //   }
  // }

  @override
  void initState() {
    super.initState();
    getkecamatan();
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController _scroll = ScrollController();
    Future<List<Space>> getPopular() async {
      final response = await http
          .get(Uri.parse('http://sofiaal.slkbankum.com/api/list_kost.php'));

      if (response.statusCode == 200) {
        List jsonResponse = jsonDecode(response.body);
        return jsonResponse.map((data) => Space.fromJson(data)).toList();
      } else {
        throw Exception("Failed to load data");
      }
    }

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
                'Explore Now',
                style: blackTextStyle.copyWith(fontSize: 24),
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Padding(
              padding: EdgeInsets.only(left: edge),
              child: Text(
                'Kecamatan',
                style: regularTextStyle.copyWith(fontSize: 16),
              ),
            ),
            // ignore: prefer_const_constructors
            SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 170,
              child: ListView(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const SizedBox(
                    width: 24,
                  ),
                  loading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 3),
                          child: SizedBox(
                            height: 165,
                            child: ListView.builder(
                              itemCount:
                                  kecamatan == null ? 0 : kecamatan.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return KostBasedKecamatan(
                                          id: kecamatan[index]["id"],
                                          name: kecamatan[index]["name"],
                                          imageUrl: kecamatan[index]
                                              ["imageUrl"],
                                          city: kecamatan[index]["city"]);
                                    }));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(18),
                                      child: Container(
                                        height: 150,
                                        width: 120,
                                        color: const Color(0xffF6F7F8),
                                        child: Column(
                                          children: [
                                            Stack(
                                              children: [
                                                Image.asset(
                                                    'assets/${kecamatan[index]["imageUrl"]}'),
                                                if (kecamatan[index]
                                                        ["isPopular"] ==
                                                    "true")
                                                  Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: Container(
                                                      width: 50,
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                        color: purpleColor,
                                                        borderRadius:
                                                            const BorderRadius
                                                                .only(
                                                          // ignore: unnecessary_const
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  36),
                                                        ),
                                                      ),
                                                      child: Center(
                                                        child: Image.asset(
                                                            'assets/icon_star.png'),
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 11,
                                            ),
                                            Text(
                                              '${kecamatan[index]["name"]}',
                                              style: blackTextStyle.copyWith(
                                                  fontSize: 16),
                                            ),
                                            Text(
                                              '150 kos',
                                              style: greyTextStyle.copyWith(
                                                  fontSize: 16),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                  const SizedBox(
                    width: 10,
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
                'Popular',
                style: regularTextStyle.copyWith(
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            FutureBuilder(
              future: getPopular(),
              builder: (context, data) {
                if (data.hasError) {
                  return Text("${data.hasError}");
                } else if (data.hasData) {
                  var isiData = data.data as List<Space>;
                  return Scrollbar(
                    child: ListView.builder(
                      controller: _scroll,
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
              },
            ),
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
                imageUrl: 'assets/icon_home.png',
                isActive: true,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const FavPage()));
              },
              child: BottomNavbarItem(
                imageUrl: 'assets/icon_love.png',
                isActive: false,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const HomePage()));
              },
              child: BottomNavbarItem(
                imageUrl: 'assets/icon_email.png',
                isActive: false,
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  // widget nya
  Widget _buildCard(
    Space space,
    context,
  ) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return DetailKost(
                id: space.id,
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
                                    // ignore: prefer_const_constructors
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: const BorderRadius.only(
                                        // ignore: unnecessary_const
                                        bottomRight: Radius.circular(16),
                                      ),
                                    ),
                                    child: Center(
                                      child: Image.asset(
                                        'assets/ml.png',
                                        height: 23,
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
                                        bottomRight: Radius.circular(16),
                                      ),
                                    ),
                                    child: Center(
                                      child: Image.asset(
                                        'assets/woman12.png',
                                        height: 23,
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
                        RatingBar.readOnly(
                          initialRating: double.parse(space.rating),
                          isHalfAllowed: true,
                          halfFilledIcon: Icons.star_half,
                          filledIcon: Icons.star,
                          emptyIcon: Icons.star_border,
                          size: 16,
                          filledColor: const Color.fromARGB(255, 252, 109, 37),
                        ),
                        Text(
                          "${space.city}",
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
                            return DetailKost(
                              id: space.id,
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

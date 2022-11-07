// ignore_for_file: avoid_function_literals_in_foreach_calls, unnecessary_new, curly_braces_in_flow_control_structures, prefer_void_to_null

import 'detail_page.dart';
import 'theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'space.dart';
// import 'theme.dart';
import 'constants.dart';
import 'package:rating_bar/rating_bar.dart';

class KostBasedKecamatan extends StatefulWidget {
  final String id;
  final String name;
  final String imageUrl;
  final String city;
  const KostBasedKecamatan(
      {Key key, this.id, this.name, this.imageUrl, this.city})
      : super(key: key);
  @override
  State<KostBasedKecamatan> createState() => _KostBasedKecamatanState();
}

Future<SharedPreferences> preferences = SharedPreferences.getInstance();

class _KostBasedKecamatanState extends State<KostBasedKecamatan> {
  final List<Space> _list = [];
  final List<Space> _search = [];
  var loading = false;
  Future<Null> fetchData() async {
    setState(() {
      loading = true;
    });
    _list.clear();
    var url = 'http://sofiaal.slkbankum.com/api/list_kost.php';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data2 = json.decode(response.body);
      final data = data2.where((data2) => data2['id'] == widget.id);

      setState(() {
        for (var u in data) {
          _list.add(Space.fromJson(u));
          loading = false;
        }
      });
    }
  }

  final TextEditingController controller = new TextEditingController();
  onSearch(String text) async {
    _search.clear();
    if (text.isEmpty) {
      setState(() {
        return;
      });
    }
    _list.forEach((f) {
      if (f.name.contains(text) || f.id.toString().contains(text))
        _search.add(f);
    });
    setState(() {});
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Size size = MediaQuery.of(context).size;
    // ignore: unused_local_variable
    final ScrollController _scroll = ScrollController();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: edge),
              child: Text(
                'List Kost',
                style: blackTextStyle.copyWith(fontSize: 24),
              ),
            ),
            // ignore: prefer_const_constructors
            SizedBox(
              height: 6,
            ),

            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                height: 54,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 10),
                      blurRadius: 50,
                      color: kPrimaryColor.withOpacity(0.23),
                    ),
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Cari kost di ${widget.name}",
                    hintStyle: TextStyle(
                      color: kPrimaryColor.withOpacity(0.5),
                    ),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  onChanged: onSearch,
                  controller: controller,
                  maxLines: 1,
                  textInputAction: TextInputAction.done,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: EdgeInsets.only(left: edge),
              child: Text(
                'List Kost ${widget.name}',
                style: regularTextStyle.copyWith(
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
              child: SizedBox(
                height: Get.height,
                child: loading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    // ignore: prefer_is_empty
                    : _search.length != 0 || controller.text.isNotEmpty
                        ? ListView.builder(
                            controller: _scroll,
                            itemCount: _search.length,
                            itemBuilder: (context, index) {
                              final b = _search[index];
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return DetailKost(
                                      id: b.id,
                                      name: b.name,
                                      imageUrl: b.imageUrl,
                                      price: b.price,
                                      city: b.city,
                                      country: b.country,
                                      rating: b.rating,
                                      address: b.address,
                                      phone: b.phone,
                                      mapUrl: b.mapUrl,
                                      photos: b.photos,
                                      status: b.status,
                                      numberOfKitchens: b.numberOfKitchens,
                                      numberOfBedrooms: b.numberOfBedrooms,
                                      numberOfCupboards: b.numberOfCupboards,
                                    );
                                  }));
                                },
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: edge),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 20),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(18),
                                              child: Column(
                                                children: [
                                                  Stack(
                                                    children: [
                                                      Image.asset(
                                                        'assets/${b.imageUrl}',
                                                        width: 90,
                                                      ),
                                                      if (b.status == "Cowok")
                                                        Align(
                                                          alignment: Alignment
                                                              .topRight,
                                                          child: Container(
                                                            width: 50,
                                                            height: 30,
                                                            // ignore: prefer_const_constructors
                                                            decoration:
                                                                const BoxDecoration(
                                                              color:
                                                                  Colors.black,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .only(
                                                                // ignore: unnecessary_const
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            16),
                                                              ),
                                                            ),
                                                            child: Center(
                                                              child:
                                                                  Image.asset(
                                                                'assets/ml.png',
                                                                height: 23,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      if (b.status == "Cewek")
                                                        Align(
                                                          alignment: Alignment
                                                              .topRight,
                                                          child: Container(
                                                            width: 50,
                                                            height: 30,
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  purpleColor,
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .only(
                                                                // ignore: unnecessary_const
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            16),
                                                              ),
                                                            ),
                                                            child: Center(
                                                              child:
                                                                  Image.asset(
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
                                          ),
                                          const SizedBox(
                                            width: 24,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                b.name,
                                                style: blackTextStyle.copyWith(
                                                    fontSize: 16),
                                              ),
                                              const SizedBox(
                                                height: 2.5,
                                              ),
                                              Text(
                                                "Rp. ${b.price}",
                                                style: greyTextStyle.copyWith(
                                                    fontSize: 13),
                                              ),
                                              RatingBar.readOnly(
                                                initialRating:
                                                    double.parse(b.rating),
                                                isHalfAllowed: true,
                                                halfFilledIcon: Icons.star_half,
                                                filledIcon: Icons.star,
                                                emptyIcon: Icons.star_border,
                                                size: 16,
                                                filledColor:
                                                    const Color.fromARGB(
                                                        255, 252, 109, 37),
                                              ),
                                              Text(
                                                b.address,
                                                style: greyTextStyle.copyWith(
                                                    fontSize: 13),
                                              ),
                                              const SizedBox(height: 10)
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            })
                        : ListView.builder(
                            controller: _scroll,
                            itemCount: _list.length,
                            itemBuilder: (context, index) {
                              final a = _list[index];
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return DetailKost(
                                      id: a.id,
                                      name: a.name,
                                      imageUrl: a.imageUrl,
                                      price: a.price,
                                      city: a.city,
                                      country: a.country,
                                      rating: a.rating,
                                      address: a.address,
                                      phone: a.phone,
                                      mapUrl: a.mapUrl,
                                      photos: a.photos,
                                      status: a.status,
                                      numberOfKitchens: a.numberOfKitchens,
                                      numberOfBedrooms: a.numberOfBedrooms,
                                      numberOfCupboards: a.numberOfCupboards,
                                    );
                                  }));
                                },
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: edge),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 20),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(18),
                                              child: Column(
                                                children: [
                                                  Stack(
                                                    children: [
                                                      Image.asset(
                                                        'assets/${a.imageUrl}',
                                                        width: 90,
                                                      ),
                                                      if (a.status == "Cowok")
                                                        Align(
                                                          alignment: Alignment
                                                              .topRight,
                                                          child: Container(
                                                            width: 50,
                                                            height: 30,
                                                            // ignore: prefer_const_constructors
                                                            decoration:
                                                                const BoxDecoration(
                                                              color:
                                                                  Colors.black,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .only(
                                                                // ignore: unnecessary_const
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            16),
                                                              ),
                                                            ),
                                                            child: Center(
                                                              child:
                                                                  Image.asset(
                                                                'assets/ml.png',
                                                                height: 23,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      if (a.status == "Cewek")
                                                        Align(
                                                          alignment: Alignment
                                                              .topRight,
                                                          child: Container(
                                                            width: 50,
                                                            height: 30,
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  purpleColor,
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .only(
                                                                // ignore: unnecessary_const
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            16),
                                                              ),
                                                            ),
                                                            child: Center(
                                                              child:
                                                                  Image.asset(
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
                                          ),
                                          const SizedBox(
                                            width: 24,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                a.name,
                                                style: blackTextStyle.copyWith(
                                                    fontSize: 16),
                                              ),
                                              const SizedBox(
                                                height: 2.5,
                                              ),
                                              Text(
                                                "Rp. ${a.price}",
                                                style: greyTextStyle.copyWith(
                                                    fontSize: 13),
                                              ),
                                              RatingBar.readOnly(
                                                initialRating:
                                                    double.parse(a.rating),
                                                isHalfAllowed: true,
                                                halfFilledIcon: Icons.star_half,
                                                filledIcon: Icons.star,
                                                emptyIcon: Icons.star_border,
                                                size: 16,
                                                filledColor:
                                                    const Color.fromARGB(
                                                        255, 252, 109, 37),
                                              ),
                                              Text(
                                                a.address,
                                                style: greyTextStyle.copyWith(
                                                    fontSize: 13),
                                              ),
                                              const SizedBox(height: 10)
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
              ),
            ),

            // batas header
          ],
        ),
      ),
    );
  }
}

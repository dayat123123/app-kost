import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:real_sokost/admin_page/kostdetailadm.dart';
import 'package:real_sokost/admin_page/tambahdata.dart';
import 'package:real_sokost/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../button_navbar_item.dart';
import '../space.dart';
import 'package:http/http.dart' as http;
// import '../favorite.dart';
// import '../homepage.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({Key key}) : super(key: key);

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  bool slogin = false;
  String id_user = "";
  String username = "";
  String email = "";
  String nohp = "";
  String password = "";
  String nama = "";
  _cekLogin() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      slogin = prefs.getBool('slogin') ?? false;
      username = prefs.getString('username') ?? "";
      id_user = prefs.getString('id_user') ?? "";
      email = prefs.getString('email') ?? "";
      password = prefs.getString('password') ?? "";
      nohp = prefs.getString('nohp') ?? "";
      nama = prefs.getString('nama') ?? "";
      print(nama);
      print(nohp);
      print(email);
      print(username);
      print(id_user);
      print(password);
    });
  }

  void initState() {
    super.initState();
    _cekLogin();
  }

  Future<List<Space>> getDataMakanan() async {
    final response = await http
        .get(Uri.parse('http://sofiaal.slkbankum.com/api/list_kost.php'));

    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse
          .map((data) => Space.fromJson(data))
          .where((o) => o.id_user == id_user)
          .toList();
    } else {
      throw Exception("Failed to load data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Welcome Admin",
            style: blackTextStyle.copyWith(fontSize: 20),
          ),
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder(
          future: getDataMakanan(),
          builder: (context, data) {
            if (data.hasError) {
              return Text("${data.hasError}");
            } else if (data.hasData) {
              var isiData = data.data as List<Space>;
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 3,
                  childAspectRatio: 0.7,
                ),
                // controller: _scroll,
                itemCount: isiData.length,
                itemBuilder: (context, index) {
                  return _buildCard(isiData[index], context);
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
      // batas floating menu
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
                    MaterialPageRoute(builder: (context) => const HomeAdmin()));
              },
              child: BottomNavbarItem(
                imageUrl: 'assets/home.png',
                isActive: true,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return TambahData(
                    id: id_user,
                    nowa: nohp,
                  );
                }));
              },
              child: BottomNavbarItem(
                imageUrl: 'assets/home.png',
                isActive: false,
              ),
            ),
            InkWell(
              onTap: () {
                // Navigator.of(context)
                //     .push(MaterialPageRoute(builder: (context) {
                //   return ProfilPage(
                //     id_user: id_user,
                //     name: nama,
                //     username: username,
                //     password: password,
                //     nohp: nohp,
                //     email: email,
                //   );
                // }));
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
    Space space,
    context,
  ) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return KostDetailA(
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
              status: space.status,
              numberOfBedrooms: space.numberOfBedrooms,
              numberOfCupboards: space.numberOfCupboards,
              numberOfKitchens: space.numberOfKitchens,
            );
          }));
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 3.0,
                blurRadius: 5.0,
              )
            ],
            color: Colors.white,
          ),
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.only(
                  right: 8,
                  top: 8,
                ),
              ),
              // if (makanan.foto != "")
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: NetworkImage(
                        "http://sofiaal.slkbankum.com/api/image/${space.imageUrl}"),
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: const Color(0xFFEBEBEB),
                  height: 1.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Text(
                              '${space.name}',
                              style: const TextStyle(
                                  fontFamily: 'Varela',
                                  color: const Color(0xFFD17E50),
                                  fontSize: 13),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Text(
                              'Rp. ${space.price}',
                              style: const TextStyle(
                                  fontFamily: 'Varela',
                                  color: Color(0xFFD17E50),
                                  fontSize: 12),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.king_bed,
                              color: Color(0xFFD17E50),
                              size: 16,
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            Text(
                              space.status,
                              style: const TextStyle(
                                  fontFamily: 'Varela',
                                  color: Color(0xFFD17E50),
                                  fontSize: 12),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:real_sokost/theme.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'button_navbar_item.dart';
import 'favorite.dart';
import 'homepage.dart';
import 'login_widgets/widgets/custom_button.dart';
import 'login_widgets/widgets/custom_textfield.dart';

// class ProfilPage extends StatefulWidget {
//   final String id_user;
//   final String name;
//   final String email;
//   final String password;
//   final String nohp;

//   const ProfilPage(
//       {Key key, this.id_user, this.name, this.email, this.password, this.nohp})
//       : super(key: key);

//   @override
//   State<ProfilPage> createState() => _ProfilPageState();
// }

// class _ProfilPageState extends State<ProfilPage> {
//   // TextEditingController txtnama, txtemail, txtpassword, txtnohp;

//   @override
//   Widget build(BuildContext context) {
//     // setup() {
//     //   txtnama = TextEditingController(text: widget.name);
//     //   txtemail = TextEditingController(text: widget.id_user);
//     //   txtpassword = TextEditingController(text: widget.name);
//     //   txtnohp = TextEditingController(text: widget.name);
//     // }

//     print("ini adalah");

//     return Scaffold(
//       backgroundColor: whiteColor,
//       body: SafeArea(
//         bottom: false,
//         child: Stack(
//           children: [
//             Image.asset(
//               'assets/photo1.png',
//               width: MediaQuery.of(context).size.width,
//               height: 350,
//               fit: BoxFit.cover,
//             ),
//             ListView(
//               children: [
//                 const SizedBox(
//                   height: 300,
//                 ),
//                 Container(
//                   width: MediaQuery.of(context).size.width,
//                   decoration: const BoxDecoration(
//                     borderRadius: BorderRadius.vertical(
//                       top: Radius.circular(50),
//                     ),
//                     color: Color(0xffFFFFFF),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(20),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Center(
//                           child: Text(
//                             "My Profil",
//                             style: blackTextStyle.copyWith(fontSize: 20),
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         CustomFormField(
//                           headingText: "Nama Lengkap",
//                           obsecureText: false,
//                           suffixIcon: const SizedBox(),
//                           maxLines: 1,
//                           textInputAction: TextInputAction.done,
//                           textInputType: TextInputType.emailAddress,
//                           // controller: txtnama,
//                         ),
//                         const SizedBox(
//                           height: 16,
//                         ),
//                         CustomFormField(
//                           headingText: "Email",
//                           obsecureText: false,
//                           suffixIcon: SizedBox(),
//                           // controller: txtemail,
//                           maxLines: 1,
//                           textInputAction: TextInputAction.done,
//                           textInputType: TextInputType.emailAddress,
//                         ),
//                         const SizedBox(
//                           height: 16,
//                         ),
//                         CustomFormField(
//                           headingText: "Password",
//                           maxLines: 1,
//                           textInputAction: TextInputAction.done,
//                           textInputType: TextInputType.text,
//                           hintText: "At least 8 Character",
//                           obsecureText: true,
//                           // controller: txtpassword,
//                           suffixIcon: IconButton(
//                               icon: const Icon(Icons.security),
//                               onPressed: () {}),
//                           // controller: passwordcontroller,
//                         ),
//                         const SizedBox(
//                           height: 16,
//                         ),
//                         CustomFormField(
//                           headingText: "No. HP",
//                           obsecureText: false,
//                           suffixIcon: SizedBox(),
//                           // controller: txtnohp,
//                           maxLines: 1,
//                           textInputAction: TextInputAction.done,
//                           textInputType: TextInputType.emailAddress,
//                         ),
//                         const SizedBox(
//                           height: 5,
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 60, right: 60),
//                           child: Container(
//                             margin: const EdgeInsets.symmetric(
//                                 vertical: 16, horizontal: 24),
//                             height: 50,
//                             width: 250,
//                             decoration: BoxDecoration(
//                                 color: purpleColor,
//                                 borderRadius: BorderRadius.circular(20)),
//                             // ignore: deprecated_member_use
//                             child: FlatButton(
//                               onPressed: () {
//                                 // _cekLogin();
//                               },
//                               child: const Text(
//                                 "Save",
//                                 style: TextStyle(
//                                     color: Colors.white, fontSize: 25),
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 70,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(
//                 horizontal: edge,
//                 vertical: 30,
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   InkWell(
//                     onTap: () {},
//                     child: Stack(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 5),
//                           child: Icon(
//                             Icons.photo_camera,
//                             color: whiteColor,
//                             size: 35,
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: Container(
//         height: 65,
//         width: MediaQuery.of(context).size.width - (2 * edge),
//         margin: EdgeInsets.symmetric(
//           horizontal: edge,
//         ),
//         decoration: BoxDecoration(
//           color: const Color(0xffF6F7F8),
//           borderRadius: BorderRadius.circular(23),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             InkWell(
//               onTap: () {
//                 Navigator.of(context).push(
//                     MaterialPageRoute(builder: (context) => const HomePage()));
//               },
//               child: BottomNavbarItem(
//                 imageUrl: 'assets/home (1).png',
//                 isActive: false,
//               ),
//             ),
//             InkWell(
//               onTap: () {
//                 Navigator.of(context).push(
//                     MaterialPageRoute(builder: (context) => const FavPage()));
//               },
//               child: BottomNavbarItem(
//                 imageUrl: 'assets/love.png',
//                 isActive: false,
//               ),
//             ),
//             InkWell(
//               onTap: () {
//                 Navigator.of(context).push(MaterialPageRoute(
//                     builder: (context) => const ProfilPage()));
//               },
//               child: BottomNavbarItem(
//                 imageUrl: 'assets/user.png',
//                 isActive: true,
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//     );
//   }
// }

class ProfilPage extends StatelessWidget {
  final String id_user;
  final String name;
  final String email;
  final String password;
  final String nohp;
  final String username;
  const ProfilPage(
      {Key key,
      this.id_user,
      this.name,
      this.email,
      this.password,
      this.nohp,
      this.username})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    TabController _tabController;
    TextEditingController txtnama, txtemail, txtpassword, txtnohp, txtusername;

    setup() {
      txtnama = TextEditingController(text: username);
      txtemail = TextEditingController(text: email);
      txtpassword = TextEditingController(text: password);
      txtnohp = TextEditingController(text: nohp);
      txtusername = TextEditingController(text: username);
    }

    // _updatedata() async {
    //   // ignore: prefer_const_declarations
    //   final String sUrl =
    //       "http://percobaan.slkbankum.com/api/updatemakanan.php";
    //   final prefs = await SharedPreferences.getInstance();
    //   var params = "?nama=" +
    //       txtnama.text +
    //       "&harga=" +
    //       txtharga.text +
    //       "&keterangan=" +
    //       txtket.text +
    //       "&id=" +
    //       idumum;

    //   try {
    //     var res = await http.get(Uri.parse(sUrl + params));
    //     if (res.statusCode == 200) {
    //       var response = json.decode(res.body);
    //       if (response['response_status'] == "OK") {
    //         prefs.setBool('slogin', true);
    //         Widget okButton = FlatButton(
    //           child: const Text("OK"),
    //           onPressed: () => Navigator.of(context, rootNavigator: true)
    //               .pushAndRemoveUntil(
    //                   MaterialPageRoute(
    //                       builder: (context) => const HomeAdmin()),
    //                   (Route<dynamic> route) => false),
    //         );
    //         AlertDialog alert = AlertDialog(
    //           title: const Text("Notifikasi"),
    //           content: const Text("Data berhasil di update"),
    //           actions: [
    //             okButton,
    //           ],
    //         );
    //         showDialog(
    //           context: context,
    //           builder: (BuildContext context) {
    //             return alert;
    //           },
    //         );
    //       } else {
    //         // ignore: avoid_print
    //         print("Gagal");
    //         // _showAlertDialog(context, response['response_message']);
    //       }
    //     }
    //   } catch (e) {}
    // }

    _showAlertDialog(BuildContext context, String err) {
      // ignore: deprecated_member_use
      Widget okButton = FlatButton(
        child: const Text("OK"),
        onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
      );
      AlertDialog alert = AlertDialog(
        title: const Text("Error"),
        content: Text(err),
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

    // _deletedata() async {
    //   // ignore: prefer_const_declarations
    //   final String sUrl = "http://percobaan.slkbankum.com/api/deleteumum.php";
    //   final prefs = await SharedPreferences.getInstance();
    //   var params = "?id=" + idumum;
    //   try {
    //     var res = await http.get(Uri.parse(sUrl + params));
    //     if (res.statusCode == 200) {
    //       var response = json.decode(res.body);
    //       if (response['response_status'] == "OK") {
    //         prefs.setBool('slogin', true);
    //         Widget okButton = FlatButton(
    //           child: const Text("OK"),
    //           onPressed: () => Navigator.of(context, rootNavigator: true)
    //               .pushAndRemoveUntil(
    //                   MaterialPageRoute(
    //                       builder: (context) => const HomeAdmin()),
    //                   (Route<dynamic> route) => false),
    //         );
    //         AlertDialog alert = AlertDialog(
    //           title: const Text("Notifikasi"),
    //           content: const Text("Data berhasil di hapus"),
    //           actions: [
    //             okButton,
    //           ],
    //         );
    //         showDialog(
    //           context: context,
    //           builder: (BuildContext context) {
    //             return alert;
    //           },
    //         );
    //       } else {
    //         // ignore: avoid_print
    //         print("Gagal");
    //         // _showAlertDialog(context, response['response_message']);
    //       }
    //     }
    //   } catch (e) {}
    // }

    setup();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        // leading: IconButton(
        //   icon: const Icon(
        //     Icons.arrow_back,
        //     color: Color(0xFF545D68),
        //   ),
        //   onPressed: () {
        //     Navigator.of(context).pop();
        //   },
        // ),
        title: Text(
          'Profil Page',
          style: blackTextStyle.copyWith(fontSize: 25),
        ),
        // actions: [
        //   IconButton(
        //     icon: const Icon(
        //       Icons.notifications_none,
        //       color: Color(0xFF497fff),
        //     ),
        //     onPressed: () {},
        //   ),
        // ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Text(
              'My Profile',
              style: blackTextStyle.copyWith(fontSize: 22),
            ),
          ),
          const SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 200,
                  child: Center(
                    child: Container(
                      height: 250,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                              // ignore: unnecessary_brace_in_string_interps
                              'assets/photo1.png'),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                CustomFormField(
                  headingText: "Nama Lengkap",
                  hintText: "nama user..",
                  obsecureText: false,
                  // suffixIcon: const SizedBox(),
                  controller: txtnama,
                  maxLines: 1,
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(
                  height: 19,
                ),
                CustomFormField(
                  headingText: "Email",
                  hintText: "@gmail.com",
                  obsecureText: false,
                  controller: txtemail,
                  maxLines: 1,
                  textInputType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(
                  height: 19,
                ),
                CustomFormField(
                  headingText: "Password",
                  hintText: "secure",
                  obsecureText: false,
                  suffixIcon: const SizedBox(),
                  controller: txtpassword,
                  maxLines: 1,
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(
                  height: 19,
                ),
                CustomFormField(
                  headingText: "No. Hp",
                  hintText: "08xxx",
                  obsecureText: false,
                  suffixIcon: const SizedBox(),
                  controller: txtnohp,
                  maxLines: 1,
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(
                  height: 0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 24),
                    ),
                  ],
                ),
                AuthButton(
                  onTap: () {
                    // _updatedata();
                  },
                  text: 'Edit data',
                ),
                const SizedBox(
                  height: 170,
                ),
              ],
            ),
          ),
        ],
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
                imageUrl: 'assets/love.png',
                isActive: false,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return ProfilPage(
                    id_user: id_user,
                    name: name,
                  );
                }));
              },
              child: BottomNavbarItem(
                imageUrl: 'assets/user.png',
                isActive: true,
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

// ignore_for_file: empty_catches

import 'package:flutter/material.dart';
import 'package:real_sokost/homepage.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
// import 'splashpage.dart';
// import 'login_widgets/styles/app_colors.dart';
// import 'login_widgets/widgets/custom_button.dart';
import 'login_widgets/widgets/custom_textfield.dart';
// import 'login_widgets/widgets/custom_header.dart';
// import 'login_widgets/widgets/custom_richtext.dart';
import 'package:http/http.dart' as http;

// class Siginin extends StatefulWidget {
//   const Siginin({Key key}) : super(key: key);

//   @override
//   State<Siginin> createState() => _SigininState();
// }

// class _SigininState extends State<Siginin> {
//   final TextEditingController emailcontroller = TextEditingController();
//   final TextEditingController passwordcontroller = TextEditingController();

//   bool visible = false;
//   final String sUrl = "http://percobaan.slkbankum.com/api/login.php";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//           child: Stack(
//         children: [
//           Container(
//             height: MediaQuery.of(context).size.height,
//             width: MediaQuery.of(context).size.width,
//             color: AppColors.blue,
//           ),
//           CustomHeader(
//             text: 'Login',
//             onTap: () {
//               // Navigator.pushReplacement(context,
//               //     MaterialPageRoute(builder: (context) => const SplashPage()));
//             },
//           ),
//           Positioned(
//             top: MediaQuery.of(context).size.height * 0.08,
//             child: Container(
//               height: MediaQuery.of(context).size.height * 0.9,
//               width: MediaQuery.of(context).size.width,
//               decoration: const BoxDecoration(
//                   color: AppColors.whiteshade,
//                   borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(40),
//                       topRight: Radius.circular(40))),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     height: 200,
//                     width: MediaQuery.of(context).size.width * 0.8,
//                     margin: EdgeInsets.only(
//                         left: MediaQuery.of(context).size.width * 0.08),
//                     child: Image.asset("assets/adaa.png"),
//                   ),
//                   const SizedBox(
//                     height: 24,
//                   ),
//                   CustomFormField(
//                     headingText: "Email",
//                     hintText: "Email",
//                     obsecureText: false,
//                     suffixIcon: const SizedBox(),
//                     controller: emailcontroller,
//                     maxLines: 1,
//                     textInputAction: TextInputAction.done,
//                     textInputType: TextInputType.emailAddress,
//                   ),
//                   const SizedBox(
//                     height: 16,
//                   ),
//                   CustomFormField(
//                     headingText: "Password",
//                     maxLines: 1,
//                     textInputAction: TextInputAction.done,
//                     textInputType: TextInputType.text,
//                     hintText: "At least 8 Character",
//                     obsecureText: true,
//                     suffixIcon: IconButton(
//                         icon: const Icon(Icons.security), onPressed: () {}),
//                     controller: passwordcontroller,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Container(
//                         margin: const EdgeInsets.symmetric(
//                             vertical: 16, horizontal: 24),
//                       ),
//                     ],
//                   ),
//                   AuthButton(
//                     onTap: () {
//                       Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const HomePage()));
//                     },
//                     text: 'Sign In',
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       )),
//     );
//   }
// }
class Signin extends StatefulWidget {
  const Signin({Key key}) : super(key: key);

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  bool visible = false;
  final String sUrl = "http://slkbankum.com/api_app/login.php";

  @override
  void initState() {
    super.initState();
  }

  _cekLogin() async {
    setState(() {
      visible = true;
    });
    final prefs = await SharedPreferences.getInstance();
    var params = "?email=" +
        emailcontroller.text +
        "&password=" +
        passwordcontroller.text;
    try {
      var res = await http.get(Uri.parse(sUrl + params));
      if (res.statusCode == 200) {
        var response = json.decode(res.body);
        if (response['response_status'] == "OK") {
          prefs.setBool('slogin', true);
          prefs.setString('username', response['data'][0]['username']);
          prefs.setString('id_user', response['data'][0]['id']);
          prefs.setString('password', response['data'][0]['password']);
          prefs.setString('nohp', response['data'][0]['nohp']);
          prefs.setString('nama', response['data'][0]['nama']);
          prefs.setString('email', response['data'][0]['email']);
          // profil = Profil(
          //   id: 1,
          //   email: response['data'][0]['email'],
          //   password: response['data'][0]['password'],
          //   nama: response['data'][0]['nama'],
          // );

          setState(() {
            visible = false;
          });
          _showAlertDialogBerhasil(context);
        } else {
          setState(() {
            visible = false;
          });
          _showAlertDialog(context, response['response_message']);
        }
      }
    } catch (e) {}
  }

  _showAlertDialogBerhasil(BuildContext context) {
    // ignore: deprecated_member_use
    Widget okButton = FlatButton(
      child: const Text("OK"),
      onPressed: () => Navigator.of(context, rootNavigator: true)
          .pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const HomePage()),
              (Route<dynamic> route) => false),
    );
    AlertDialog alert = AlertDialog(
      title: const Text("Notifikasi"),
      content: const Text("Login Berhasil"),
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

  _showDatakosong(BuildContext context) {
    // ignore: deprecated_member_use
    Widget okButton = FlatButton(
        child: const Text("OK"), onPressed: () => Navigator.pop(context));
    AlertDialog alert = AlertDialog(
      title: const Text("Notifikasi"),
      content: const Text("Email tidak boleh kosong"),
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

  _showDatakosong2(BuildContext context) {
    // ignore: deprecated_member_use
    Widget okButton = FlatButton(
        child: const Text("OK"), onPressed: () => Navigator.pop(context));
    AlertDialog alert = AlertDialog(
      title: const Text("Notifikasi"),
      content: const Text("Email dan Password tidak boleh kosong"),
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

  _showDatap(BuildContext context) {
    // ignore: deprecated_member_use
    Widget okButton = FlatButton(
        child: const Text("OK"), onPressed: () => Navigator.pop(context));
    AlertDialog alert = AlertDialog(
      title: const Text("Notifikasi"),
      content: const Text("Password tidak boleh kosong"),
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: ListView(
            children: [
              const SizedBox(
                height: 35,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Center(
                  child: SizedBox(
                    height: 200,
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Image.asset("assets/adaa.png"),
                  ),
                ),
              ),
              const SizedBox(
                height: 70,
              ),
              // const Padding(
              //   padding: EdgeInsets.only(left: 20, right: 20),
              //   child: Text(
              //     "Login ",
              //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              //   ),
              // ),
              CustomFormField(
                headingText: "Email",
                hintText: "Email",
                obsecureText: false,
                suffixIcon: const SizedBox(),
                controller: emailcontroller,
                maxLines: 1,
                textInputAction: TextInputAction.done,
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 16,
              ),
              CustomFormField(
                headingText: "Password",
                maxLines: 1,
                textInputAction: TextInputAction.done,
                textInputType: TextInputType.text,
                hintText: "At least 8 Character",
                obsecureText: true,
                suffixIcon: IconButton(
                    icon: const Icon(Icons.security), onPressed: () {}),
                controller: passwordcontroller,
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20)),
                  // ignore: deprecated_member_use
                  child: FlatButton(
                    onPressed: () {
                      if (emailcontroller.text == "" &&
                          passwordcontroller.text == "") {
                        _showDatakosong2(context);
                      } else if (emailcontroller.text == "") {
                        _showDatakosong(context);
                      } else if (passwordcontroller.text == "") {
                        _showDatap(context);
                      } else {
                        _cekLogin();
                      }
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
              ),
              // ignore: deprecated_member_use
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "kembali",
                  style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0), fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

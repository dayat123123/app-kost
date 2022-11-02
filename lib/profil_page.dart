import 'package:flutter/material.dart';
import 'package:real_sokost/theme.dart';

import 'login_widgets/widgets/custom_textfield.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({Key key}) : super(key: key);

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Image.asset(
              'assets/photo1.png',
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
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            "My Profil",
                            style: blackTextStyle.copyWith(fontSize: 20),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const CustomFormField(
                          headingText: "Nama Lengkap",
                          hintText: "${1}",
                          obsecureText: false,
                          suffixIcon: SizedBox(),
                          // controller: emailcontroller,
                          maxLines: 1,
                          textInputAction: TextInputAction.done,
                          textInputType: TextInputType.emailAddress,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const CustomFormField(
                          headingText: "Email",
                          hintText: "${1}",
                          obsecureText: false,
                          suffixIcon: SizedBox(),
                          // controller: emailcontroller,
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
                              icon: const Icon(Icons.security),
                              onPressed: () {}),
                          // controller: passwordcontroller,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const CustomFormField(
                          headingText: "No. HP",
                          hintText: "${1}",
                          obsecureText: false,
                          suffixIcon: SizedBox(),
                          // controller: emailcontroller,
                          maxLines: 1,
                          textInputAction: TextInputAction.done,
                          textInputType: TextInputType.emailAddress,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 60, right: 60),
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 24),
                            height: 50,
                            width: 250,
                            decoration: BoxDecoration(
                                color: purpleColor,
                                borderRadius: BorderRadius.circular(20)),
                            // ignore: deprecated_member_use
                            child: FlatButton(
                              onPressed: () {
                                // _cekLogin();
                              },
                              child: const Text(
                                "Save",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Image.asset(
                            'assets/user.png',
                            width: 40,
                          ),
                        )
                      ],
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

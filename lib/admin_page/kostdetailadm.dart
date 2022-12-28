// ignore_for_file: unused_local_variable, empty_catches

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../login_widgets/styles/text_styles.dart';
import '../login_widgets/widgets/custom_button.dart';
import '../login_widgets/widgets/custom_button2.dart';
import '../login_widgets/widgets/custom_textfield.dart';
import 'homeadmin.dart';
import 'package:image_picker/image_picker.dart';

class KostDetailA extends StatefulWidget {
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

  const KostDetailA({
    Key key,
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
    this.numberOfCupboards,
  }) : super(key: key);

  @override
  State<KostDetailA> createState() => _KostDetailAState();
}

// final List _listkecamatan = ["Payung Sekaki", "Bukit Barisan"];
// String _kecamatan;

class _KostDetailAState extends State<KostDetailA> {
  _showAlertDialog2(BuildContext context) {
    Widget okButton = FlatButton(
      child: const Text("OK"),
      onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
    );
    AlertDialog alert = AlertDialog(
      title: const Text("Perhatian"),
      content: const Text("Jenis kost tidak boleh kosong"),
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

  final List _listkategori = ["Cowok", "Cewek"];
  String _kategori;
  TextEditingController txtnama, txtprice, txtaddress, txtjd, txtjl, txtjk;
  String jeniss;
  File _imageFile;
  @override
  void initState() {
    super.initState();
  }

  showAlertDialogpilih(BuildContext context) {
    // set up the buttons
    Widget kameraButton = TextButton(
      child: const Text("Kamera"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
        _pilihKamera();
      },
    );
    Widget galerButton = TextButton(
      child: const Text("Galeri"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
        _pilihGallery();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Foto"),
      content: const Text("pilih foto dari ?"),
      actions: [
        kameraButton,
        galerButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _pilihGallery() async {
    ImagePicker _picker = ImagePicker();
    XFile image = await _picker.pickImage(
        source: ImageSource.gallery, maxHeight: 1920.0, maxWidth: 1080.0);
    setState(() {
      _imageFile = File(image.path);
      // _showAlertDialogupload(context);
    });
  }

  _pilihKamera() async {
    ImagePicker _picker = ImagePicker();
    var image = await _picker.pickImage(
        source: ImageSource.camera, maxHeight: 1920.0, maxWidth: 1080.0);
    setState(() {
      _imageFile = File(image.path);
      // _showAlertDialogupload(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    setup() {
      txtnama = TextEditingController(text: widget.name);
      txtprice = TextEditingController(text: widget.price);
      txtaddress = TextEditingController(text: widget.address);
      txtjk = TextEditingController(text: widget.numberOfBedrooms);
      txtjl = TextEditingController(text: widget.numberOfCupboards);
      txtjd = TextEditingController(text: widget.numberOfKitchens);
      jeniss = widget.status;
    }

    // untuk update data
    _updatedata() async {
      // ignore: prefer_const_declarations
      final String sUrl = "http://sofiaal.slkbankum.com/api/updateKost.php";
      final prefs = await SharedPreferences.getInstance();
      try {
        if (jeniss != "") {
          var params = "?name=" +
              txtnama.text +
              "&price=" +
              txtprice.text +
              "&address=" +
              txtaddress.text +
              "&numberOfKitchens=" +
              txtjd.text +
              "&numberOfBedrooms=" +
              txtjk.text +
              "&numberOfCupboards=" +
              txtjl.text +
              "&status=" +
              _kategori +
              "&id=" +
              widget.id;
          try {
            var res = await http.get(Uri.parse(sUrl + params));
            if (res.statusCode == 200) {
              var response = json.decode(res.body);
              if (response['response_status'] == "OK") {
                prefs.setBool('slogin', true);
                // ignore: deprecated_member_use
                Widget okButton = FlatButton(
                  child: const Text("OK"),
                  onPressed: () => Navigator.of(context, rootNavigator: true)
                      .pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const HomeAdmin()),
                          (Route<dynamic> route) => false),
                );
                AlertDialog alert = AlertDialog(
                  title: const Text("Notifikasi"),
                  content: const Text("Data berhasil di update"),
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
            }
          } catch (e) {}
        } else {}
      } catch (e) {
        _showAlertDialog2(context);
      }
    }

    _showAlertDialogBerhasil(BuildContext context) {
      Widget okButton = FlatButton(
        child: const Text("OK"),
        onPressed: () => Navigator.of(context, rootNavigator: true)
            .pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const HomeAdmin()),
                (Route<dynamic> route) => false),
      );
      AlertDialog alert = AlertDialog(
        title: const Text("Notifikasi"),
        content: const Text("Foto Berhasil Diubah"),
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

    _showAlertDialog(BuildContext context) {
      Widget okButton = FlatButton(
        child: const Text("OK"),
        onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
      );
      AlertDialog alert = AlertDialog(
        title: const Text("Error"),
        content: const Text("err"),
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

    //  edit foto function
    Future editFoto() async {
      final uri = Uri.parse("http://sofiaal.slkbankum.com/api/editfoto.php");
      var request = http.MultipartRequest('POST', uri);
      var foto = '';
      request.fields['id'] = widget.id;
      var pic = await http.MultipartFile.fromPath("foto", _imageFile.path);
      request.files.add(pic);
      var response = await request.send();
      if (response.statusCode == 200) {
        _showAlertDialogBerhasil(context);
      } else {
        _showAlertDialog(context);
      }
    }

    // batas
    setup();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF545D68),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Edit Data',
          style: TextStyle(
            fontFamily: 'Varela',
            fontSize: 24.0,
            color: Color(0xFF545D68),
          ),
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              widget.name,
              style: const TextStyle(
                fontFamily: 'Varela',
                fontSize: 27.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFF17532),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          InkWell(
            onTap: () {
              showAlertDialogpilih(context);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 120,
                    child: Center(
                      child: Container(
                        height: 230,
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: _imageFile == null
                                ? AssetImage(
                                    // ignore: unnecessary_brace_in_string_interps
                                    'assets/${widget.imageUrl}')
                                : FileImage(_imageFile),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  Center(
                    child: _imageFile == null
                        ? const Text("")
                        : Padding(
                            padding: const EdgeInsets.only(
                                left: 110, right: 110, top: 10),
                            child: AuthButton(
                              onTap: () {
                                editFoto();
                              },
                              text: 'Ganti Foto',
                            ),
                          ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  CustomFormField(
                    headingText: "Nama",
                    hintText: "nama kost..",
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
                    headingText: "Harga",
                    hintText: "Rp..",
                    obsecureText: false,
                    controller: txtprice,
                    maxLines: 1,
                    textInputType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                  ),
                  const SizedBox(
                    height: 19,
                  ),
                  CustomFormField(
                    headingText: "Alamat",
                    hintText: "...",
                    obsecureText: false,
                    suffixIcon: const SizedBox(),
                    controller: txtaddress,
                    maxLines: 1,
                    textInputAction: TextInputAction.done,
                  ),
                  // ignore: prefer_const_constructors
                  SizedBox(
                    height: 10,
                  ),
                  CustomFormField(
                    headingText: "Jumlah Kasur",
                    hintText: "jumlah kasur..",
                    obsecureText: false,
                    // suffixIcon: const SizedBox(),
                    textInputType: TextInputType.number,
                    controller: txtjk,
                    maxLines: 1,
                    textInputAction: TextInputAction.done,
                  ),
                  const SizedBox(
                    height: 19,
                  ),
                  CustomFormField(
                    headingText: "Jumlah Dapur",
                    hintText: "jumlah dapur..",
                    obsecureText: false,
                    // suffixIcon: const SizedBox(),
                    textInputType: TextInputType.number,
                    controller: txtjd,
                    maxLines: 1,
                    textInputAction: TextInputAction.done,
                  ),
                  const SizedBox(
                    height: 19,
                  ),
                  CustomFormField(
                    headingText: "Jumlah Lemari",
                    hintText: "jumlah lemari..",
                    obsecureText: false,
                    // suffixIcon: const SizedBox(),
                    textInputType: TextInputType.number,
                    controller: txtjl,
                    maxLines: 1,
                    textInputAction: TextInputAction.done,
                  ),
                  const SizedBox(
                    height: 19,
                  ),
                  // ignore: prefer_const_constructors
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      "Jenis Kost (${widget.status})",
                      style: KTextStyle.textFieldHeading,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        hint: const Text("--Jenis Kost--"),
                        value: _kategori,
                        items: _listkategori.map((value) {
                          return DropdownMenuItem(
                            child: Text(value),
                            value: value,
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _kategori =
                                value; //Untuk memberitahu _valFriends bahwa isi nya akan diubah sesuai dengan value yang kita pilih
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // ignore: prefer_const_constructors
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 20),
                  //   child: const Text(
                  //     "Kecamatan",
                  //     style: KTextStyle.textFieldHeading,
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 25),
                  //   child: DropdownButtonHideUnderline(
                  //     child: DropdownButton(
                  //       hint: const Text("--Kecamatan--"),
                  //       value: _kecamatan,
                  //       items: _listkecamatan.map((value) {
                  //         return DropdownMenuItem(
                  //           child: Text(value),
                  //           value: value,
                  //         );
                  //       }).toList(),
                  //       onChanged: (value) {
                  //         setState(() {
                  //           _kategori =
                  //               value; //Untuk memberitahu _valFriends bahwa isi nya akan diubah sesuai dengan value yang kita pilih
                  //         });
                  //       },
                  //     ),
                  //   ),
                  // ),

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
                      _updatedata();
                    },
                    text: 'Edit data',
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  AuthButton2(
                    onTap: () {
                      // _deletedata();
                    },
                    text: 'Delete data',
                  ),
                  const SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

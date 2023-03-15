import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../login_widgets/widgets/custom_button.dart';
import '../login_widgets/widgets/custom_textfield.dart';
import 'homeadmin.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class TambahData extends StatefulWidget {
  final String id;
  final String nowa;
  const TambahData({Key key, this.id, this.nowa}) : super(key: key);

  @override
  State<TambahData> createState() => _TambahDataState();
}

class _TambahDataState extends State<TambahData> {
  bool visible = false;
  File _imageFile;
  String _status;
  final List _liststatus = ["Cowok", "Cewek"];
  final List _listkecamatan = [
    "Payung Sekaki",
    "Bukit Barisan",
    "Pasir Putih",
    "Panam",
    "Marpoyan"
  ];
  String _kecamatan;
  final TextEditingController txtnama = TextEditingController();
  final TextEditingController txtharga = TextEditingController();
  final TextEditingController txtalamat = TextEditingController();
  final TextEditingController txtid = TextEditingController();
  final TextEditingController txtjdapur = TextEditingController();
  final TextEditingController txtjlemari = TextEditingController();
  final TextEditingController txtjkasur = TextEditingController();
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
    final XFile image = await _picker.pickImage(
        source: ImageSource.camera, maxHeight: 1920.0, maxWidth: 1080.0);
    setState(() {
      _imageFile = File(image.path);
      // _showAlertDialogupload(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Form tambah Data Kost"),
        automaticallyImplyLeading: true,
      ),
      body: ListView(
        children: [
          GestureDetector(
            onTap: (() => showAlertDialogpilih(context)),
            child: Container(
              // padding: EdgeInsets.all(5),
              // margin: EdgeInsets.all(6.0),
              width: MediaQuery.of(context).size.width / 1,
              height: 200,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),

                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.grey.withOpacity(0.5),
                //     spreadRadius: 5,
                //     blurRadius: 7,
                //     offset: Offset(0, 3), // changes position of shadow
                //   ),
                // ],
              ),
              child: Container(
                padding: const EdgeInsets.all(40),
                child: Image(
                  image: _imageFile == null
                      ? const NetworkImage(
                          'http://percobaan.slkbankum.com/api/image/blank.jpg')
                      : FileImage(_imageFile),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 22, right: 22),
            child: Center(
              child:
                  _imageFile == null ? const Text("") : Text(_imageFile.path),
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              "Kecamatan",
              style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 1),
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 27),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                hint: const Text("--Kecamatan--"),
                value: _kecamatan,
                items: _listkecamatan.map((value) {
                  return DropdownMenuItem(
                    child: Text(value),
                    value: value,
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _kecamatan =
                        value; //Untuk memberitahu _valFriends bahwa isi nya akan diubah sesuai dengan value yang kita pilih
                  });
                },
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              "Jenis Kost",
              style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 1),
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 27),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                hint: const Text("--Jenis Kost--"),
                value: _status,
                items: _liststatus.map((value) {
                  return DropdownMenuItem(
                    child: Text(value),
                    value: value,
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _status =
                        value; //Untuk memberitahu _valFriends bahwa isi nya akan diubah sesuai dengan value yang kita pilih
                  });
                },
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          CustomFormField(
            headingText: "Nama Kost",
            hintText: "nama kost..",
            obsecureText: false,
            // suffixIcon: const SizedBox(),
            controller: txtnama,
            maxLines: 1,
            textInputAction: TextInputAction.done,
          ),
          const SizedBox(
            height: 10,
          ),
          CustomFormField(
            headingText: "Harga Kost",
            hintText: "Rp..",
            obsecureText: false,
            // suffixIcon: const SizedBox(),
            controller: txtharga,
            maxLines: 1,
            textInputType: TextInputType.number,
            textInputAction: TextInputAction.done,
          ),
          const SizedBox(
            height: 15,
          ),
          CustomFormField(
            headingText: "Alamat",
            hintText: "alamat..",
            obsecureText: false,
            // suffixIcon: const SizedBox(),
            controller: txtalamat,
            maxLines: 1,
            textInputAction: TextInputAction.done,
          ),
          const SizedBox(
            height: 15,
          ),
          CustomFormField(
            headingText: "Jumlah Kasur",
            hintText: "jumlah kasur..",
            obsecureText: false,
            // suffixIcon: const SizedBox(),
            controller: txtjkasur,
            maxLines: 1,
            textInputType: TextInputType.number,
            textInputAction: TextInputAction.done,
          ),
          const SizedBox(
            height: 15,
          ),
          CustomFormField(
            headingText: "Jumlah Dapur",
            hintText: "jumlah dapur..",
            obsecureText: false,
            // suffixIcon: const SizedBox(),
            controller: txtjdapur,
            maxLines: 1,
            textInputType: TextInputType.number,
            textInputAction: TextInputAction.done,
          ),
          const SizedBox(
            height: 15,
          ),
          CustomFormField(
            headingText: "Jumlah Lemari",
            hintText: "jumlah lemari..",
            obsecureText: false,
            // suffixIcon: const SizedBox(),
            controller: txtjlemari,
            maxLines: 1,
            textInputType: TextInputType.number,
            textInputAction: TextInputAction.done,
          ),
          const SizedBox(
            height: 15,
          ),
          const SizedBox(
            height: 22,
          ),
          AuthButton(
            onTap: () {
              TambahData();
            },
            text: 'Tambah data',
          ),
          Container(
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const HomeAdmin()),
                    (Route<dynamic> route) => false);
              },
              child: const Text(
                "Kembali",
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0), fontSize: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future TambahData() async {
    Dio dio = new Dio();
    // final uri = Uri.parse("http://sofiaal.slkbankum.com/api/tambahkost.php");
    if (_imageFile == null && _status != null && _status != null) {
      _showAlertDialogFoto(context);
    } else if (_imageFile == null && _status != null) {
      _showAlertDialogFoto(context);
    } else if (_imageFile == null && _status == null && _status == null) {
      _showAlertDialogFoto(context);
    } else if (_imageFile != null && _status == null && _status == null) {
      _showAlertDialogFoto(context);
    } else if (_imageFile != null && _status != null && _status == null) {
      _showAlertDialogFoto(context);
    } else if (_imageFile != null && _status == null && _status != null) {
      _showAlertDialogFoto(context);
    } else if (_status == null) {
      _showAlertDialogFoto(context);
    } else if (_status == null) {
      _showAlertDialogFoto(context);
    } else if (_imageFile == null) {
      _showAlertDialogFoto(context);
    } else {
      String fileName = _imageFile.path.split('/').last;
      var formData = FormData.fromMap({
        'nama': txtnama.text,
        'harga': txtharga.text,
        'kecamatan': _kecamatan,
        'jenis': _status,
        'alamat': txtalamat.text,
        'jumlah_kasur': txtjkasur.text,
        'jumlah_dapur': txtjdapur.text,
        'jumlah_lemari': txtjlemari.text,
        'id_user': widget.id,
        'no_wa': widget.nowa,
        'foto':
            await MultipartFile.fromFile(_imageFile.path, filename: fileName)
      });
      Response response = await dio.post(
          "http://sofiaal.slkbankum.com/api/tambahkost.php",
          data: formData);
      if (response.statusCode == 200) {
        _showAlertDialogBerhasil(context);
      } else {
        _showAlertDialog(context);
      }
    }
  }

  _showAlertDialogBerhasil(BuildContext context) {
    Widget okButton = ElevatedButton(
      child: const Text("OK"),
      onPressed: () => Navigator.of(context, rootNavigator: true)
          .pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const HomeAdmin()),
              (Route<dynamic> route) => false),
    );
    AlertDialog alert = AlertDialog(
      title: const Text("Notifikasi"),
      content: const Text("Data Berhasil Ditambahkan"),
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
    Widget okButton = ElevatedButton(
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

  _showAlertDialogFoto(BuildContext context) {
    Widget okButton = ElevatedButton(
      child: const Text("OK"),
      onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
    );
    AlertDialog alert = AlertDialog(
      title: const Text("Perhatian"),
      content: const Text("Ada data yang belum diisi"),
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

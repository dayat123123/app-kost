import 'package:flutter/material.dart';

import '../login_widgets/styles/text_styles.dart';
import '../login_widgets/widgets/custom_button.dart';
import '../login_widgets/widgets/custom_button2.dart';
import '../login_widgets/widgets/custom_textfield.dart';

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

final List _listkategori = ["Cowok", "Cewek"];
String _kategori;

class _KostDetailAState extends State<KostDetailA> {
  @override
  Widget build(BuildContext context) {
    TextEditingController txtnama, txtprice, txtaddress, txtjd, txtjl, txtjk;
    setup() {
      txtnama = TextEditingController(text: widget.name);
      txtprice = TextEditingController(text: widget.price);
      txtaddress = TextEditingController(text: widget.address);
      txtjk = TextEditingController(text: widget.numberOfBedrooms);
      txtjl = TextEditingController(text: widget.numberOfCupboards);
      txtjd = TextEditingController(text: widget.numberOfKitchens);
    }

    // print("Ini berulang");
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
          Padding(
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
                          image: AssetImage(
                              // ignore: unnecessary_brace_in_string_interps
                              'assets/${widget.imageUrl}'),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
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
                  child: const Text(
                    "Jenis Kost",
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
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: const Text(
                    "Kecamatan",
                    style: KTextStyle.textFieldHeading,
                  ),
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
        ],
      ),
    );
  }
}

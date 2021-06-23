import 'dart:convert';

import 'package:aa/ui/datatampil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class FormInput extends StatefulWidget {
  @override
  _FormInputState createState() => _FormInputState();
}

class _FormInputState extends State<FormInput> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController namaController = TextEditingController();
  TextEditingController jenisController = TextEditingController();
  TextEditingController waktuController = TextEditingController();
  TextEditingController imageurlController = TextEditingController();
  //membuat method POST untuk Upload data ke API
  Future saveUpload() async {
    // karena ingin menambahkan data/POST maka perlu tambahan body karena di body API kita akan menambahkan data object yang ditulis harus sama dengan yang ada di API
    final response =
        await http.post(Uri.parse("http://10.0.2.2:8000/api/inputs"), body: {
      "namaKendaraan": namaController.text,
      "jenis": jenisController.text,
      "waktuSewa": waktuController.text,
      "imageurl": imageurlController.text,
    });
    return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        leading: Icon(Icons.arrow_back),
      ),
      body: Form(
        key: _formkey,
        child: Padding(
          padding: EdgeInsets.only(top: 15, left: 10, right: 10),
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: TextField(
                  controller: namaController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: "Nama Kendaraan",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: TextField(
                  controller: jenisController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: "Jenis",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: TextField(
                  controller: waktuController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: "Waktu",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: TextField(
                  controller: imageurlController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: "Image Url",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Row(
                  children: <Widget>[
                    // tombol simpan
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => DataTampil()));
                        },
                        child: Text("pesan")),
                    Container(
                      width: 5.0,
                    ),
                    // tombol batal
                    Expanded(
                      child: RaisedButton(
                        color: Colors.blue,
                        textColor: Colors.white,
                        child: Text(
                          'Batal',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
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

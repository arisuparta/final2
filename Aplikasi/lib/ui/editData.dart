import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'datatampil.dart';

class EditData extends StatelessWidget {
  final Map input;
  EditData({@required this.input});
  final _formkey = GlobalKey<FormState>();
  TextEditingController namaController = TextEditingController();
  TextEditingController jenisController = TextEditingController();
  TextEditingController waktuController = TextEditingController();
  TextEditingController imageurlController = TextEditingController();

  //membuat method POST untuk Upload data ke API
  Future updateKonten() async {
    // karena ingin mengedit data maka menggunakan method PUT maka perlu tambahan body karena di body API kita akan menambahkan data object yang sudah ditulis harus sama dengan yang ada di API
    // dan tambahan pada url yaitu upload ["id"] fungsinya untuk mengetahui id data ke berapa yang diedit pada API
    final response = await http.put(
        Uri.parse("http://10.0.2.2:8000/api/inputs/" + input['id'].toString()),
        body: {
          "namaKendaraan": namaController.text,
          "jenis": jenisController.text,
          "waktuSewa": waktuController.text,
          "image_url": imageurlController.text,
        });
    return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
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
                  controller: namaController..text = input['namaKendaraan'],
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
                  controller: jenisController..text = input['jenis'],
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: "Jenis Kendaraan",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: TextField(
                  controller: waktuController..text = input['waktuSewa'],
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: "Waktu Sewa",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: TextField(
                  controller: imageurlController..text = input['waktuSewa'],
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: "Image URL",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Row(
                  children: <Widget>[
                    // tombol simpan
                    Expanded(
                      child: RaisedButton(
                        color: Colors.green,
                        textColor: Colors.white,
                        child: Text(
                          'Update',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          if (_formkey.currentState.validate()) {
                            updateKonten().then((value) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DataTampil()));
                            });
                          }
                        },
                      ),
                    ),
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

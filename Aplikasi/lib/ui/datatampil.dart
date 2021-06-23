import 'dart:convert';

import 'package:aa/ui/formInput.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'editData.dart';

class DataTampil extends StatefulWidget {
  @override
  _DataTampilState createState() => _DataTampilState();
}

class _DataTampilState extends State<DataTampil> {
  //inget ganti yang isi 192.168.1.3 ini sesuaikan sama IP punya mu yang di IPConfig
  final String url = "http://10.0.2.2:8000/api/inputs";
  Future getInput() async {
    var response = await http.get(Uri.parse(url));
    print(jsonDecode(response.body));
    return jsonDecode(response.body);
  }

  Future deleteData(String dataId) async {
    final String url = "http://10.0.2.2:8000/api/inputs/" + dataId;
    var response = await http.delete(Uri.parse(url));

    return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Pelanggan"),
        backgroundColor: Colors.red,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => FormInput()));
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        width: double.maxFinite,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            FutureBuilder(
                future: getInput(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data['data'].length,
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
                              padding: EdgeInsets.only(top: 5),
                              child: Card(
                                  elevation: 8,
                                  child: ListTile(
                                    leading: IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => EditData(
                                                    input: snapshot.data['data']
                                                        [index])));
                                      },
                                    ),
                                    title: Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                child: Image.network(
                                                    snapshot.data['data'][index]
                                                        ['image_url']),
                                              ),
                                              Text("Nama Kendaraan : " +
                                                  snapshot.data['data'][index]
                                                      ['namaKendaraan']),
                                              IconButton(
                                                  icon: Icon(Icons.delete),
                                                  onPressed: () {
                                                    deleteData(snapshot
                                                            .data['data'][index]
                                                                ['id']
                                                            .toString())
                                                        .then((value) {
                                                      setState(() {});
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(SnackBar(
                                                              content: Text(
                                                                  "Data sudah dihapus")));
                                                    });
                                                  })
                                            ],
                                          ),
                                          Text("Jenis :" +
                                              snapshot.data['data'][index]
                                                  ['jenis']),
                                          Text("Waktu :" +
                                              snapshot.data['data'][index]
                                                  ['waktuSewa']),
                                        ],
                                      ),
                                    ),
                                  )));
                        });
                  } else {
                    return Text("Error");
                  }
                }),
          ],
        ),
      ),
    );
  }
}

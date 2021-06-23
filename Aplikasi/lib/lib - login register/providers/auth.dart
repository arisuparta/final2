import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  void singup(String email, String password) async {
    Uri url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAXdTKDJ-UUAl8MJaRzdBMEnIdxW1hAB-8');

    var response = http.post(url,
        body: json.encode({
          "email": email,
          "password": password,
          "returnSecureToken": true,
        }),
      );

    
  }
}

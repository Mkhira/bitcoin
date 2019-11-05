import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NET {
  NET(this.url);
  final String url;

  Future getdata() async {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String data = response.body;

      var decodedata = jsonDecode(data);
      double price = decodedata['last'];
//      print(price);
      return price;
    } else
      print(response.statusCode);
  }
}

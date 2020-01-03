import 'package:flutter/material.dart';
import 'homepage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

void main() async {
  List cryptoData = await getCurrencyData();
  print(cryptoData);
  runApp(MyApp(cryptoData));
}

class MyApp extends StatelessWidget {
  final List _cryptoData;
  MyApp(this._cryptoData);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Crypto App",
      theme: ThemeData(primarySwatch: Colors.cyan),
      debugShowCheckedModeBanner: false,
      home: RefreshIndicator(
        child: HomePage(_cryptoData),
        onRefresh: getCurrencyData,
      ),
    );
  }
}

Future<List> getCurrencyData() async {
  String cryptoUrl = "https://api.coinmarketcap.com/v1/ticker/?limit=50";
  http.Response response = await http.get(cryptoUrl);
  return JSON.jsonDecode(response.body);
}

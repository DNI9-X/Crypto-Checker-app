import 'package:flutter/material.dart';
import 'homepage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

Future<List> main() async {
  List cryptoData = await getCurrencyData();
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
        // home: HomePage(_cryptoData),
        home: Scaffold(
          appBar: AppBar(
            title: Text("Cryptocurrency Checker"),
            centerTitle: true,
            elevation: 10,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.list),
                onPressed: (){},
              )
            ],
          ),
          body: RefreshIndicator(
            child: HomePage(_cryptoData),
            onRefresh: main,
          ),
        ));
  }
}

Future<List> getCurrencyData() async {
  String cryptoUrl = "https://api.coinmarketcap.com/v1/ticker/?limit=50";
  http.Response response = await http.get(cryptoUrl);
  return JSON.jsonDecode(response.body);
}

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final List cryptoData;
  HomePage(this.cryptoData);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //
  // List cryptoData;
  final List<MaterialColor> _colors = [
    Colors.lime,
    Colors.deepPurple,
    Colors.orange,
    Colors.red,
    Colors.cyan,
    Colors.indigo
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        Flexible(
          child: ListView.builder(
            itemCount: widget.cryptoData.length,
            itemBuilder: (BuildContext context, int index) {
              final Map currency = widget.cryptoData[index];
              final MaterialColor color = _colors[index % _colors.length];
              return _getListItemUi(currency, color);
            },
          ),
        ),
      ],
    ));
  }

  Card _getListItemUi(Map currency, MaterialColor color) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: Text(
            currency['name'][0],
            style: TextStyle(color: Colors.white),
          ),
        ),
        title: Text(currency['name'],
            style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle:
            _getSubTitle(currency['price_usd'], currency['percent_change_1h']),
        contentPadding: EdgeInsets.symmetric(horizontal: 15),
        isThreeLine: true,
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Icon(Icons.favorite_border)],
        ),
        onLongPress: () {},
      ),
    );
  }

  Widget _getSubTitle(String priceUsd, String percentageChange) {
    TextSpan priceTextWidget =
        TextSpan(text: "\$$priceUsd\n", style: TextStyle(color: Colors.black));
    TextSpan percentageChangeWidget;

    if (double.parse(percentageChange) > 0) {
      percentageChangeWidget = TextSpan(
          text: "Increased $percentageChange%",
          style: TextStyle(color: Colors.green));
    } else {
      percentageChangeWidget = TextSpan(
          text: "Decreased $percentageChange%",
          style: TextStyle(color: Colors.red));
    }
    return RichText(
      text: TextSpan(children: [priceTextWidget, percentageChangeWidget]),
    );
  }
}

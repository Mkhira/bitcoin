import 'package:flutter/material.dart';
import 'const.dart';
import 'price_screen.dart';

class OurCard extends StatelessWidget {
  OurCard({this.crypot, this.selectedCurrency, this.value});
  final String crypot;
  final String value;

  final String selectedCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        clipBehavior: Clip.antiAlias,
        color: Kcardcolor,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '$crypot = $value $selectedCurrency',
            textAlign: TextAlign.center,
            style: Ktextstyle,
          ),
        ),
      ),
    );
  }
}

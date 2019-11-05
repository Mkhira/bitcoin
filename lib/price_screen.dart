import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'ourcard.dart';
import 'package:flutter/cupertino.dart';
import 'const.dart';
import 'dart:io' show Platform;
import 'network.dart';
import 'dart:convert';

class PriceScreen extends StatefulWidget {
  PriceScreen({this.covalue});
  final covalue;
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String coin = "UAD";
  String url;
  double coinprice;
  @override
  void initState() {
    super.initState();
    getthdata();
  }

  String selectedcurency = 'UAD';
  bool isWaiting = false;
  Map<String, String> cryptoPrices = {};

  Future getthdata() async {
    for (String coinlist in cryptoList) {
      NET net = new NET(
          "https://apiv2.bitcoinaverage.com/indices/global/ticker/$coinlist$selectedcurency");
//      print(coinlist);
//      print(selectedcurency);

      isWaiting = true;
      try {
        var coindat = await net.getdata();

        isWaiting = false;
        setState(() {
          coinprice = coindat;
          cryptoPrices[coinlist] = coindat.toString();
        });
      } catch (e) {
        print(e);
      }
      print(coinprice);
    }
  }

  CupertinoPicker iospicker() {
    List<Text> pikeritems = [];
    String currency;
    for (currency in currenciesList) {
      pikeritems.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 40.0,
//      offAxisFraction: 0,
//      scrollController: FixedExtentScrollController(initialItem: 4),

      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedcurency = currenciesList[selectedIndex];
          getthdata();
        });
      },
      // ignore: argument_type_not_assignable
      children: pikeritems,
    );
  }

  Map<String, String> coinValues = {};

  Column CreateCard() {
    List<OurCard> cryptoCards = [];
    for (String crypto in cryptoList) {
      cryptoCards.add(
        OurCard(
          crypot: crypto,
          selectedCurrency: selectedcurency,
          value: isWaiting ? '?' : cryptoPrices[crypto],
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: cryptoCards,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD1dFfa),
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0, 80, 0, 0),
              child: Material(
                borderRadius: BorderRadius.circular(20),
                elevation: 20,
                color: Colors.white70,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white54,
                  ),
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(bottom: 30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      CreateCard(),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 150, 0, 0),
              child: Container(
                height: 200.0,
                alignment: Alignment.center,
                padding: EdgeInsets.only(bottom: 0.0),
                color: Colors.lightBlue,
                child: iospicker(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

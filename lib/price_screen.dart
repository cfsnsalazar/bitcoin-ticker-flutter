import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'coin_data.dart';
import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  double currencyRate = 0.0;
  CoinData coinData = CoinData();

  @override
  void initState() {
    super.initState();
    getPriceData(currency: selectedCurrency);
  }

  void getPriceData({String currency}) async {
    double rate = await coinData.getCoinData(
        criptoCurrency: cryptoList[0], currency: currency);
    setState(() {
      selectedCurrency = currency;
      currencyRate = rate;
    });
  }

  CupertinoPicker getIOSPicker() {
    return CupertinoPicker(
      itemExtent: 32,
      backgroundColor: Colors.lightBlue,
      onSelectedItemChanged: (selectedIndex) {
        getPriceData(currency: currenciesList[selectedIndex]);
      },
      scrollController: FixedExtentScrollController(
        initialItem: getCurrencyIndex('USD')
      ),
      children: getMenuWidgets(),
    );
  }

  DropdownButton<String> getAndroidPicker() {
    return DropdownButton<String>(
      value: selectedCurrency,
      items: getMenuItems(),
      onChanged: (value) {
        getPriceData(currency: value);
      },
    );
  }

  List<DropdownMenuItem<String>> getMenuItems() {
    List<DropdownMenuItem<String>> items = [];
    currenciesList.forEach((currency) {
      items.add(DropdownMenuItem(
        child: Text(currency),
        value: currency,
      ));
    });
    return items;
  }

  List<Widget> getMenuWidgets() {
    List<Widget> items = [];
    currenciesList.forEach((currency) {
      items.add(
        Text(currency),
      );
    });
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = ${currencyRate.toInt()} $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: Platform.isIOS ? getIOSPicker() : getAndroidPicker()),
        ],
      ),
    );
  }
}

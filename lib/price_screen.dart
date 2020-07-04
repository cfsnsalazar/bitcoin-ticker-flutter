import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  CoinData coinData = CoinData('USD');

  @override
  void initState() {
    super.initState();
    updateCoinData(CoinData('USD'));
  }

  CupertinoPicker getIOSPicker() {
    return CupertinoPicker(
      itemExtent: 32,
      backgroundColor: Colors.lightBlue,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          updateCoinData(CoinData(currenciesList[selectedIndex]));
        });
      },
      scrollController: FixedExtentScrollController(
        initialItem: getCurrencyIndex(coinData.getSelectedCurrency())
      ),
      children: getMenuWidgets(),
    );
  }

  void updateCoinData(CoinData newCoinData) async {
    await newCoinData.retrieveRates();
    setState(() {
      coinData = newCoinData;
    });
  }

  DropdownButton<String> getAndroidPicker() {
    return DropdownButton<String>(
      value: coinData.getSelectedCurrency(),
      items: getMenuItems(),
      onChanged: (value) {
        updateCoinData(CoinData(value));
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

  Widget getCryptoCurrencyCard({String cryptoCurrency}) {
    return Padding(
      padding: EdgeInsets.only(left: 24, right: 24, top: 16),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $cryptoCurrency = ${coinData.getRate(cryptoCurrency: cryptoCurrency)} ${coinData.getSelectedCurrency()}',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> getCryptoCards() {
    List<Widget> cards = [];
    cryptoList.forEach((element) {
      cards.add(getCryptoCurrencyCard(cryptoCurrency: element));
    });
    return cards;
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
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: getCryptoCards(),
          )
          ,
          Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: Platform.isIOS ? getIOSPicker() : getAndroidPicker())
        ]
      ),
    );
  }
}

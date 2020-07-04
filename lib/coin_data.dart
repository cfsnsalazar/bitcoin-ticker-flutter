import 'dart:convert';
import 'dart:ffi';

import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future<double> getCoinData({String criptoCurrency, String currency}) async{
    var response = await http.get('https://rest.coinapi.io/v1/exchangerate/$criptoCurrency/$currency?apikey=7381723F-A3AF-4C9C-85E0-5B3EB0CC21D3');
    var data = jsonDecode(response.body);
    try{
      return data['rate'];
    }catch(e){
      return -1;
    }
  }
}

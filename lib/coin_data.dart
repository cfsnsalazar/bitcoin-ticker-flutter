import 'dart:convert';

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

int getCurrencyIndex(String currency){
  int position = 0;
  for(String element in currenciesList){
    if(element == currency){
      return position;
    }
    position ++;
  }
  return 0;
}

class CoinData {
  Map<String, double> _cryptoRates = Map();
  String _selectedCurrency = 'USD';

  CoinData(this._selectedCurrency);

  Future<void> retrieveRates() async {
    await Future.forEach(cryptoList, (element) async {
      double rate = await _getCoinData(
          criptoCurrency: element,
          currency: _selectedCurrency
      );
      _cryptoRates[element] = rate;
    });
  }

  String getRate({String cryptoCurrency}){
    return _cryptoRates[cryptoCurrency] != null ? '${_cryptoRates[cryptoCurrency].toInt()}' : '?';
  }

  String getSelectedCurrency(){
    return _selectedCurrency;
  }
  
  Future<double> _getCoinData({String criptoCurrency, String currency}) async{
    var response = await http.get('https://rest.coinapi.io/v1/exchangerate/$criptoCurrency/$currency?apikey=F7D595ED-2FD0-480B-839E-3B90765BBC77');
    var data = jsonDecode(response.body);
    try{
      return data['rate'];
    }catch(e){
      return -1;
    }
  }
}

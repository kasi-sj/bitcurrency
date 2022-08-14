import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String money = 'INR';
String btc = '';
String eth = '';
String ltc = '';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  list() {
    List<DropdownMenuItem<String>> values = [];

    for (var val in currenciesList) {
      values.add(DropdownMenuItem(
        child: Text(val),
        value: val,
      ));
    }
    return values;
  }

  @override
  Widget build(BuildContext context) {
    void currency(String money1) async {
      http.Response data1 = await http.get(Uri.parse(
          'https://rest.coinapi.io/v1/exchangerate/BTC/$money?apikey=BAC76DDC-8E6A-442A-B674-D29BE78CF676'));
      var data11 = data1.body;
      http.Response data2 = await http.get(Uri.parse(
          'https://rest.coinapi.io/v1/exchangerate/ETH/$money?apikey=BAC76DDC-8E6A-442A-B674-D29BE78CF676'));
      var data22 = data2.body;
      http.Response data3 = await http.get(Uri.parse(
          'https://rest.coinapi.io/v1/exchangerate/LTC/$money?apikey=BAC76DDC-8E6A-442A-B674-D29BE78CF676'));
      var data33 = data3.body;
      setState(() {
        btc = jsonDecode(data11)['rate'].toStringAsFixed(1);

        eth = jsonDecode(data22)['rate'].toStringAsFixed(1);

        ltc = jsonDecode(data33)['rate'].toStringAsFixed(1);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Flexible(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
              child: Card(
                color: Colors.lightBlueAccent,
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                  child: Text(
                    '1 BTC =' + btc.toString() + ' ' + money,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
              child: Card(
                color: Colors.lightBlueAccent,
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                  child: Text(
                    '1 ETH =' + eth.toString() + ' ' + money,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
              child: Card(
                color: Colors.lightBlueAccent,
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                  child: Text(
                    '1 LTC =' + ltc.toString() + ' ' + money,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Flexible(
              flex: 20,
              child: SizedBox(
                height: 350,
              )),
          Flexible(
            flex: 10,
            child: Container(
                height: 150.0,
                alignment: Alignment.center,
                padding: EdgeInsets.only(bottom: 30.0),
                color: Colors.lightBlue,
                child: DropdownButton(
                  value: money,
                  items: list(),
                  onChanged: (value) {
                    setState(() {
                      money = value.toString();
                      currency(money);
                    });
                  },
                )),
          ),
        ],
      ),
    );
  }
}

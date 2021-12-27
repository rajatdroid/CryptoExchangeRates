
import 'dart:convert';
import 'dart:io';

import 'package:bitcointicker/coin_data.dart';
import 'package:bitcointicker/customwidgets/_constants.dart';
import 'package:bitcointicker/customwidgets/_customui.dart';
import 'package:bitcointicker/models/_exchangeresponse.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class CryptoHome extends StatelessWidget {
  const CryptoHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('bitcoin ticker'),
        centerTitle: true,
      ),
      body: ScaffoldBody(),
    );
  }
}

class ScaffoldBody extends StatefulWidget {
  @override
  _ScaffoldBodyState createState() => _ScaffoldBodyState();
}

class _ScaffoldBodyState extends State<ScaffoldBody> {

  String currency = currenciesList[0];
  double btcConversion = 0;
  double ethConversion = 0;
  double ltcConversion =0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getConversions();
  }

  void getConversions() async{
    var btcValue =  await getExchangeRate(cryptoList[0], currency) ;
    var ethVal = await getExchangeRate(cryptoList[1], currency) ;
    var ltcVal = await getExchangeRate(cryptoList[2], currency);
    setState(() {
      ethConversion = ethVal;
      btcConversion = btcValue;
      ltcConversion = ltcVal;
    });

  }


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Column(
          children: [
            BlueRoundedButton(color: Colors.blue,
              child: Text(
                'BTC  = $btcConversion  $currency',
                style: kWhiteText20,
              ),
            ),

            BlueRoundedButton(color: Colors.blue,
              child: Text(
                'ETH = $ethConversion $currency',
                style: kWhiteText20,
              ),
            ),

            BlueRoundedButton(color: Colors.blue,
              child: Text(
                'LTC = $ltcConversion $currency',
                style: kWhiteText20,
              ),
            )
          ],
        ),

        Container(
            color: Colors.blue,
            alignment: Alignment.center,
            height: 70,
            child: Platform.isAndroid ? getAndroidDropDown() : getIOSDropDown()
        )
      ],


    );
  }

  Widget getAndroidDropDown(){
    return DropdownButton(
      dropdownColor: Colors.lightGreen,
      value: currency,
      elevation: 16,
      underline: Container(
        color: Colors.white,
        height: 1,
      ),
      onChanged: (String? str) {
        setBackToDefault();
        setState(() {
          currency = str!;
          getConversions();
        });
      },
      items: currenciesList.map((e) => DropdownMenuItem(
        value: e,
        child: Text(e,
          style: kWhiteText20,
        ),
      ),
      ).toList(),

    );
  }

  Widget getIOSDropDown(){
    return CupertinoPicker(itemExtent: 10, onSelectedItemChanged: (int ? pos) {
      setState(() {
        currency = currenciesList[pos!];
      });
    },
        backgroundColor: Colors.green,
        children: currenciesList.map((String e) => Text(e)).toList()
    );
  }

  void setBackToDefault(){
    setState(() {
      ethConversion = 0;
      ltcConversion = 0;
      btcConversion = 0;
    });
  }

}

Future<double> getExchangeRate(String base, String currency) async{

  var url = Uri.parse('https://rest.coinapi.io/v1/exchangerate/$base/$currency/?apikey=$apiKey');
  var response = await http.get(url);

  debugPrint('response is ${response.body}');
  var exchangeRate = ExchangeRate.getFromJson(json.decode(response.body));
  return exchangeRate.rate!;
}






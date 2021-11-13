import 'package:flutter/material.dart';

class CoinDetails extends StatefulWidget {
  dynamic id = null;
  dynamic symbol = null;
  dynamic name = null;
  dynamic image = null;
  dynamic current_price = null;
  dynamic market_cap = null;
  dynamic market_cap_rank = null;
  dynamic high_24h = null;
  dynamic low_24h = null;
  dynamic price_change_24h = null;
  dynamic price_change_percentage_24h = null;
  CoinDetails({Key? key,
    @required this.id,
    @required this.symbol,
    @required this.name,
    @required this.image,
    @required this.current_price,
    @required this.market_cap,
    @required this.market_cap_rank,
    @required this.high_24h,
    @required this.low_24h,
    @required this.price_change_24h,
    @required this.price_change_percentage_24h
  }) : super(key: key);

  @override
  _CoinDetailsState createState() => _CoinDetailsState();
}

class _CoinDetailsState extends State<CoinDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CryptoWallet'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Text(widget.name),
          ],
        ),
      ),
    );
  }
}

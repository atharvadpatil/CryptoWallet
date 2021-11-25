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
  TextEditingController _textFieldController = TextEditingController();
  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add TO Wallet'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "Enter Amount"),
            ),
            actions: <Widget>[
              FlatButton(
                color: Colors.red,
                textColor: Colors.white,
                child: Text('CANCEL'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              FlatButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text('ADD'),
                onPressed: () {
                  setState(() {
                    codeDialog = valueText;
                    setState(() {
                      valueText = "";
                    });
                    Navigator.pop(context);
                    print(codeDialog);
                  });
                },
              ),
            ],
          );
        });
  }

  String codeDialog="";
  String valueText="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CryptoWallet'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: CircleAvatar(
                radius: 60.0,
                backgroundImage: NetworkImage('https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579'),
              ),
            ),
            SizedBox(height: 40.0),
            Row(
              children: <Widget>[
                Text(
                  'Symbol:',
                  style: TextStyle(
                    fontSize: 18.0,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 10.0),
                Text(
                  'btc',
                  style: TextStyle(
                    fontSize: 18.0,
                    letterSpacing: 1.0,
                  ),
                )
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              children: <Widget>[
                Text(
                  'Name:',
                  style: TextStyle(
                    fontSize: 18.0,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 10.0),
                Text(
                  'Bitcoin',
                  style: TextStyle(
                    fontSize: 18.0,
                    letterSpacing: 1.0,
                  ),
                )
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              children: <Widget>[
                Text(
                  'Current Price:',
                  style: TextStyle(
                    fontSize: 18.0,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 10.0),
                Text(
                  '4000000',
                  style: TextStyle(
                    fontSize: 18.0,
                    letterSpacing: 1.0,
                  ),
                )
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              children: <Widget>[
                Text(
                  'Market Cap:',
                  style: TextStyle(
                    fontSize: 18.0,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 10.0),
                Text(
                  '200000000',
                  style: TextStyle(
                    fontSize: 18.0,
                    letterSpacing: 1.0,
                  ),
                )
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              children: <Widget>[
                Text(
                  'Market Cap Rank:',
                  style: TextStyle(
                    fontSize: 18.0,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 10.0),
                Text(
                  '1',
                  style: TextStyle(
                    fontSize: 18.0,
                    letterSpacing: 1.0,
                  ),
                )
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              children: <Widget>[
                Text(
                  '24h High:',
                  style: TextStyle(
                    fontSize: 18.0,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 10.0),
                Text(
                  '4100000',
                  style: TextStyle(
                    fontSize: 18.0,
                    letterSpacing: 1.0,
                  ),
                )
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              children: <Widget>[
                Text(
                  '24h Low:',
                  style: TextStyle(
                    fontSize: 18.0,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 10.0),
                Text(
                  '3900000',
                  style: TextStyle(
                    fontSize: 18.0,
                    letterSpacing: 1.0,
                  ),
                )
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              children: <Widget>[
                Text(
                  'Price Change in 24h:',
                  style: TextStyle(
                    fontSize: 18.0,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 10.0),
                Text(
                  '100000',
                  style: TextStyle(
                    fontSize: 18.0,
                    letterSpacing: 1.0,
                  ),
                )
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              children: <Widget>[
                Text(
                  '% Price change in 24h:',
                  style: TextStyle(
                    fontSize: 18.0,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 10.0),
                Text(
                  '1%',
                  style: TextStyle(
                    fontSize: 18.0,
                    letterSpacing: 1.0,
                  ),
                )
              ],
            ),
            SizedBox(height: 40.0),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                ),
                onPressed: () {
                  _displayTextInputDialog(context);
                },
                child: Text("Add To Wallet".toUpperCase(), style: TextStyle(fontSize: 14)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

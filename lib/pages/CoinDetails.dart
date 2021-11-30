import 'package:cryptowallet/main.dart';
import 'package:cryptowallet/net/flutterfire.dart';
import 'package:cryptowallet/pages/WatchList.dart';
import 'package:flutter/material.dart';
import '../globals.dart' as globals;

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
            title: Text('Add To Wallet'),
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
                  _textFieldController.clear();
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              FlatButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text('ADD'),
                onPressed: () async{
                  setState(() {
                    codeDialog = valueText;
                    _textFieldController.clear();
                    Navigator.pop(context);
                  });
                  bool added = await addCoin(widget.id, codeDialog);
                  if(added){
                    globals.selectedIndex=2;
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyStatefulWidget()));
                  }
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
    Color pcolor = widget.price_change_percentage_24h>0 ? Colors.green : Colors.red;
    Color ccolor = widget.price_change_24h>0 ? Colors.green : Colors.red;
    return Scaffold(
      appBar: AppBar(
        title: Text('CryptoWallet'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: CircleAvatar(
                  radius: 60.0,
                  backgroundImage: NetworkImage(widget.image),
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
                    widget.symbol,
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
                    widget.name,
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
                    '₹'+widget.current_price.toString(),
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
                    '₹'+widget.market_cap.toString(),
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
                    widget.market_cap_rank.toString(),
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
                    '₹'+widget.high_24h.toString(),
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
                    '₹'+widget.low_24h.toString(),
                    style: TextStyle(
                      fontSize: 18.0,
                      letterSpacing: 1.0,
                    ),
                  )
                ],
              ),
              SizedBox(height: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Price Change in 24h:',
                    style: TextStyle(
                      fontSize: 18.0,
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    '₹'+widget.price_change_24h.toString(),
                    style: TextStyle(
                      fontSize: 18.0,
                      letterSpacing: 1.0,
                      color: ccolor,
                    ),
                  )
                ],
              ),
              SizedBox(height: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Percent Price change in 24h:',
                    style: TextStyle(
                      fontSize: 18.0,
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    widget.price_change_percentage_24h.toString()+"%",
                    style: TextStyle(
                      fontSize: 18.0,
                      letterSpacing: 1.0,
                      color: pcolor,
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
      ),
    );
  }
}

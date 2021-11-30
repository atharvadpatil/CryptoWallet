import 'package:cryptowallet/net/flutterfire.dart';
import 'package:flutter/material.dart';
import '../pages/CoinDetails.dart';
import '../globals.dart' as globals;

class WalletCard extends StatefulWidget {
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
  dynamic wallet_count = null;
  WalletCard({Key? key,
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
    @required this.price_change_percentage_24h,
    @required this.wallet_count,
  }) : super(key: key);

  @override
  _WalletCardState createState() => _WalletCardState();
}

class _WalletCardState extends State<WalletCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: (){
          Navigator.push( context,
              MaterialPageRoute(builder: (context) => CoinDetails(
                id: widget.id,
                symbol: widget.symbol,
                name: widget.name,
                image: widget.image,
                current_price: widget.current_price,
                market_cap: widget.market_cap,
                market_cap_rank: widget.market_cap_rank,
                high_24h: widget.high_24h,
                low_24h: widget.low_24h,
                price_change_24h: widget.price_change_24h,
                price_change_percentage_24h: widget.price_change_percentage_24h,
              )));
        },
        onLongPress: () async {
          await removeFromWallet(widget.id, context);
        },
        child: Column(
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(widget.image)),
              title: Text(widget.name),
              subtitle: Text("NET QTY :" + widget.wallet_count.toString()),
              trailing: Text('CRP: ₹'+ (widget.wallet_count * widget.current_price).toStringAsFixed(3)),
            )
          ],
        ),
      ),
    );
  }
}

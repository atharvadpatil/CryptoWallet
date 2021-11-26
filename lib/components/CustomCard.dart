import 'package:cryptowallet/net/flutterfire.dart';
import 'package:flutter/material.dart';
import '../pages/CoinDetails.dart';
import '../globals.dart' as globals;


class CustomCard extends StatefulWidget {
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
  CustomCard({Key? key,
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
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {

  @override
  Widget build(BuildContext context) {
    Color pcolor = widget.price_change_percentage_24h>0 ? Colors.green : Colors.red;
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
          if(globals.selectedIndex==0) {
            await addToWatchList(widget.id, context);
          }
          if(globals.selectedIndex==1){
            await removeFromWatchList(widget.id, context);
          }
        },
        child: Column(
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(widget.image)),
              title: Text(widget.name),
              subtitle: Text(widget.price_change_percentage_24h.toString()+"%",
                style: TextStyle(
                  color: pcolor,
                ),
              ),
              trailing: Text('Price: ₹'+widget.current_price.toString()),
            )
          ],
        ),
      ),
    );
  }
}

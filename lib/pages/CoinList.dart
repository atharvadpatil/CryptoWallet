import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../components/CustomCard.dart';

class CoinList extends StatefulWidget {
  const CoinList({Key? key}) : super(key: key);

  @override
  _CoinListState createState() => _CoinListState();
}

class _CoinListState extends State<CoinList> {
  final String apiUrl = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=inr&order=market_cap_desc&per_page=100&page=1&sparkline=false";
  var typing = false;
  var searchCoin = "";
  final myController = TextEditingController();

  Future<List<dynamic>> fetchCoins() async {
    var url = Uri.parse(apiUrl);
    var response = await http.get(url);
    if(typing==false){
      return json.decode(response.body);
    }
    else {
      List<dynamic> res = json.decode(response.body);
      List<dynamic> filteredData = [];
      for (var data in res) {
        if (data['id'].contains(searchCoin)) {
          filteredData.add(data);
        }
        else {
          continue;
        }
      }
      return filteredData;
    }
  }

  Widget TextBox() {
    return Container(
      alignment: Alignment.centerLeft,
      color: Colors.white,
      child: TextFormField(
        onChanged: (text){
          setState(() {
            searchCoin=text;
          });
        },
        controller: myController,
        decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            hintText: 'Search'
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: typing ? TextBox() : Text(""),
        leading: IconButton(
          icon: Icon(typing ? Icons.arrow_back_ios  : Icons.search,
          color: Colors.black,
          ),
          onPressed: () {
            setState(() {
              typing = !typing;
            });
          },
        ),
      ),
      body: Container(
        child: FutureBuilder<List<dynamic>>(
          future: fetchCoins(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  padding: EdgeInsets.all(8),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CustomCard(
                        id: snapshot.data[index]['id'],
                        symbol: snapshot.data[index]['symbol'],
                        name: snapshot.data[index]['name'],
                        image: snapshot.data[index]['image'],
                        current_price: snapshot.data[index]['current_price'],
                        market_cap: snapshot.data[index]['market_cap'],
                        market_cap_rank: snapshot.data[index]['market_cap_rank'],
                        high_24h: snapshot.data[index]['high_24h'],
                        low_24h: snapshot.data[index]['low_24h'],
                        price_change_24h: snapshot.data[index]['price_change_24h'],
                        price_change_percentage_24h: snapshot.data[index]['price_change_percentage_24h']
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}


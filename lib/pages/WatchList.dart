import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../components/CustomCard.dart';

class Watchlist extends StatefulWidget {
  const Watchlist({Key? key}) : super(key: key);

  @override
  _WatchlistState createState() => _WatchlistState();
}

class _WatchlistState extends State<Watchlist> {
  List<dynamic> watchlist=[];
  final String apiUrl = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=inr&order=market_cap_desc&per_page=100&page=1&sparkline=false";
  @override
  void initState() {
    super.initState();
    String uid = FirebaseAuth.instance.currentUser.uid;
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('Users')
        .doc(uid);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documentReference);
      if (snapshot.exists) {
        setState((){
          watchlist = snapshot.data()['Watchlist'];
        });
      }
    });
  }

  Future<List<dynamic>> fetchCoins() async {
    var url = Uri.parse(apiUrl);
    var response = await http.get(url);
    List<dynamic> res = json.decode(response.body);
    List<dynamic> filteredData = [];
    for (var data in res) {
      if (watchlist.contains(data['id'])) {
        filteredData.add(data);
      }
      else {
        continue;
      }
    }
    return filteredData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

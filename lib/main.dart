import 'package:cryptowallet/net/flutterfire.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'pages/authentication.dart';
import 'pages/CoinList.dart';
import 'pages/WatchList.dart';
import 'pages/Wallet.dart';
import 'package:firebase_core/firebase_core.dart';
import 'globals.dart' as globals;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CryptoWallet',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: Authentication(),
      routes: {
        '/home': (context)=>MyStatefulWidget(),
        '/Authentication':(context)=>Authentication(),

      },
    );
  }
}
//testing
class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}


class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  String currentUser = FirebaseAuth.instance.currentUser.email;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    CoinList(),
    Watchlist(),
    Wallet(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      globals.selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CryptoWallet'),
        centerTitle: true,
      ),
      body: Center(
        child: _widgetOptions.elementAt(globals.selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.checklist),
            label: 'WatchList',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet ),
            label: 'Wallet',
          ),
        ],
        currentIndex: globals.selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
      drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("welcome ", style: TextStyle(color: Colors.white, fontSize: 22)),
                        Text(currentUser, style: TextStyle(color: Colors.white, fontSize: 18, letterSpacing:1.5)),
                      ],
                    ),
                    CircleAvatar(
                      child: Image.network('https://www.shareicon.net/data/512x512/2017/01/06/868320_people_512x512.png'),
                      radius: 40,
                    ),
                  ],
                ),
              ),
              ListTile(
                  leading: Icon(Icons.login, color: Colors.black),
                  title: Text("Logout"),
                  onTap: () async {
                    await signOut();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => Authentication(),
                      ), (route) => false,
                    );
                  }),
            ],
          )),
    );
  }
}
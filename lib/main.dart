import 'package:cryptowallet/net/flutterfire.dart';
import 'package:flutter/material.dart';
import 'pages/authentication.dart';
import 'pages/CoinList.dart';
import 'pages/WatchList.dart';
import 'pages/Wallet.dart';
import 'package:firebase_core/firebase_core.dart';


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
      title: 'Rest API Demo',
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
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    CoinList(),
    Watchlist(),
    Wallet(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
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
        child: _widgetOptions.elementAt(_selectedIndex),
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
        currentIndex: _selectedIndex,
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
                    Icon(Icons.person),
                    Text("welcome guest", style: TextStyle(color: Colors.white, fontSize: 18)),
                    CircleAvatar(
                      child: Image.network('https://cdn3.iconfinder.com/data/icons/vector-icons-6/96/256-512.png'),
                      radius: 40,
                    ),
                  ],
                ),
              ),
              ListTile(
                  leading: Icon(Icons.login, color: Colors.black),
                  title: Text("Logout"),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/Authentication');
                  }),
            ],
          )),
    );
  }
}
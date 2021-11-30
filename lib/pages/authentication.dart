import 'package:flutter/material.dart';
import 'CoinList.dart';
import 'package:cryptowallet/net/flutterfire.dart';
import '/main.dart';
class Authentication extends StatefulWidget {
  Authentication({Key? key}) : super(key: key);

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {

  TextEditingController _emailField = TextEditingController();
  TextEditingController _passwordField = TextEditingController();
  
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CryptoWallet'),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.blueAccent,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 1.3,
              child: Text(
                'Login/Register',
                style: TextStyle(
                  color: Colors.white,
                    fontSize: 24,
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 15),
            Container(
              width: MediaQuery.of(context).size.width / 1.3,
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                controller: _emailField,
                decoration: InputDecoration(
                  hintText: "Enter Email",
                  hintStyle: TextStyle(
                    color: Colors.white38,
                  ),
                  labelText: "Email",
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 35),
            Container(
              width: MediaQuery.of(context).size.width / 1.3,
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                controller: _passwordField,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "password",
                  hintStyle: TextStyle(
                    color: Colors.white38,
                  ),
                  labelText: "Password",
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 35),
            Container(
              width: MediaQuery.of(context).size.width / 1.4,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.white,
              ),
              child: MaterialButton(
                onPressed: () async {
                  int shouldNavigate =
                      await register(_emailField.text, _passwordField.text);
                  if (shouldNavigate==0) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyStatefulWidget(),
                      ),
                    );
                  }
                  else{
                    var text="";
                    if(shouldNavigate==1){
                      text = "The password provided is too weak";
                    }
                    else if(shouldNavigate==2){
                      text = "The account already exists for that email";
                    }
                    else{
                      text = "Something went wrong";
                    }
                    final snackBar1 = SnackBar(
                      duration: Duration(seconds: 500),
                      content: Text(text),
                      action: SnackBarAction(
                        label: 'Dismiss',
                        onPressed: (){},
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar1);
                  }
                },
                child: Text("Register"),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 35),
            Container(
              width: MediaQuery.of(context).size.width / 1.4,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.white,
              ),
              child: MaterialButton(
                  onPressed: () async {
                    bool shouldNavigate =
                        await signIn(_emailField.text, _passwordField.text);
                    if (shouldNavigate) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyStatefulWidget(),
                        ),
                      );
                    }
                    else{
                      final text = "Invalid Email or Password";
                      final snackBar = SnackBar(
                          duration: Duration(seconds: 500),
                          content: Text(text),
                          action: SnackBarAction(
                            label: 'Dismiss',
                            onPressed: (){},
                          ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: Text("Login")),
            ),
          ],
        ),
      ),
    );
  }
}
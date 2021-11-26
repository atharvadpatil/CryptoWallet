import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryptowallet/main.dart';
import 'package:cryptowallet/pages/WatchList.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../globals.dart' as globals;

Future<bool> signIn(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<bool> register(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
    return false;
  } catch (e) {
    print(e.toString());
    return false;
  }
}

Future<void> signOut() async
{
  try{
    await FirebaseAuth.instance.signOut();
  }
  catch(e)
  {
    print(e.toString());
  }
}

Future<void> addToWatchList(String id, BuildContext context) async{
  String uid = FirebaseAuth.instance.currentUser.uid;
  DocumentReference documentReference = FirebaseFirestore.instance
      .collection('Users')
      .doc(uid);
  FirebaseFirestore.instance.runTransaction((transaction) async {
    DocumentSnapshot snapshot = await transaction.get(documentReference);
    if (!snapshot.exists) {
      documentReference.set({'Watchlist': [id]});
    }
    else {
      List<dynamic> newWatchlist = snapshot.data()['Watchlist'];
      if(newWatchlist.contains(id)){
        newWatchlist=newWatchlist;
        print("Already present in watchlist");
      }
      else{
        newWatchlist.add(id);
      }
      transaction.update(documentReference, {'Watchlist': newWatchlist});
    }
  })
  .then((value) {
    globals.selectedIndex=1;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyStatefulWidget()),
    );
  })
  .catchError((e) {
    print("Coin is not added to watchlist");
  });
}


// Future<List<dynamic>> readCurrentUserWatchlist() async{
//   String uid = FirebaseAuth.instance.currentUser.uid;
//   DocumentReference documentReference = FirebaseFirestore.instance
//       .collection('Users')
//       .doc(uid);
//   List<dynamic> watchlist=[];
//   FirebaseFirestore.instance.runTransaction((transaction) async {
//     DocumentSnapshot snapshot = await transaction.get(documentReference);
//     if (snapshot.exists) {
//       watchlist = snapshot.data()['Watchlist'];
//       print(watchlist);
//       return watchlist;
//     }
//   });
//   return watchlist;
// }

Future<void> removeFromWatchList(String id, BuildContext context) async{
  String uid = FirebaseAuth.instance.currentUser.uid;
  DocumentReference documentReference = FirebaseFirestore.instance
      .collection('Users')
      .doc(uid);
  FirebaseFirestore.instance.runTransaction((transaction) async {
    DocumentSnapshot snapshot = await transaction.get(documentReference);
    List<dynamic> newWatchlist = snapshot.data()['Watchlist'];
    bool removed = newWatchlist.remove(id);
    transaction.update(documentReference, {'Watchlist': newWatchlist});
  }).then((value) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyStatefulWidget()),
    );
  }).catchError((e) {
    print("Error");
  });
}

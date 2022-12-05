import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/model/Bible.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BibleState extends ChangeNotifier{
  BibleState(){
    init();
  }

  int randomNumber = 0;
  bool isBibleReady = false;

  StreamSubscription<QuerySnapshot>? _bibleSubscription;

  List<Bible> _bible = [];

  Bible get_bible(){
    if (isBibleReady)
      return _bible[randomNumber];
    else
      return Bible(
        script: "Connecting...",
        title: "",
        bbC: ""
      );
  }

  Future<void> init() async{
    final prefs = await SharedPreferences.getInstance();
    final bibleColor = prefs.getString('bibleColor')??'green';

    FirebaseAuth.instance.userChanges().listen((user){
      if(user != null){
        _bibleSubscription = FirebaseFirestore.instance
            .collection('bible')
            .snapshots()
            .listen((snapshot)async{
           _bible = [];
           for(final document in snapshot.docs){
             Bible bible = Bible(
               title: document.data()['title'] as String,
               script: document.data()['script'] as String,
               bbC: bibleColor
             );
             _bible.add(bible);
           }
           randomNumber = Random().nextInt(_bible.length);
           isBibleReady = true;
           notifyListeners();
        });
      }
    });
  }
}
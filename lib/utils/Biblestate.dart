import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/model/Bible.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
        title: ""
      );
  }

  Future<void> init() async{
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
               script: document.data()['script'] as String
             );
             print(bible.script);
             print(bible.title);
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
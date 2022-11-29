import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/model/Bible.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BibleState extends ChangeNotifier{
  BibleState(){
    init();
  }

  StreamSubscription<QuerySnapshot>? _bibleSubscription;

  List<Bible> _bible = [];

  List<Bible> get bible => _bible;

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
           notifyListeners();
        });
      }
    });
  }
}
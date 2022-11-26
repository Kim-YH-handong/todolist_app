import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/firebase_options.dart';
import 'package:final_project/model/Todo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class TodoState extends ChangeNotifier {
  TodoState() {
    init();
  }

  StreamSubscription<QuerySnapshot>? _todoSubscription;

  List<Todo> _todo = [];

  List<Todo> get todo => _todo;

  Future<void> init() async {
    print("Work");
    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _todoSubscription = FirebaseFirestore.instance
            .collection('user')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .collection('todo')
            .snapshots()
            .listen((snapshot) async {
          _todo = [];
          for (final document in snapshot.docs) {
            print(
                "Todo Listner: ${document.data()['title'] as String} is added to _todo");
            _todo.add(Todo(
              title: document.data()['title'] as String,
              memo: document.data()['memo'] as String,
              endDate: document.data()['endDate'] as String,
              important: document.data()['important'],
              isEnd: document.data()['isEnd'],
            ));
          }
          notifyListeners();
        });
      }
    });
  }
}

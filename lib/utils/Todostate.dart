import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/firebase_options.dart';
import 'package:final_project/model/Todo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodoState extends ChangeNotifier {
  TodoState() {
    init();
  }

  StreamSubscription<QuerySnapshot>? _todoSubscription;

  List<Todo> _todo = [];
  List<Todo> _todayTodo = [];
  List<Todo> _tommorrowTodo = [];
  List<Todo> _restTodo = [];
  List<Todo> _importantTodo = [];

  List<Todo> get todo => _todo;

  List<Todo> get todayTodo => _todayTodo;

  List<Todo> get tomorrowTodo => _tommorrowTodo;

  List<Todo> get restTodo => _restTodo;

  List<Todo> get importantTodo => _importantTodo;

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
          DateTime todayDateTime =
              DateTime.parse(DateFormat("yyyy-MM-dd").format(DateTime.now()));
          DateTime tommorrowDateTime = DateTime.parse(DateFormat("yyyy-MM-dd")
              .format(DateTime(todayDateTime.year, todayDateTime.month,
                  todayDateTime.day + 1)));
          _todo = [];
          _todayTodo = [];
          _tommorrowTodo = [];
          _restTodo = [];
          for (final document in snapshot.docs) {
            print(
                "Todo Listner: ${document.data()['title'] as String} is added to _todo");
            Todo todo = Todo(
              title: document.data()['title'] as String,
              memo: document.data()['memo'] as String,
              endDate: document.data()['endDate'] as String,
              important: document.data()['important'],
              isEnd: document.data()['isEnd'],
            );
            if (todayDateTime.compareTo(DateTime.parse(todo.endDate)) == 0) {
              todayTodo.add(todo);
            } else if (tommorrowDateTime
                    .compareTo(DateTime.parse(todo.endDate)) ==
                0) {
              tomorrowTodo.add(todo);
            } else if (todo.isEnd == false) {
              restTodo.add(todo);
              /*
              * 기간이 이미 지난거면 Done이라는 Collection만들어서 거기로 이동시킬까?
              * 이동시키고 todo collection에 있는거는 삭제해버리기.
              * */
            }
            if (todo.isEnd == false && todo.important == true) {
              _importantTodo.add(todo);
            }
            _todo.add(todo);
          }
          notifyListeners();
        });
      }
    });
  }
}

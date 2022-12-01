import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/style/palette.dart';
import 'package:final_project/utils/Todostate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe_plus/swipe_plus.dart';

class PlanPage extends StatefulWidget {
  const PlanPage({Key? key}) : super(key: key);

  @override
  _PlanPageState createState() => _PlanPageState();
}

class _PlanPageState extends State<PlanPage> {
  String _selectedMenu = '';

  @override
  Widget build(BuildContext context) {
    var palette = Palette();
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: palette.weakRed,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: palette.weakRed,
        centerTitle: false,
        title: Text(
          '계획된 일정',
          style: TextStyle(
            fontFamily: 'Work Sans',
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: palette.strongRed,
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, color: palette.strongRed)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(20, 15, 0, 8),
            child: Text(
              '오늘',
              style: TextStyle(
                color: Color(0xff9D3333),
                fontFamily: 'Work Sans',
                fontWeight: FontWeight.w100,
                fontSize: 20,
              ),
            ),
          ),
          Expanded(
            child: Consumer<TodoState>(builder: (context, todo, child) {
              return ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                        title: SwipePlus(
                          onDragComplete: (){
                            FirebaseFirestore.instance
                                .collection('user')
                                .doc(FirebaseAuth.instance.currentUser?.uid)
                                .collection('todo')
                                .doc(todo.todayTodo[index].documentId)
                                .delete();
                          },
                          child: Container(
                      decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: palette.strongRed,
                            ),
                            borderRadius: BorderRadius.circular(5)),
                      child: ListTile(
                          contentPadding: EdgeInsets.all(5),
                          //leading. 타일 앞에 표시되는 위젯. 참고로 타일 뒤에는 trailing 위젯으로 사용 가능
                          leading: IconButton(
                            onPressed: () {
                              FirebaseFirestore.instance
                                  .collection('user')
                                  .doc(FirebaseAuth.instance.currentUser?.uid)
                                  .collection('todo')
                                  .doc(todo.todayTodo[index].documentId)
                                  .delete();
                            },
                            icon: const Icon(
                              Icons.circle_outlined,
                              size: 22,
                            ),
                          ),
                          title: GestureDetector(
                            onTap: () {
                              print("GOTO DETAIL");
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${todo.todayTodo[index].title}',
                                  style: TextStyle(
                                      color: palette.dark,
                                      fontSize: height * 0.02,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${todo.todayTodo[index].endDate} (오늘)까지',
                                  style: TextStyle(
                                    color: palette.strongRed,
                                    fontFamily: 'Work Sans',
                                    fontSize: height * 0.015,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          trailing: todo.todayTodo[index].important
                              ? IconButton(
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection('user')
                                        .doc(FirebaseAuth.instance.currentUser?.uid)
                                        .collection('todo')
                                        .doc(todo.todayTodo[index].documentId)
                                        .update({
                                      'important' : false
                                    });
                                  },
                                  icon: Icon(
                                    Icons.star,
                                    color: palette.strongRed,
                                  ))
                              : IconButton(
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection('user')
                                        .doc(FirebaseAuth.instance.currentUser?.uid)
                                        .collection('todo')
                                        .doc(todo.todayTodo[index].documentId)
                                        .update({
                                      'important' : true
                                    });
                                  },
                                  icon: Icon(
                                    Icons.star_border_outlined,
                                    color: palette.strongRed,
                                  )),
                          onTap: () {},
                      ),
                    ),
                        ));
                  },
                  itemCount: todo.todayTodo.length);
            }),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 15, 0, 8),
            child: Text(
              '내일',
              style: TextStyle(
                color: Color(0xff9D3333),
                fontFamily: 'Work Sans',
                fontWeight: FontWeight.w100,
                fontSize: 20,
              ),
            ),
          ),
          Expanded(
            child: Consumer<TodoState>(builder: (context, todo, child) {
              return ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                        title: SwipePlus(
                          onDragComplete: (){
                            FirebaseFirestore.instance
                                .collection('user')
                                .doc(FirebaseAuth.instance.currentUser?.uid)
                                .collection('todo')
                                .doc(todo.tomorrowTodo[index].documentId)
                                .delete();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: palette.strongRed,
                                ),
                                borderRadius: BorderRadius.circular(5)),
                            child: ListTile(
                              contentPadding: EdgeInsets.all(5),
                              //leading. 타일 앞에 표시되는 위젯. 참고로 타일 뒤에는 trailing 위젯으로 사용 가능
                              leading: IconButton(
                                onPressed: () {
                                  FirebaseFirestore.instance
                                      .collection('user')
                                      .doc(FirebaseAuth.instance.currentUser?.uid)
                                      .collection('todo')
                                      .doc(todo.tomorrowTodo[index].documentId)
                                      .delete();
                                },
                                icon: const Icon(
                                  Icons.circle_outlined,
                                  size: 22,
                                ),
                              ),
                              title: GestureDetector(
                                onTap: () {
                                  print("GOTO DETAIL");
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${todo.tomorrowTodo[index].title}',
                                      style: TextStyle(
                                          color: palette.dark,
                                          fontSize: height * 0.02,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '${todo.tomorrowTodo[index].endDate} (내일)까지',
                                      style: TextStyle(
                                        color: palette.strongRed,
                                        fontFamily: 'Work Sans',
                                        fontSize: height * 0.015,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              trailing: todo.tomorrowTodo[index].important
                                  ? IconButton(
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection('user')
                                        .doc(FirebaseAuth.instance.currentUser?.uid)
                                        .collection('todo')
                                        .doc(todo.tomorrowTodo[index].documentId)
                                        .update({
                                      'important' : false
                                    });
                                  },
                                  icon: Icon(
                                    Icons.star,
                                    color: palette.strongRed,
                                  ))
                                  : IconButton(
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection('user')
                                        .doc(FirebaseAuth.instance.currentUser?.uid)
                                        .collection('todo')
                                        .doc(todo.tomorrowTodo[index].documentId)
                                        .update({
                                      'important' : true
                                    });
                                  },
                                  icon: Icon(
                                    Icons.star_border_outlined,
                                    color: palette.strongRed,
                                  )),
                              onTap: () {},
                            ),
                          ),
                        ));
                  },
                  itemCount: todo.tomorrowTodo.length);
            }),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 15, 0, 8),
            child: Text(
              '그 후',
              style: TextStyle(
                color: Color(0xff9D3333),
                fontFamily: 'Work Sans',
                fontWeight: FontWeight.w100,
                fontSize: 20,
              ),
            ),
          ),
          Expanded(
            child: Consumer<TodoState>(builder: (context, todo, child) {
              return ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                        title: SwipePlus(
                          onDragComplete: (){
                            FirebaseFirestore.instance
                                .collection('user')
                                .doc(FirebaseAuth.instance.currentUser?.uid)
                                .collection('todo')
                                .doc(todo.restTodo[index].documentId)
                                .delete();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: palette.strongRed,
                                ),
                                borderRadius: BorderRadius.circular(5)),
                            child: ListTile(
                              contentPadding: EdgeInsets.all(5),
                              //leading. 타일 앞에 표시되는 위젯. 참고로 타일 뒤에는 trailing 위젯으로 사용 가능
                              leading: IconButton(
                                onPressed: () {
                                  FirebaseFirestore.instance
                                      .collection('user')
                                      .doc(FirebaseAuth.instance.currentUser?.uid)
                                      .collection('todo')
                                      .doc(todo.restTodo[index].documentId)
                                      .delete();
                                },
                                icon: const Icon(
                                  Icons.circle_outlined,
                                  size: 22,
                                ),
                              ),
                              title: GestureDetector(
                                onTap: () {
                                  print("GOTO DETAIL");
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${todo.restTodo[index].title}',
                                      style: TextStyle(
                                          color: palette.dark,
                                          fontSize: height * 0.02,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '${todo.restTodo[index].endDate} 까지',
                                      style: TextStyle(
                                        color: palette.strongRed,
                                        fontFamily: 'Work Sans',
                                        fontSize: height * 0.015,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              trailing: todo.restTodo[index].important
                                  ? IconButton(
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection('user')
                                        .doc(FirebaseAuth.instance.currentUser?.uid)
                                        .collection('todo')
                                        .doc(todo.restTodo[index].documentId)
                                        .update({
                                      'important' : false
                                    });
                                  },
                                  icon: Icon(
                                    Icons.star,
                                    color: palette.strongRed,
                                  ))
                                  : IconButton(
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection('user')
                                        .doc(FirebaseAuth.instance.currentUser?.uid)
                                        .collection('todo')
                                        .doc(todo.restTodo[index].documentId)
                                        .update({
                                      'important' : true
                                    });
                                  },
                                  icon: Icon(
                                    Icons.star_border_outlined,
                                    color: palette.strongRed,
                                  )),
                              onTap: () {},
                            ),
                          ),
                        ));
                  },
                  itemCount: todo.restTodo.length);
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: palette.strongRed,
        onPressed: () => setState(() {
          Navigator.pushNamed(context, '/add');
        }),
        child: Icon(Icons.add),
      ),
    );
  }
}

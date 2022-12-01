import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/style/palette.dart';
import 'package:final_project/utils/Todostate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe_plus/swipe_plus.dart';

class RemarkPage extends StatefulWidget {
  const RemarkPage({Key? key}) : super(key: key);

  @override
  _RemarkPageState createState() => _RemarkPageState();
}

class _RemarkPageState extends State<RemarkPage> {
  String _selectedMenu = '';

  @override
  Widget build(BuildContext context) {
    var palette = Palette();
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: palette.weakPupple,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: palette.weakPupple,
        title: Text(
          '중요페이지',
          style: TextStyle(
            fontFamily: 'Work Sans',
            fontWeight: FontWeight.w600,
            fontSize: height*0.021,
            color: palette.strongPupple,
          ),
        ),
        centerTitle: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: palette.strongPupple,
            )),
      ),
      body: Consumer<TodoState>(builder: (context, todo, child) {
        return ListView.builder(
            itemBuilder: (context, index) {
              print(todo.importantTodo.length);
              return ListTile(
                  title: SwipePlus(
                    onDragComplete: (){
                      FirebaseFirestore.instance
                          .collection('user')
                          .doc(FirebaseAuth.instance.currentUser?.uid)
                          .collection('todo')
                          .doc(todo.importantTodo[index].documentId)
                          .delete();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: palette.strongPupple,
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
                                .doc(todo.importantTodo[index].documentId)
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
                                '${todo.importantTodo[index].title}',
                                style: TextStyle(
                                    color: palette.dark,
                                    fontSize: height * 0.02,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${todo.importantTodo[index].endDate} (오늘)까지',
                                style: TextStyle(
                                  color: palette.strongPupple,
                                  fontFamily: 'Work Sans',
                                  fontSize: height * 0.015,
                                ),
                              ),
                            ],
                          ),
                        ),
                        trailing: todo.importantTodo[index].important
                            ? IconButton(
                            onPressed: () {
                              FirebaseFirestore.instance
                                  .collection('user')
                                  .doc(FirebaseAuth.instance.currentUser?.uid)
                                  .collection('todo')
                                  .doc(todo.importantTodo[index].documentId)
                                  .update({
                                'important' : false
                              });
                            },
                            icon: Icon(
                              Icons.star,
                              color: palette.strongPupple,
                            ))
                            : IconButton(
                            onPressed: () {
                              FirebaseFirestore.instance
                                  .collection('user')
                                  .doc(FirebaseAuth.instance.currentUser?.uid)
                                  .collection('todo')
                                  .doc(todo.importantTodo[index].documentId)
                                  .update({
                                'important' : true
                              });
                            },
                            icon: Icon(
                              Icons.star_border_outlined,
                              color: palette.strongPupple,
                            )),
                        onTap: () {},
                      ),
                    ),
                  ));
            },
            itemCount: todo.importantTodo.length);
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: palette.strongPupple,
        onPressed: () => setState(() {
          Navigator.pushNamed(context, '/add');
        }),
        child: Icon(Icons.add),
      ),
    );
  }
}

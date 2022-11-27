import 'dart:ui';

import 'package:final_project/style/palette.dart';
import 'package:final_project/utils/Todostate.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

enum Menu { itemOne, itemTwo, itemThree, itemFour }

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  String _selectedMenu = '';
  String today = DateFormat("MM월 dd일 E.").format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    final todolist = context.watch<TodoState>();
    var palette = Palette();
    var height = MediaQuery.of(context).size.height;

    print(todolist.todayTodo);

    return Scaffold(
      backgroundColor: palette.weakBlue,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: palette.weakBlue,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, color: palette.strongBlue)),
        actions: <Widget>[
          PopupMenuButton<Menu>(
              icon: Icon(Icons.menu, color: Color(0xff037484)),
              // Callback that sets the selected popup menu item.
              onSelected: (Menu item) {
                setState(() {
                  _selectedMenu = item.name;
                });
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
                    PopupMenuItem<Menu>(
                      value: Menu.itemOne,
                      child: Row(
                        children: [
                          Icon(Icons.palette, color: palette.dark),
                          Text('테마 변경'),
                        ],
                      ),
                    ),
                    PopupMenuItem<Menu>(
                      value: Menu.itemTwo,
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle_rounded,
                            color: palette.dark,
                          ),
                          Text('완료한 일정 숨기기'),
                        ],
                      ),
                    ),
                  ]),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(height * 0.00),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(height * 0.015, 0, height * 0.015, 5),
              child: Text(
                '오늘 할 일',
                style: TextStyle(
                  color: palette.strongBlue,
                  fontFamily: 'Work Sans',
                  fontWeight: FontWeight.w600,
                  fontSize: height * 0.04,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(height * 0.015, 0, height * 0.015, 5),
              child: Text(
                '${today}',
                style: TextStyle(
                  color: palette.strongBlue,
                  fontFamily: 'Work Sans',
                  fontWeight: FontWeight.w300,
                  fontSize: height * 0.03,
                ),
              ),
            ),
            SizedBox(
              height: height * 0.03,
            ),
            Expanded(
              child: Consumer<TodoState>(builder: (context, todo, child) {
                return ListView.builder(
                    itemBuilder: (context, index) {
                      return ListTile(
                          title: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: palette.strongBlue,
                            ),
                            borderRadius: BorderRadius.circular(5)),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(5),
                          //leading. 타일 앞에 표시되는 위젯. 참고로 타일 뒤에는 trailing 위젯으로 사용 가능
                          leading: IconButton(
                            onPressed: () {},
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
                                    color: palette.strongBlue,
                                    fontFamily: 'Work Sans',
                                    fontSize: height * 0.015,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          trailing: todo.todayTodo[index].important
                              ? IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.star,
                                    color: palette.strongBlue,
                                  ))
                              : IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.star_border_outlined,
                                    color: palette.strongBlue,
                                  )),
                          onTap: () {},
                        ),
                      ));
                    },
                    itemCount: todo.todayTodo.length);
              }),
            )
            // listview_builder(todolist)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: palette.strongBlue,
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget listview_builder(todolist) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: todolist.todayTodo.length,
        itemBuilder: (BuildContext context, int index) {
          return Text("hello");
        });
  }
}

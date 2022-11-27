import 'package:final_project/style/palette.dart';
import 'package:final_project/utils/Todostate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum Menu { itemOne, itemTwo, itemThree, itemFour }

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
        actions: <Widget>[
          PopupMenuButton<Menu>(
              icon: Icon(Icons.menu, color: Color(0xff9D3333)),
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
                          Icon(Icons.palette, color: Colors.black),
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
                            color: Colors.black,
                          ),
                          Text('완료한 일정 숨기기'),
                        ],
                      ),
                    ),
                  ]),
        ],
        //bottom: PreferredSize(child: child, preferredSize: preferredSize), //여기에서 나중에 날짜별로 묶을 거임
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
                                    '${todo.tomorrowTodo[index].title}',
                                    style: TextStyle(
                                        color: palette.dark,
                                        fontSize: height * 0.02,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '${todo.tomorrowTodo[index].endDate} (내일)까지',
                                    style: TextStyle(
                                      color: palette.strongBlue,
                                      fontFamily: 'Work Sans',
                                      fontSize: height * 0.015,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            trailing: todo.tomorrowTodo[index].important
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
                                    '${todo.restTodo[index].title}',
                                    style: TextStyle(
                                        color: palette.dark,
                                        fontSize: height * 0.02,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '${todo.restTodo[index].endDate} 까지',
                                    style: TextStyle(
                                      color: palette.strongBlue,
                                      fontFamily: 'Work Sans',
                                      fontSize: height * 0.015,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            trailing: todo.restTodo[index].important
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

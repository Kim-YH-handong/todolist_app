import 'package:final_project/style/palette.dart';
import 'package:final_project/utils/Todostate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum Menu { itemOne, itemTwo, itemThree, itemFour }

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
        actions: <Widget>[
          PopupMenuButton<Menu>(
              icon: Icon(
                Icons.menu,
                color: Color(0xff863CC1),
              ),
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
      body: Consumer<TodoState>(builder: (context, todo, child) {
        return ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                  title: Container(
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
                                color: palette.strongPupple,
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
                            color: palette.strongPupple,
                          ))
                          : IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.star_border_outlined,
                            color: palette.strongPupple,
                          )),
                      onTap: () {},
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

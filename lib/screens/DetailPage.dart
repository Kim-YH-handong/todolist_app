import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/model/Todo.dart';
import 'package:final_project/style/palette.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';


/*
* Important 클릭시 바로 수정되어버림. 저장 안눌러도 important되어 있음.
* */
class DetailPageArguments{
  DetailPageArguments({required this.todo});
  final Todo todo;
}

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController memoController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var palette = Palette();
    final args = ModalRoute.of(context)!.settings.arguments as DetailPageArguments;
    bool isImportant = args.todo.important;
    DateTime selectDate = DateTime.parse(args.todo.endDate);
    String _selectedTime = DateFormat("yyyy-MM-dd").format(selectDate);
    titleController.text = args.todo.title;
    memoController.text = args.todo.memo;

    return Scaffold(
      backgroundColor: palette.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: palette.white,
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: palette.strongBlue),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: <Widget>[
          IconButton(onPressed: (){}, icon:Icon(Icons.edit))
        ],
      ),

      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(height * 0.015),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check_circle_outline),
                    SizedBox(
                      width: height * 0.02,
                    ),
                    SizedBox(
                      width: height * 0.3,
                      child: Form(
                        key: _formKey,
                        child: TextFormField(
                          validator: (value){
                            if(value == null || value.isEmpty){
                              return '할 일 입력 해주세요.';
                            }else{
                              return null;
                            }
                          },
                          controller: titleController,
                          keyboardType: TextInputType.text,
                          autocorrect: false,
                          textAlign: TextAlign.center,
                          obscureText: false,
                          decoration: const InputDecoration(
                            labelText: '할 일 입력',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: height * 0.02,
                    ),
                    isImportant?IconButton(
                      icon: Icon(
                        Icons.star,
                        color: palette.mainRed,
                        size: height * 0.04,
                      ),
                      onPressed: () {
                        setState(() {
                          FirebaseFirestore.instance
                              .collection('user')
                              .doc(FirebaseAuth.instance.currentUser?.uid)
                              .collection('todo')
                              .doc(args.todo.documentId)
                              .update({
                            'important' : false
                          });
                        });
                        args.todo.important = false;
                      },
                    ):IconButton(
                      icon: Icon(
                        Icons.star_outline_outlined,
                        color: palette.mainRed,
                        size: height * 0.04,
                      ),
                      onPressed: () {
                        setState(() {
                          FirebaseFirestore.instance
                              .collection('user')
                              .doc(FirebaseAuth.instance.currentUser?.uid)
                              .collection('todo')
                              .doc(args.todo.documentId)
                              .update({
                            'important' : true
                          });
                          args.todo.important = true;
                        });
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                const Divider(
                  height: 20,
                  color: Colors.grey,
                ),
                Text("마감일 선택"),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          DatePicker.showDatePicker(context,
                              showTitleActions: true,
                              locale: LocaleType.ko, onConfirm: (date) {
                                setState(() {
                                  _selectedTime =
                                      DateFormat("yyyy-MM-dd").format(date);
                                  selectDate = date;
                                  print('AddPage: Chosen Date=> $_selectedTime');
                                });
                              }, currentTime: selectDate);
                        },
                        icon: Icon(Icons.calendar_today)),
                    Text("$_selectedTime")
                  ],
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                const Divider(
                  height: 20,
                  color: Colors.grey,
                ),
                TextField(
                  controller: memoController,
                  keyboardType: TextInputType.multiline,
                  maxLength: 500,
                  maxLines: 10,
                  autocorrect: false,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '메모',
                  ),
                ),
                Center(
                  child: ElevatedButton(
                      onPressed: (){
                        if(_formKey.currentState!.validate()){
                          FirebaseFirestore.instance
                              .collection('user')
                              .doc(FirebaseAuth.instance.currentUser?.uid)
                              .collection('todo')
                              .doc(args.todo.documentId)
                              .update({
                            'title' : titleController.text,
                            'endDate' : _selectedTime,
                            'memo' : memoController.text,
                            'important' : isImportant,
                            'isEnd' : false
                          });
                          print("AddPage: add to firestore!");
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        "저장",
                        style: TextStyle(
                            fontSize: height * 0.02,
                            color: palette.white,
                            fontWeight: FontWeight.bold),
                      ),
                      style: ButtonStyle(
                        shape:
                        MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0))),
                        backgroundColor:
                        MaterialStateProperty.all(palette.mainGreen),
                      )),
                )
              ],
            ),

          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: () => setState(() {
          FirebaseFirestore.instance
              .collection('user')
              .doc(FirebaseAuth.instance.currentUser?.uid)
              .collection('todo')
              .doc(args.todo.documentId)
              .delete();
          Navigator.pop(context);
        }),
        tooltip: 'Increment Counter',
        child: Icon(Icons.delete)
        ,
      ),
    );
  }
}

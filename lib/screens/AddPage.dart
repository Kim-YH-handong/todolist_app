import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/style/palette.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class AddPage extends StatefulWidget {
  AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController memoController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  DateTime selectDate = DateTime.now();
  String _selectedTime = DateFormat("yyyy-MM-dd").format(DateTime.now());

  bool isImportant = false;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var palette = Palette();
    return Scaffold(
      backgroundColor: palette.white,
      appBar: AppBar(
        title: Text(
          "추가",
          style: TextStyle(color: palette.dark),
        ),
        elevation: 0,
        backgroundColor: palette.white,
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: palette.strongBlue),
            onPressed: () {
              Navigator.pop(context);
            }),
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
                          print("AddPage : Change to isImportant = false");
                          isImportant = false;
                        });
                      },
                    ):IconButton(
                      icon: Icon(
                        Icons.star_outline_outlined,
                        color: palette.mainRed,
                        size: height * 0.04,
                      ),
                      onPressed: () {
                        setState(() {
                          print("AddPage : Change to isImportant = true");
                          isImportant = true;
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
                              .add({
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
                        "입력",
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
    );
  }
}

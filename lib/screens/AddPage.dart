import 'package:final_project/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddPage extends StatefulWidget {
  AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController memoController = TextEditingController();

  DateTime selectDate = DateTime.now();
  String _selectedTime = DateFormat("yyyy-MM-dd").format(DateTime.now());

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
              Get.back();
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
                      child: TextField(
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
                    SizedBox(
                      width: height * 0.02,
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.star_border_outlined,
                        color: palette.mainRed,
                        size: height * 0.04,
                      ),
                      onPressed: () {},
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
                          DatePicker.showDatePicker(context, showTitleActions: true,
                              locale: LocaleType.ko,
                              onConfirm: (date) {
                                setState(() {
                                  _selectedTime = DateFormat("yyyy-MM-dd").format(date);
                                  selectDate = date;
                                  print('AddPage: Chosen Date=> $_selectedTime');
                                });
                              }, currentTime: selectDate);
                        }, icon: Icon(Icons.calendar_today)),
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
                ElevatedButton(
                    onPressed: null,
                    child: Text("입력")
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

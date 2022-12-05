import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/model/Bible.dart';
import 'package:final_project/screens/StartPage.dart';
import 'package:final_project/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Menu { red, pink, yellow, green, blue, violet }

class BiblePageArguments{
  BiblePageArguments({required this.bible});

  final Bible bible;
}

class BiblePage extends StatefulWidget {
  const BiblePage({Key? key}) : super(key: key);

  @override
  _BiblePageState createState() => _BiblePageState();
}

class _BiblePageState extends State<BiblePage> {
  var palette = Palette();

  String _selectedMenu = 'green';


  Future<void> saveBbc() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('bibleColor', _selectedMenu);
      print(_selectedMenu);
    });
  }

  int count = 0;
  @override
  Widget build(BuildContext context) {
    List<Color> bbC = [];
    var height = MediaQuery.of(context).size.height;
    final args =
    ModalRoute.of(context)!.settings.arguments as BiblePageArguments;

    List<Color> setBbc(String colorparam) {
      List<Color> bbcolor = [];
      Color bbC = palette.bbGreen;
      Color bbwC = palette.bbGreen;

      final bibleColor = colorparam;
      if(bibleColor == 'red'){
        bbC = palette.bbRed;
        bbwC = palette.bbwRed;
      }else if(bibleColor == 'yellow'){
        bbC = palette.bbYellow;
        bbwC = palette.bbwYellow;
      }else if(bibleColor == 'pink'){
        bbC = palette.bbPink;
        bbwC = palette.bbwPink;
      }else if(bibleColor == 'blue'){
        bbC = palette.bbBlue;
        bbwC = palette.bbwBlue;
      }else if(bibleColor == 'violet'){
        bbC = palette.bbViolet;
        bbwC = palette.bbwViolet;
      }else{
        bbC = palette.bbGreen;
        bbwC = palette.bbwGreen;
      }
      print(bibleColor);

      bbcolor.add(bbC);
      bbcolor.add(bbwC);
      return bbcolor;
    }
    @override
    void initState() {
      count = 0;
      super.initState();
    }
    if(count==0){
      bbC = setBbc(args.bible.bbC);
      print(bbC);
      count++;
    }else{
      bbC = setBbc(_selectedMenu);
      print(bbC);
    }
    //바이블 색상
    // week 색상
    return WillPopScope(
      onWillPop: (){
        setState((){});
        return Future(() => false);
      },
      child: Scaffold(
        backgroundColor: bbC[0],
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                    builder: (BuildContext context) =>
                    const StartPage()), (route) => false);
              },
              icon: Icon(
                Icons.arrow_back,
                color: bbC[1],
                size: height * 0.04,
              )),
          actions: <Widget>[
            // This button presents popup menu items.
            PopupMenuButton<Menu>(
              // Callback that sets the selected popup menu item.
                icon: Icon(
                  Icons.menu,
                  color: bbC[1],
                  size: height * 0.04,
                ),
                onSelected: (Menu item) {
                  setState(()  {
                    _selectedMenu = item.name;
                    if(_selectedMenu == 'red'){
                      bbC[0] = palette.bbRed;
                      bbC[1] = palette.bbwRed;
                    }else if(_selectedMenu == 'yellow'){
                      bbC[0] = palette.bbYellow;
                      bbC[1] = palette.bbwYellow;
                    }else if(_selectedMenu == 'pink'){
                      bbC[0] = palette.bbPink;
                      bbC[1] = palette.bbwPink;
                    }else if(_selectedMenu == 'blue'){
                      bbC[0] = palette.bbBlue;
                      bbC[1] = palette.bbwBlue;
                    }else if(_selectedMenu == 'green'){
                      bbC[0] = palette.bbGreen;
                      bbC[1] = palette.bbwGreen;
                    }else if(_selectedMenu == 'violet'){
                      bbC[0] = palette.bbViolet;
                      bbC[1] = palette.bbwViolet;
                    }
                    args.bible.bbC = _selectedMenu;
                    saveBbc();
                    // setBbc();

                  });
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
                  const PopupMenuItem<Menu>(
                    value: Menu.red,
                    child: Text('Red'),
                  ),
                  const PopupMenuItem<Menu>(
                    value: Menu.pink,
                    child: Text('Pink'),
                  ),
                  const PopupMenuItem<Menu>(
                    value: Menu.yellow,
                    child: Text('Yellow'),
                  ),
                  const PopupMenuItem<Menu>(
                    value: Menu.green,
                    child: Text('Green'),
                  ),
                  const PopupMenuItem<Menu>(
                    value: Menu.blue,
                    child: Text('Blue'),
                  ),
                  const PopupMenuItem<Menu>(
                    value: Menu.violet,
                    child: Text('Violet'),
                  ),
                ]),
          ],
          elevation: 0,
          backgroundColor: bbC[0],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
              child: Center(
                child: Container(
                  width: height / 3,
                  margin: EdgeInsets.fromLTRB(0, height / 50, 0, 0),
                  child: Column(
                    children: [
                      Text(
                        args.bible.script,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: height / 30,
                          fontWeight: FontWeight.w600,
                          height: height * 0.003,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: height * 0.1,
                      ),
                      Text(
                        args.bible.title,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: height / 30,
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: height * 0.1,
                      ),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:vibration/vibration.dart';
import 'lectures.dart';

class thirdpage extends StatefulWidget {
  final Future str;

  thirdpage({Key key, this.str}) : super(key: key);

  @override
  _thirdpageState createState() => _thirdpageState();
}

class _thirdpageState extends State<thirdpage> {
  // return personal info of the student

  var dataLength, data;

  Future<List> _PersonalInfo() async {
    final response = await http.get(
      // "https://sadiquni.com/ContEdo/thiscode.php",
      "http://localhost/ContEdo/seminars.php",

    );
    print("this ${json
        .decode(response.body)
        .length}");
    setState(() {
      data = json.decode(response.body);
      dataLength = json
          .decode(response.body)
          .length;
    });
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    MediaQuery
        .of(context)
        .size
        .height;
    _PersonalInfo();
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 254, 244, 1.0),
      appBar: AppBar(
        // backgroundColor: Colors.grey,
        backgroundColor: const Color.fromRGBO(128, 0, 0, 1.0),
        title: Text(
          'الدورات التدريبية',
          style: GoogleFonts.tajawal(
            fontSize: 16.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        children: [
          Text("third"),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "جميع الدورات التدريبية",
              textAlign: TextAlign.center,
              style: GoogleFonts.tajawal(
                fontSize: 16.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Divider(
            height: 5,
            color: const Color.fromRGBO(128, 0, 0, 1.0),
          ),
          Container(
            height: MediaQuery
                .of(context)
                .size
                .height,
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: ListView.builder(
                itemCount: data == null ? 0 : data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        // color: Colors.black12,
                        child: new Column(
                          // crossAxisAlignment: CrossAxisAlignment.end,
                          // mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              // mainAxisAlignment: MainAxisAlignment.end,

                              children: [
                                SizedBox.fromSize(
                                  size: Size(80, 80),
                                  // button width and height
                                  child: ClipOval(
                                    child: Material(
                                      color: Colors.grey, // button color
                                      child: InkWell(
                                        splashColor: Colors.grey,
                                        // splash color
                                        onTap: () {
                                          Vibration.vibrate(duration: 10);
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  lectures(
                                                    docContent: data[index]
                                                    ['contant'],
                                                    docLecType: data[index]
                                                    ['trainning_loc'],
                                                    docLocation: data[index]
                                                    ['onsite_online'],
                                                    docPDF: data[index]['pdf'],
                                                    docTimefrom: data[index]
                                                    ['time'],
                                                    docTimeto: data[index]
                                                    ['time_To'],
                                                    docTitle: data[index]
                                                    ['title'],
                                                    docNOL: data[index]
                                                    ['docus'],
                                                  ));
                                        },
                                        // button pressed
                                        child: Icon(
                                          Icons.library_books,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Column(
                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        data[index]['title'],
                                        textAlign: TextAlign.start,
                                        style: GoogleFonts.tajawal(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,),
                                      ),
                                      Text(
                                        data[index]['time'],
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w100,
                                          color: Colors.black,),
                                      ),
                                    ]),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Divider(
                              height: 10,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
          )
        ],
      ),
    );
  }
}

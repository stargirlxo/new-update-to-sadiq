import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:testty/firstpage.dart';


import 'package:testty/thirdpage.dart';

import 'NewsWork.dart';
import 'package:vibration/vibration.dart';

import 'fourthpage.dart';
import 'thisicon.dart';
import 'secondpage.dart';

class Work extends StatefulWidget {
  @override
  _WorkState createState() => _WorkState();
}

class _WorkState extends State<Work> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Expanded(
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Divider(
              height: 4,
              color: Colors.black,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0),
                child: ThisIcon(
                  onPressed: () {
                    Vibration.vibrate(duration: 10);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => NewsWork()));
                  },
                  textsName: ('الاخبار'),
                  Iconss: Icons.import_contacts,
                ),
              ),
            ),
            // SizedBox(height: 100,
            // width: 10,
            // ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 70.0, 0.0, 0.0),
                child: ThisIcon(
                  onPressed: () {
                    Vibration.vibrate(duration: 10);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => firstpage()));
                  },
                  textsName: ('الدورات التدريبية'),
                  Iconss: FontAwesomeIcons.map,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 70.0, 0.0, 0.0),
                child: ThisIcon(
                  onPressed: () {
                    Vibration.vibrate(duration: 10);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SecondPage()));
                  },
                  textsName: ('ورش العمل'),
                  Iconss: FontAwesomeIcons.map,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 70.0, 0.0, 0.0),
                child: ThisIcon(
                  onPressed: () {
                    Vibration.vibrate(duration: 10);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => thirdpage()));
                  },
                  textsName: ('الندوات'),
                  Iconss: FontAwesomeIcons.map,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 70.0, 0.0, 0.0),
                child: ThisIcon(
                  onPressed: () {
                    Vibration.vibrate(duration: 10);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => fourthpage()));
                  },
                  textsName: ('المحاضرات'),
                  Iconss: FontAwesomeIcons.map,
                ),
              ),
            ),


            // Expanded(
            //   child: Padding(
            //     padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
            //     child: ThisIcon(
            //       onPressed: () {
            //         Vibration.vibrate(duration: 10);
            //         Navigator.push(context,
            //             MaterialPageRoute(builder: (context) => AddNews()));
            //       },
            //       textsName: ('Add News'),
            //       Iconss: FontAwesomeIcons.map,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
      // RaisedButton(
      //   onPressed: _makingPhoneCall,
      //   child: Text('Call'),
      // ),
      Divider(
        height: 4,
        color: Colors.black,
      ),
    ]);
  }
}

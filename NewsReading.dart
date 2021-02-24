import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:url_launcher/url_launcher.dart';

import 'dart:io' show Platform;

class NewsReading extends StatefulWidget {
  String NewsContent = '',
      NewsTitle = '',
      ImageUrl = '',
      date = '',
      PushedID = '',
      token = '';

  NewsReading(
      {this.NewsContent,
      this.NewsTitle,
      this.ImageUrl,
      this.date,
      this.PushedID,
      this.token});

  @override
  _NewsReadingState createState() => _NewsReadingState();
}

class _NewsReadingState extends State<NewsReading> {
  final TextEditingController controller = new TextEditingController();
  final TextEditingController namecontroller = new TextEditingController();

  DatabaseReference ref = FirebaseDatabase.instance.reference();

  DateTime now = DateTime.now();

  @override
  void initState() {
//print('yyyy${widget.NewsTitle}');
    // TODO: implement initState
    super.initState();
  }

  var checkCommentsAvailability;

  var difference;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 254, 244, 1.0),
      appBar: AppBar(
        // backgroundColor: Colors.grey,
        backgroundColor: const Color.fromRGBO(128, 0, 0, 1.0),
        title: Text(
          'الاخبار',
          style: GoogleFonts.tajawal(
            fontSize: 16.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Scrollbar(
          child: ListView(
            children: <Widget>[
              new Container(
                color: const Color.fromRGBO(255, 254, 244, 1.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Center(
                      child: Container(
                        decoration: new BoxDecoration(
                          color: Colors.transparent,
                          image: new DecorationImage(
                              fit: BoxFit.cover,
                              colorFilter: new ColorFilter.mode(
                                  Colors.black.withOpacity(0.2),
                                  BlendMode.colorBurn),
                              image: AssetImage('assets/images/this.png')),
                        ),
                        child: GestureDetector(
                          onTap: () => {},
                          child: Container(
                              height: 300.0,
                              decoration: new BoxDecoration(
                                color: Colors.transparent,
                                image: new DecorationImage(
                                    fit: BoxFit.cover,
                                    colorFilter: new ColorFilter.mode(
                                        Colors.black.withOpacity(0.2),
                                        BlendMode.colorBurn),
                                    image: new NetworkImage(widget.ImageUrl)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 270.0),
                                child: new Container(
                                  decoration: new BoxDecoration(
                                    color: const Color.fromRGBO(
                                        255, 254, 244, 1.0),
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(40),
                                        topLeft: Radius.circular(40)),
                                  ),
                                  height: 50.0,
                                ),
                              )),
                        ),
                      ),
                    ),
                    Scrollbar(
                        child: SingleChildScrollView(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.55,
                        child: ListView(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new Text(
                                widget.NewsTitle,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.tajawal(
                                    color: const Color.fromRGBO(0, 0, 0, 1.0),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25.0),
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8.0, left: 8.0, bottom: 0.0),
                                  child: new Text(
                                    widget.date.toString(),
                                    textAlign: TextAlign.center,
                                    // textDirection: TextDirection.rtl,
                                    style: GoogleFonts.tajawal(
                                        color: Colors.black45, fontSize: 18.0),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 0.0,
                                  right: 8.0,
                                  left: 8.0,
                                  bottom: 5.0),
                              child: Linkify(
                                onOpen: (link) async {
                                  if (await canLaunch(link.url)) {
                                    await launch(link.url);
                                  } else {
                                    throw 'Could not launch $link';
                                  }
                                },
                                text: widget.NewsContent,
                                textAlign: TextAlign.justify,
                                style: GoogleFonts.tajawal(
                                  color: Colors.black,
                                  fontSize: 19.0,
                                ),
                                linkStyle: TextStyle(color: Colors.blue),
                              ),
                            ),
                            Divider(
                              height: 1.0,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:path_provider/path_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vibration/vibration.dart';

class lectures extends StatefulWidget {
  var docTitle,
      docTimeto,
      docTimefrom,
      docContent,
      docPDF,
      docLecType,
      docLocation,
      docNOL;

  lectures(
      {this.docContent,
      this.docLecType,
      this.docLocation,
      this.docPDF,
      this.docTimefrom,
      this.docTimeto,
      this.docTitle,
      this.docNOL});

  @override
  _lecturesState createState() => _lecturesState();
}

class _lecturesState extends State<lectures> {
  String pathPDF = "";

  @override
  void initState() {
    super.initState();
    createFileOfPdfUrl().then((f) {
      setState(() {
        pathPDF = f.path;
        print(pathPDF);
      });
    });
  }

  // return personal info of the student

  Future<File> createFileOfPdfUrl() async {
    final url = widget.docPDF;
    final filename = url.substring(url.lastIndexOf("/") + 1);
    var request = await HttpClient().getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$dir/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }

  var dataLength, data;

  @override
  Widget build(BuildContext context) {
    print("this is online${widget.docLecType}");
    MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 254, 244, 1.0),
      appBar: AppBar(
        // backgroundColor: Colors.grey,
        backgroundColor: const Color.fromRGBO(128, 0, 0, 1.0),
        title: Text(
          ' صفحة الدورات التدريبية',
          style: GoogleFonts.tajawal(
            fontSize: 16.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Container(
          child: new ListView(
            children: <Widget>[



              Text(
                widget.docTitle,
                style: GoogleFonts.tajawal(
                  fontSize: 16.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),





              Divider(
                height: 20,
                thickness: 0.5,
                color: const Color.fromRGBO(128, 0, 0, 1.0),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,

                children: [
               SizedBox(height: 5,),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Text(
                          "تاريخ المحاضرة يبدأ من:",
                          style: GoogleFonts.tajawal(
                              fontSize: 14.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Text(
                          widget.docTimefrom,
                          style: GoogleFonts.tajawal(
                              fontSize: 16.0,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      SizedBox(
                        width: 7,
                      ),
                    ],
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Text(
                          "وينتهي:",
                          style: GoogleFonts.tajawal(
                              fontSize: 14.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Text(
                          widget.docTimeto,
                          style: GoogleFonts.tajawal(
                              fontSize: 16.0,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      SizedBox(
                        width: 7,
                      ),
                    ],
                  ),
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    // mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Text(
                          "عدد المحاضرات : ",
                          style: GoogleFonts.tajawal(
                              fontSize: 14.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Row(
                          children: [
                            Text(widget.docNOL,
                                textAlign: TextAlign.end,
                                style: GoogleFonts.tajawal(
                                    fontSize: 16.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal)),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 3.0,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                ],
              ),
              Row(
                // crossAxisAlignment: CrossAxisAlignment.end,
                // mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Text(
                      "طريقة الالقاء:",
                      // textAlign: TextAlign.right,
                      style: GoogleFonts.tajawal(
                          fontSize: 14.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Row(
                      children: [
                        widget.docLecType == "0"
                            ? Text(
                                "حضور فعلي",
                                style: GoogleFonts.tajawal(
                                    fontSize: 16.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal),
                              )
                            : Text(
                                "حضور اونلاين",
                                style: GoogleFonts.tajawal(
                                    fontSize: 16.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal),
                              ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                ],
              ),
              Row(
                // crossAxisAlignment: CrossAxisAlignment.end,
                // mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Text(
                      "موقع المحاضرة:",
                      // textAlign: TextAlign.right,
                      style: GoogleFonts.tajawal(
                          fontSize: 14.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Row(
                      children: [
                        widget.docLocation == "4"
                            ? Text(
                                "ZOOM",
                                style: GoogleFonts.tajawal(
                                    fontSize: 16.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal),
                              )
                            : widget.docLocation == "5"
                                ? Text(
                                    "FCC",
                                    style: GoogleFonts.tajawal(
                                        fontSize: 16.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal),
                                  )
                                : widget.docLocation == "9"
                                    ? Text(
                                        "Google Meet",
                                        style: GoogleFonts.tajawal(
                                            fontSize: 16.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal),
                                      )
                                    : widget.docLocation == "6"
                                        ? Text(
                                            "قاعة مؤتمرات",
                                            style: GoogleFonts.tajawal(
                                                fontSize: 16.0,
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal),
                                          )
                                        : widget.docLocation == "7"
                                            ? Text(
                                                "قاعة المكتبة",
                                                style: GoogleFonts.tajawal(
                                                    fontSize: 16.0,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              )
                                            : widget.docLocation == "8"
                                                ? Text(
                                                    "قاعة الشهيد",
                                                    style: GoogleFonts.tajawal(
                                                        fontSize: 16.0,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  )
                                                : widget.docLocation == "8"
                      ],
                    ),
                  ),
                ],
              ),
             SizedBox(
               height: 25,
             ),
              //مال عنوان هاي!!!!!!!
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Expanded(
                  child: Text(
                    widget.docContent,
                    textAlign: TextAlign.justify,

                    style: GoogleFonts.tajawal(
                        fontSize: 16.0,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: FlatButton(
                    child: new InkWell(
                      child: widget.docPDF ==
                              "https://sadiquni.com/ContEdo/uploads/"
                          ? Text("")
                          : Text(
                              'رؤية المحاضرة..',
                              textAlign: TextAlign.end,
                              style: GoogleFonts.tajawal(
                                fontSize: 18.0,
                                color: Colors.blue,
                              ),
                            ),
                    ),
                    onPressed: () {
                      Vibration.vibrate(duration: 10);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PDFScreen(pathPDF)),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PDFScreen extends StatelessWidget {
  String pathPDF = "";

  PDFScreen(this.pathPDF);

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(

        appBar:AppBar(
          backgroundColor: const Color.fromRGBO(128, 0, 0, 1.0),
          title:
          Text('معلومات عن المحاضرة',
            style: GoogleFonts.tajawal(
              fontSize: 16.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        path: pathPDF);
  }
}

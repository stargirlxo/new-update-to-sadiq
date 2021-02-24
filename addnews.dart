import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddNews extends StatefulWidget {
  final bool name;

  AddNews({this.name});

  @override
  _AddNewsState createState() => _AddNewsState();
}

class _AddNewsState extends State<AddNews> {
  Future sleep1() {
    return new Future.delayed(const Duration(seconds: 8), () => "1");
  }

  GlobalKey<FormState> _key = new GlobalKey();
  bool _autovalidate = false;

  final TextEditingController title = new TextEditingController();
  final TextEditingController contant = new TextEditingController();

  File _image;
  String filename;
  String path = '';

  DateTime now = DateTime.now();

  // choose image from gallery
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      filename = basename(image.path);
    });
  }

  //upload news to firebase
  void NewsPublish() {
    if (_key.currentState.validate()) {
      _key.currentState.save();

      DatabaseReference ref = FirebaseDatabase.instance.reference();
      var data = {
        "title": title.text,
        "contant": contant.text,
        "ImageUrl": path,
        "SeeCount": 0,
        "date":
            '${now.year.toString()}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}    ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}',
      };
      ref.child('news').push().set(data).then((v) {
        _key.currentState.reset();
      });
      print('downloadyyyy url: $path');
    } else {
      setState(() {
        _autovalidate = true;
      });
    }
  }

  // //upload image to firebase storage
  Future<String> ImageUpload() async {
    StorageReference ref = FirebaseStorage.instance.ref().child(filename);
    ref.putFile(_image);

    return "";
  }

  Future<String> ImageDownload() async {
    StorageReference ref = FirebaseStorage.instance.ref().child(filename);
    StorageUploadTask uploadTask = ref.putFile(_image);

    var downUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
    var url = downUrl.toString();

    setState(() {
      path = url;
    });

    return path;
  }

  String validateTitle(String val) {
    return val.length == 0 ? "ادخل عنوان الخبر قبل النشر" : null;
  }

  String validateContent(String val) {
    return val.length == 0 ? "ادخل محتوى الخبر قبل النشر" : null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (BuildContext context, Widget child) {
        return MaterialApp(
            builder: (context, child) {
              return Directionality(
                textDirection: TextDirection.rtl,
                child: child,
              );
            },
            debugShowCheckedModeBanner: false,
            theme: ThemeData.dark(),
            darkTheme: ThemeData.light(),
            home: Scaffold(
                backgroundColor: const Color.fromRGBO(255, 254, 244, 1.0),
                appBar: AppBar(
                  // backgroundColor: Colors.grey,
                  backgroundColor: const Color.fromRGBO(128, 0, 0, 1.0),
                  title:
                  Text('ادخال معلومات للتعليم المستمر',
                    style: GoogleFonts.tajawal(
                      fontSize: 16.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                body: new Directionality(
                  textDirection: TextDirection.rtl,
                  child: new Builder(
                    builder: (BuildContext context) {
                      return new MediaQuery(
                        data: MediaQuery.of(context).copyWith(
                          textScaleFactor: 1.0,
                        ),
                        child: child,
                      );
                    },
                  ),
                )));
      },
      home: Scaffold(
        backgroundColor: const Color.fromRGBO(255, 254, 244, 1.0),
        appBar: widget.name == true
            ? new AppBar(
                leading: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: new Icon(Icons.arrow_back)),
                backgroundColor: const Color.fromRGBO(12, 88, 88, 1.0),
                title: Center(
                    child: new Text(
                  "اضافة خبر",
                  style: GoogleFonts.tajawal(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )),
              )
            : null,
        body: SingleChildScrollView(
          child: new Container(
            child: Form(
              key: _key,
              autovalidate: _autovalidate,
              child: new Column(
                children: <Widget>[
                  Theme(
                    data: new ThemeData(
                      hintColor: const Color.fromRGBO(12, 88, 88, 1.0),
                      primaryColor: const Color.fromRGBO(12, 88, 88, 1.0),
                      accentColor: Colors.black,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: TextFormField(
                        style: GoogleFonts.tajawal(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        controller: title,
                        decoration: InputDecoration(
                          icon: Icon(Icons.edit, color: Colors.black),
                          labelText: 'عنوان الخبر :',
                        ),
                        maxLines: 2,
                        validator: validateTitle,
                      ),
                    ),
                  ),
                  Theme(
                    data: new ThemeData(
                      hintColor: const Color.fromRGBO(12, 88, 88, 1.0),
                      primaryColor: const Color.fromRGBO(12, 88, 88, 1.0),
                      accentColor: Colors.black,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: TextFormField(
                        style: GoogleFonts.tajawal(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        controller: contant,
                        decoration: InputDecoration(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.black,
                            ),
                            labelText: 'محتوى الخبر :'),
                        maxLines: 4,
                        validator: validateContent,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: new Center(
                      child: _image == null
                          ? new Text(
                              'اختر صورة لتظهر هنا',
                              style: GoogleFonts.tajawal(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0),
                            )
                          : new Image.file(
                              _image,
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width * 0.7,
                              height: MediaQuery.of(context).size.height * 0.2,
                            ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FloatingActionButton(
                      backgroundColor: Colors.black,
                      onPressed: () {
                        getImage();
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: new Text(
                                  "هل انت متأكد من الصورة؟ اضغط على اختيار جديد اذا كنت تريد تغييرها",
                                  style:
                                      GoogleFonts.tajawal(color: Colors.white),
                                ),
                                actions: <Widget>[
                                  new RaisedButton(
                                    shape: new RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(30.0)),
                                    child: new Text(
                                      "تأكيد",
                                      style: GoogleFonts.tajawal(
                                          color: Colors.white),
                                    ),
                                    color:
                                        const Color.fromRGBO(12, 88, 88, 1.0),
                                    onPressed: () {
                                      ImageUpload();
                                      ImageDownload();
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  new RaisedButton(
                                    shape: new RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(30.0)),
                                    child: new Text(
                                      "اختيار جديد",
                                      style: GoogleFonts.tajawal(
                                          color: Colors.white),
                                    ),
                                    color: const Color.fromRGBO(128, 0, 0, 1.0),
                                    onPressed: () => getImage(),
                                  ),
                                ],
                              );
                            });
                      },
                      tooltip: 'Pick Image',
                      child: path == '' && _image != null
                          ? Theme(
                              data: new ThemeData(
                                hintColor: Colors.white,
                                primaryColor: Colors.white,
                                accentColor: Colors.white,
                              ),
                              child: new CircularProgressIndicator())
                          : new Icon(
                              Icons.add_a_photo,
                              color: Colors.white,
                            ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: ButtonTheme(
                        minWidth: 190.0,
                        height: 50.0,
                        child: RaisedButton(
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          color: const Color.fromRGBO(12, 88, 88, 1.0),
                          splashColor: const Color.fromRGBO(255, 254, 244, 1.0),
                          onPressed: () {
                            if (path == '' &&
                                _image != null &&
                                title.text != '' &&
                                contant.text != '') {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      content: new Text(
                                        "انتظر لحين اتمام رفع الصورة",
                                        style: GoogleFonts.tajawal(
                                            color: Colors.black),
                                      ),
                                      actions: <Widget>[
                                        new RaisedButton(
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      30.0)),
                                          child: new Text(
                                            "خروج",
                                            style: GoogleFonts.tajawal(
                                                color: Colors.black),
                                          ),
                                          color: const Color.fromRGBO(
                                              128, 0, 0, 1.0),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  });
                            } else {
                              NewsPublish();
                              if (_key.currentState.validate()) {
                                AlertDialog alertDialog = new AlertDialog(
                                  content: Container(
                                    width: 100.0,
                                    height: 100.0,
                                    child: new Column(
                                      children: <Widget>[
                                        Center(child: Text("تم نشر الخبر",
                                          style: GoogleFonts.tajawal(
                                              color: Colors.black),
                                        ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Icon(
                                            Icons.check_circle,
                                            size: 50.0,
                                            color: const Color.fromRGBO(
                                                255, 254, 244, 1.0),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                                showDialog(
                                  context: context,
                                  // child: alertDialog
                                );
                              }
                            }
                          },

                          child: new Text(
                            " نشر الخبر",
                            style: GoogleFonts.tajawal(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

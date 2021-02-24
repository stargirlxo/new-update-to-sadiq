import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testty/Work.dart';
void main() {
    WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        //
        builder: (context, child) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: child,
          );
        //
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
            Text('التعليم المستمر',
              style: GoogleFonts.tajawal(
              fontSize: 16.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            ),
          ),
          body:
          Work(),
          )
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThisIcon extends StatelessWidget {
  ThisIcon({
    @required this.Iconss,
    @required this.onPressed,
    this.textsName,
  });

  final IconData Iconss;
  final Function onPressed;
  final String textsName;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RawMaterialButton(
          child: Icon(Iconss),
          onPressed: onPressed,
          constraints: BoxConstraints.tightFor(
            width: 100.0,
            height: 100,
          ),
          shape:
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),

                side: BorderSide(color: const Color.fromRGBO(128, 0, 0, 1.0),
                width: 2,
                )


            ),

          fillColor: Color(0xFFFFFF),
          // textStyle: Colors.black);
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          textsName,
          style: GoogleFonts.tajawal(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 15.0),
        ),
      ],
    );
  }
}

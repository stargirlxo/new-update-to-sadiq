import 'package:flutter/material.dart';

class TextyText extends StatelessWidget {
  TextyText({this.hint});
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(100, 0, 100, 0),
      child: TextField(
        controller: _textEditingController,
        decoration: InputDecoration(hintText: hint),
      ),
    );
  }
}

final TextEditingController _textEditingController = TextEditingController();

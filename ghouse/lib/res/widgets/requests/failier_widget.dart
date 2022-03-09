import 'package:flutter/material.dart';

class FailierWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(child: Container(child: Image.asset('no-connection.png')));
  }
}

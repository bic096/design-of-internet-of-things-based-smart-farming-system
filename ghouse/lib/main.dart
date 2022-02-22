import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ghouse/res/screens/initScreen/init_screen.dart';

final navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: InitScreen(),
    );
  }
}

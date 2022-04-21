import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/home.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chich Pay',
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

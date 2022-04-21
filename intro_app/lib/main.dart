import 'package:flutr/widgets/intro_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(App());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AppHome(),
    );
  }
}

class AppHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntroView(
      introPages: [
        IntroPage(
          title: 'Lorem ipsum dolor sit amet',
          description: 'Lorem ipsum dolor sit amet, '
              'consectetur adipiscing elit, '
              'sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        ),
        IntroPage(
          title: 'Lorem ipsum dolor sit amet'.split('').reversed.join(''),
          description: 'Lorem ipsum dolor sit amet, ' * 2,
        ),
        IntroPage(
          title: 'A problem occurred evaluating project',
          description:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ',
        ),
      ],
    );
  }
}

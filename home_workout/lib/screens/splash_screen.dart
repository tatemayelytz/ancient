import 'package:flutter/material.dart';
import 'package:home_workout/screens/main_menu_screen.dart';

class SplashScreen extends StatefulWidget {
  static String id = 'splashscreen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<bool> _timeElapsed(int sec) async {
    await Future.delayed(Duration(seconds: sec), () {});
    return true;
  }

  @override
  void initState() {
    super.initState();

    _timeElapsed(4).then((value) {
      if (value) Navigator.pushReplacementNamed(context, MainMenu.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('images/icon.png'),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:home_workout/screens/calendar_screen.dart';
import 'package:home_workout/screens/complete_exercise_screen.dart';
import 'package:home_workout/screens/exercise_screen.dart';
import 'package:home_workout/screens/instruction_screen.dart';
import 'package:home_workout/screens/main_menu_screen.dart';
import 'package:home_workout/screens/splash_screen.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Theme.of(context).copyWith(
        primaryColor: Color(0xFF1ECBE1),
      ),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        MainMenu.id: (context) => MainMenu(),
        CalendarScreen.id: (context) => CalendarScreen(),
        ExerciseScreen.id: (context) => ExerciseScreen(),
        Instructions.id: (context) => Instructions(),
        CompleteExercise.id: (context) => CompleteExercise(),
      },
    );
  }
}

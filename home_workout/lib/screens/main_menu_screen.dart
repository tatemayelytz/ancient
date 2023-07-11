import 'package:flutter/material.dart';
import 'package:home_workout/screens/calendar_screen.dart';
import 'package:home_workout/screens/complete_exercise_screen.dart';
import 'package:home_workout/screens/exercise_screen.dart';
import 'package:home_workout/screens/instruction_screen.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:home_workout/ad_helper.dart';

class MainMenu extends StatefulWidget {
  static String id = 'mainmenu';

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  InterstitialAd? _interstitialAd;
  bool _isInterstitialAdReady = false;
  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          this._interstitialAd = ad;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {},
          );

          _isInterstitialAdReady = true;
        },
        onAdFailedToLoad: (err) {
          print('Failed to load an interstitial ad: ${err.message}');
          _isInterstitialAdReady = false;
        },
      ),
    );
  }

  Future<bool> _timeElapsed(int sec) async {
    await Future.delayed(Duration(seconds: sec), () {});
    return true;
  }

  void dispose() {
    _interstitialAd?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _loadInterstitialAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Workout'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 60,
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  if (_isInterstitialAdReady) _interstitialAd?.show();
                  Navigator.pushNamed(context, ExerciseScreen.id);
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(Color(0xFF1ECBE1)),
                ),
                child: Text(
                  'Start Workout',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 60,
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, CalendarScreen.id);
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(Color(0xFF1ECBE1)),
                ),
                child: Text(
                  'Calender',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 60,
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, Instructions.id);
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(Color(0xFF1ECBE1)),
                ),
                child: Text(
                  'Instructions',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 60,
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  // Navigator.pushNamed(context, CompleteExercise.id);
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(Color(0xFF1ECBE1)),
                ),
                child: Text(
                  'Disable Ads',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

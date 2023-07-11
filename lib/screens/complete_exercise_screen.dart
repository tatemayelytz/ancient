import 'package:flutter/material.dart';
import 'package:home_workout/screens/main_menu_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:home_workout/ad_helper.dart';

List<int> workoutDays = [];
int totalWorkouts = 0;
int workoutsThisMonth = 0;

class CompleteExercise extends StatefulWidget {
  static String id = 'completeexercise';

  @override
  _CompleteExerciseState createState() => _CompleteExerciseState();
}

class _CompleteExerciseState extends State<CompleteExercise> {
  void saveData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('totalworkouts', totalWorkouts);
    prefs.setInt('workoutsThisMonth', workoutsThisMonth);
    for (int i = 0; i < workoutDays.length; i++) {
      prefs.setInt('workoutDays' + i.toString(), workoutDays[i]);
    }
  }

  void deleteData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('totalworkouts');
    prefs.remove('workoutsThisMonth');
    for (int i = 0; i < workoutDays.length; i++) {
      prefs.remove('workoutDays' + i.toString());
    }
  }

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

  @override
  void initState() {
    _loadInterstitialAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Workout Completed!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Color(0xFF1ECBE1),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 60,
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  totalWorkouts++;
                  workoutsThisMonth++;
                  workoutDays.add(DateTime.now().day);

                  saveData();

                  if (_isInterstitialAdReady) _interstitialAd?.show();

                  Navigator.pushNamed(context, MainMenu.id);
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
                  'That\'s Great!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // Container(
            //   height: 60,
            //   width: 200,
            //   child: ElevatedButton(
            //     onPressed: () {
            //       deleteData();
            //     },
            //     style: ButtonStyle(
            //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            //         RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(18.0),
            //         ),
            //       ),
            //       backgroundColor: MaterialStateProperty.all(Color(0xFF1ECBE1)),
            //     ),
            //     child: Text(
            //       'Remove Prefs',
            //       style: TextStyle(
            //         fontSize: 24,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

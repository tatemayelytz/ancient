import 'dart:async';
import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:home_workout/ad_helper.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:home_workout/screens/complete_exercise_screen.dart';

List<String> allExercisesNames = [
  'JUMPING JACKS',
  'JUMPING JACKS',
  'WALL SITS',
  'WALL SITS',
  'PUSH UPS',
  'PUSH UPS',
  'CRUNCHES',
  'CRUNCHES',
  'STEP UP ONTO CHAIR',
  'STEP UP ONTO CHAIR',
  'SQUATS',
  'SQUATS',
  'TRICEP DIPS',
  'TRICEP DIPS',
  'PLANK',
  'PLANK',
  'HIGH STEPPING',
  'HIGH STEPPING',
  'LUNGES',
  'LUNGES',
  'PUSH UP AND ROTATION',
  'PUSH UP AND ROTATION',
  'SIDE PLANK RIGHT',
  'SIDE PLANK RIGHT',
  'SIDE PLANK LEFT',
  'SIDE PLANK LEFT',
  'HOLD KEGAL',
  'HOLD KEGAL',
  'REVERSE KEGAL',
  'REVERSE KEGAL',
];

List<Exercise> allExercises = [];
List<Speech> allSpeeches = [];

class ExerciseScreen extends StatefulWidget {
  static String id = 'exercisescreen';

  @override
  _ExerciseScreenState createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  int currExercise = 0;
  int currSpeech = 0;

  FlutterTts flutterTts = FlutterTts();
  CountDownController _countDownController = CountDownController();

  int speechTime = 0;
  bool resetClock = true;
  Timer? _timer;
  int seconds = 0;

  late BannerAd _bannerAd;
  bool _isBannerAdReady = false;

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  void startSpeech() {
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      var currText = allSpeeches[currSpeech].text;

      if (speechTime == seconds) {
        flutterTts.speak(currText);
        currSpeech++;
        speechTime = allSpeeches[currSpeech].time;
      }
      seconds++;
    });
  }

  @override
  void initState() {
    for (int i = 0; i < allExercisesNames.length; i++) {
      int time = 0;
      (i % 2 == 0) ? time = 10 : time = 30;

      allExercises.add(Exercise(title: allExercisesNames[i], time: time));
      if (time == 10) {
        allSpeeches.add(Speech(
            text: 'First Exercise' +
                allExercisesNames[i] +
                'starts in 10 seconds',
            time: 0));
        allSpeeches.add(Speech(
            text: '3,2,1, Start exercise' + allExercisesNames[i], time: 7));
      } else {
        allSpeeches.add(Speech(text: 'Half time', time: 15));
        allSpeeches.add(Speech(text: '3, 2, 1, and rest', time: 27));
      }
    }

    startSpeech();
    super.initState();

    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          _isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );
    _bannerAd.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Workout'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: SafeArea(
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Ready to go!',
                      style: TextStyle(
                        fontSize: 22,
                        color: Color(0xFF1ECBE1),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Start with',
                      style: TextStyle(
                        fontSize: 22,
                        color: Color(0xFF1ECBE1),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      ((currExercise + 1) / 2).toStringAsFixed(0) +
                          '/' +
                          ((allExercisesNames.length / 2)).toStringAsFixed(0) +
                          ' ' +
                          allExercises[currExercise].title,
                      style: TextStyle(
                        fontSize: 22,
                        color: Color(0xFF1ECBE1),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CircularCountDownTimer(
                      duration: allExercises[currExercise].time,
                      initialDuration: 0,
                      controller: _countDownController,
                      width: 200,
                      height: 200,
                      ringColor: Colors.grey[300]!,
                      ringGradient: null,
                      fillColor: Color(0xFF1ECBE1),
                      fillGradient: null,
                      backgroundColor: Colors.white,
                      backgroundGradient: null,
                      strokeWidth: 3,
                      strokeCap: StrokeCap.round,
                      textStyle: TextStyle(
                          fontSize: 70,
                          color: Color(0xFF1ECBE1),
                          fontWeight: FontWeight.bold),
                      textFormat: CountdownTextFormat.S,
                      isReverse: false,
                      isReverseAnimation: false,
                      isTimerTextShown: true,
                      autoStart: true,
                      onStart: () {
                        resetClock = true;
                      },
                      onComplete: () {
                        if (resetClock) {
                          setState(() {
                            currExercise++;
                          });
                          resetClock = false;
                        }
                        if (currExercise >= allExercises.length) {
                          Navigator.pushNamed(context, CompleteExercise.id);
                        } else {
                          _countDownController.restart(
                              duration: allExercises[currExercise].time);
                        }
                        seconds = 0;
                      },
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Image.asset(allExercises[currExercise].getImageAddress()),
                  ],
                ),
              ),
              if (_isBannerAdReady)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: _bannerAd.size.width.toDouble(),
                    height: _bannerAd.size.height.toDouble(),
                    child: AdWidget(ad: _bannerAd),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class Exercise {
  String title;
  int time;

  Exercise({required this.title, required this.time});

  List<String> pngList = [
    'HOLD KEGAL',
    'PLANK',
    'REVERSE KEGAL',
    'SIDE PLANK LEFT',
    'SIDE PLANK RIGHT',
    'WALL SITS',
  ];

  String getImageAddress() {
    String imgAddress = 'images/' + title + '.gif';
    for (String png in pngList) {
      if (title == png) imgAddress = 'images/' + title + '.png';
    }

    return imgAddress;
  }
}

class Speech {
  String text;
  int time;

  Speech({
    required this.text,
    required this.time,
  });
}

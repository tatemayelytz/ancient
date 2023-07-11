import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:home_workout/event.dart';
import 'package:home_workout/ad_helper.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'complete_exercise_screen.dart';

class CalendarScreen extends StatefulWidget {
  static String id = 'calendarscreen';

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  var _selectedDay = DateTime.now();
  var _focusedDay = DateTime.now();

  late BannerAd _bannerAd;
  bool _isBannerAdReady = false;

  Map<DateTime, List<Event>> selectedEvents = {};
  TextEditingController _eventController = TextEditingController();

  void getSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    totalWorkouts = prefs.getInt('totalworkouts') ?? 0;
    workoutsThisMonth = prefs.getInt('workoutsThisMonth') ?? 0;
    workoutDays = [];
    for (int i = 0; i < totalWorkouts; i++) {
      workoutDays.add(prefs.getInt('workoutDays' + i.toString()) ?? 0);
    }
  }

  @override
  void initState() {
    selectedEvents = {};
    super.initState();

    getSavedData();

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
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  List<Event> _getEventsFromDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < workoutDays.length; i++) {
      selectedEvents[DateTime.utc(
          DateTime.now().year, DateTime.now().month, workoutDays[i])] = [
        Event(title: _eventController.text)
      ];
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Column(
                children: [
                  TableCalendar(
                    firstDay: DateTime.utc(2010, 10, 16),
                    lastDay: DateTime.utc(2030, 3, 14),
                    focusedDay: DateTime.now(),
                    eventLoader: _getEventsFromDay,
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                    },
                  ),
                  ..._getEventsFromDay(_selectedDay).map(
                    (Event event) => ListTile(
                      title: Text(event.title),
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            totalWorkouts.toString(),
                            style: TextStyle(
                              fontSize: 40,
                              color: Color(0xFF1ECBE1),
                            ),
                          ),
                          Text(
                            'Total Workouts',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            workoutsThisMonth.toString(),
                            style: TextStyle(
                              fontSize: 40,
                              color: Color(0xFF1ECBE1),
                            ),
                          ),
                          Text(
                            'Workouts this month',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
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
    );
  }
}

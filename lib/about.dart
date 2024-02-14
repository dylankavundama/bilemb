import 'dart:async';
import 'dart:ui';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(const MaterialApp(
    home: About(),
  ));
}

/// A simple app that loads a rewarded ad.
class About extends StatefulWidget {
  const About({super.key});

  @override
  AboutState createState() => AboutState();
}

class AboutState extends State<About> {
  final CountdownTimer _countdownTimer = CountdownTimer(10);
  //var _showWatchVideoButton = false;
  //var _coins = 0;
  RewardedAd? _rewardedAd;

  final String _adUnitId = Platform.isAndroid
      ? 'ca-app-pub-7329797350611067/4191692802'
      : 'ca-app-pub-7329797350611067/4191692802';
//Id app ca-app-pub-3940256099942544~3347511713
  @override
  void initState() {
    super.initState();

    _countdownTimer.addListener(() => setState(() {
          _rewardedAd?.show(
              onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {
            // ignore: avoid_print
          });
        }));
    _startNewGame();
  }

  void _startNewGame() {
    _loadAd();
    _countdownTimer.start();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onPressButon(context),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Color.fromARGB(15, 0, 0, 0),
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Text(
                    "Bilembo Ya béton a été développer  par la startup D-Corp Siégeant a Goma/NK  qui développe des solutions informatiques optimiser comme des logiciels de gestion d’entreprise, des applications mobiles et le site internet.",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              ),
              TextButton(
                  onPressed: () {
                    launch(
                        'https://www.linkedin.com/in/dylan-kavundama-61b34a208/');
                  },
                  child: Text('Plus d\info'))
            ],
          ),
        ),
      ),
    );
  }

  void _loadAd() {
    setState(() {
      RewardedAd.load(
          adUnitId: _adUnitId,
          request: const AdRequest(),
          rewardedAdLoadCallback: RewardedAdLoadCallback(onAdLoaded: (ad) {
            ad.fullScreenContentCallback = FullScreenContentCallback(
                // Called when the ad showed the full screen content.
                onAdShowedFullScreenContent: (ad) {},
                // Called when an impression occurs on the ad.
                onAdImpression: (ad) {},
                // Called when the ad failed to show full screen content.
                onAdFailedToShowFullScreenContent: (ad, err) {
                  ad.dispose();
                },
                // Called when the ad dismissed full screen content.
                onAdDismissedFullScreenContent: (ad) {
                  ad.dispose();
                },
                // Called when a click is recorded for an ad.
                onAdClicked: (ad) {});

            // Keep a reference to the ad so you can show it later.
            _rewardedAd = ad;
          }, onAdFailedToLoad: (LoadAdError error) {
            // ignore: avoid_print
            print('RewardedAd failed to load: $error');
          }));
    });
  }

  @override
  void dispose() {
    _rewardedAd?.dispose();
    _countdownTimer.dispose();
    super.dispose();
  }
}

Future<bool> _onPressButon(BuildContext context) async {
  bool? ext = await showDialog(
      context: context,
      builder: (BuildContext) {
        return AlertDialog(title: const Text('Quitter cette page'), actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text("Non"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text("Oui"),
          ),
        ]);
      });

  return ext ?? false;
}

enum CountdownState {
  notStarted,
  active,
  ended,
}

/// A simple class that keeps track of a decrementing timer.
class CountdownTimer extends ChangeNotifier {
  final _countdownTime = 10;
  late var timeLeft = _countdownTime;
  var _countdownState = CountdownState.notStarted;

  CountdownTimer(int i);

  bool get isComplete => _countdownState == CountdownState.ended;

  void start() {
    timeLeft = _countdownTime;
    _resumeTimer();
    _countdownState = CountdownState.active;

    notifyListeners();
  }

  void _resumeTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      timeLeft--;

      if (timeLeft == 0) {
        _countdownState = CountdownState.ended;
        timer.cancel();
      }

      notifyListeners();
    });
  }
}

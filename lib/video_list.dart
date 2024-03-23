import 'dart:io';

import 'package:bilembo/about.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:share/share.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

/// Creates list of video players
class VideoList extends StatefulWidget {
  @override
  _VideoListState createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  final List<YoutubePlayerController> _controllers = [
    'hSWv7Ho6yxA',
    'vvjWByp_z8I',
    '_ho87i_mxeI',
    'Wh8AXD0ejU0',
    'DWBHLhpSdr0',
    'Qnm24rM5xH8',
    'KxawspuxtvM',
    'EqQGRXqXFvI',
    '8W31FH1RiK4',
    '05IBm38Whh8',
    'qp5koc1u5Hk',
    'r5vYT4Bz1YM',
    '-9pQo9Kh-oU'
        'aD1PMEVzGHo',
    'Sr1F_H1cBGQ',
    '3_dozFprhwQ',
    'TNM51irGyJw',
    'lIffXy7F9y4',
    'gOFWb-G-LG8',
    'xvu6COsYlm8',
    'nTKVK4cLeq0',
    '0kiP_zqYJA0',
    '1tKPzeQQUpU',
    'K-hObx224qU',
    'asIEusZ_0Ww',
    '1HNjfBG8eWc',
    'B85xtIjv_z8',
    'gkKTMxup7Ns',
    'N9y1xcNi15Q',
    'd-pLhrqkgJQ',
    'OC9ZTH1e_TE',
    'Xi3M9l9ljX0',
    's12-mxgKq4A',
    '7TVngsx72-s',
    'qW2VW3_12Ng',
    'D3B-Daq4GIQ',
    '2r3eKFaaG8I',
    'f-IgLYcBwsM',
    'gFWXu5l9R7k',
    '_hmWQAsYSOs',
    'IisQ9g4pGfc',
    '5d7AXXl5a6A',
    '_zo1Dp984FY',
    '70hmXRDLYL0',
    'tToLOQcCBkY',
    'JFOkK1A-_ek',
    'vEoFxxs9hAY',
    'SDd5gMlShYw',
    'Pj8SsFfePjM',
    'g3INaczmvYQ',
  ]
      .map<YoutubePlayerController>(
        (videoId) => YoutubePlayerController(
          initialVideoId: videoId,
          flags: const YoutubePlayerFlags(
            autoPlay: false,
          ),
        ),
      )
      .toList();
  RewardedAd? _rewardedAd;

  final String _adUnitId = Platform.isAndroid
      ? 'ca-app-pub-7329797350611067/4191692802'
      : 'ca-app-pub-7329797350611067/4191692802';
  final CountdownTimer _countdownTimer = CountdownTimer(10);
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
  void _startNewGame() {
    _loadAd();
    _countdownTimer.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Image.asset(
            'assets/logo.png',
            fit: BoxFit.fitWidth,
          ),
        ),
        title: const Text(
          'Bilembo ya beton',
          style: TextStyle(color: Colors.black, fontSize: 19),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Colors.black),
            onPressed: () {
              Share.share(
                  'https://play.google.com/store/apps/details?id=com.bilembo');
            },
          ),
        ],
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return YoutubePlayer(
            key: ObjectKey(_controllers[index]),
            controller: _controllers[index],
            actionsPadding: const EdgeInsets.only(left: 16.0),
            bottomActions: [
              CurrentPosition(),
              const SizedBox(width: 10.0),
              ProgressBar(isExpanded: true),
              const SizedBox(width: 10.0),
              RemainingDuration(),
              FullScreenButton(),
            ],
          );
        },
        itemCount: _controllers.length,
        separatorBuilder: (context, _) => const SizedBox(height: 10.0),
      ),
    );
  }
}

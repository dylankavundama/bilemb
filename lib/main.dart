import 'package:bilembo/about.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bilembo/Home.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  WidgetsFlutterBinding.ensureInitialized();

  await Future.delayed(const Duration(seconds: 1));

  OneSignal.shared.setAppId("c2f6248a-3c61-4381-a341-c6aa815cca8d");

  OneSignal.shared.setNotificationWillShowInForegroundHandler(
      (OSNotificationReceivedEvent event) {});
  OneSignal.shared
      .promptUserForPushNotificationPermission()
      .then((accepted) {});
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );

    return MaterialApp(
      title: 'Bilembo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: OnBoardingPage(),
    );
  }
}

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  OnBoardingPageState createState() => OnBoardingPageState();
}

class OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => acceuil()),
    );
  }

  Widget _buildFullscreenImage() {
    return Image.asset(
      'assets/aa.jpg',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      allowImplicitScrolling: true,
      autoScrollDuration: 3000,
      //   infiniteAutoScroll: true,

      globalFooter: SizedBox(
        width: double.infinity,
        height: 60,
        child: TextButton(
          child: const Text(
            'Demarrer!',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          onPressed: () => _onIntroEnd(context),
        ),
      ),
      pages: [
        PageViewModel(
          title: "Bilembo Ya Beton",
          bodyWidget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Changement", style: bodyStyle),
              Icon(Icons.edit),
              Text("Progres", style: bodyStyle),
            ],
          ),
          decoration: pageDecoration.copyWith(
            bodyFlex: 2,
            imageFlex: 4,
            bodyAlignment: Alignment.bottomCenter,
            imageAlignment: Alignment.topCenter,
          ),
          image: _buildImage('logo.png'),
          reverse: true,
        ),
        PageViewModel(
          title: "Bilembo Ya Beton",
          body:
              "Suivez en temps réel un Congo qui change, qui va de l'avant, raconté par le Congo Profond!",
          image: _buildImage('c.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Bilembo Ya Beton",
          body:
              "Les Congolais de partout s'expriment eux-mêmes sur \nles réalisations du Président Félix Tshisekedi. Suivez \nle Congo qui change en temps réel.",
          image: _buildFullscreenImage(),
          decoration: pageDecoration.copyWith(
            contentMargin: const EdgeInsets.symmetric(horizontal: 16),
            fullScreen: true,
            bodyFlex: 2,
            imageFlex: 3,
            safeArea: 100,
          ),
        ),
                PageViewModel(
          title: "Bilembo Ya Beton",
          body: "Plus de 6 Millions d'enfants ont regagneé le parcours scolaires grace a la Gratuité",
          image: _buildImage('ee.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Bilembo Ya Beton",
          body:
              "Suivez en temps réel un Congo qui change, qui va de l'avant, raconté par le Congo Profond!",
          image: _buildImage('d.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Bilembo Ya Beton",
          body: "Aller le Leopards",
          image: _buildImage('bb.jpg'),
          decoration: pageDecoration,
        ),

                PageViewModel(
          title: "Bilembo Ya Beton",
          body:  "Les Congolais de partout s'expriment eux-mêmes sur les réalisations du Président Félix Tshisekedi. Suivez le Congo qui change en temps réel.",
          image: _buildImage('b.png'),
          decoration: pageDecoration,
        ),
      ],
      onDone:  () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => About()),
                );
              },
      onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,
   //   rtl: true, // Display as right-to-left
      back: const Icon(Icons.arrow_back),
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white)),
      next: const Icon(Icons.arrow_forward),
      done: const Text('info', style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.black87,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: const Center(child: Text("This is the screen after Introduction")),
    );
  }
}

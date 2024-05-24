import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/LoginView.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  void goToNextScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8FFC0CB),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(
              'images/Chatlottie.json',
              width: 200,
              height: 200,
              fit: BoxFit.cover,
              onLoaded: (composition) {
                Future.delayed(const Duration(seconds: 2), goToNextScreen);
              },
            ),
            const SizedBox(height: 10),
            const Text(
              'Welcome to Chatty',
              style: TextStyle(
                fontSize: 25,
                letterSpacing: 2.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFFF9C4),
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.only(left: 30, right: 27),
              child: Text(
                'Chat with your Friends, Share your videos and photos files fast with High quality.',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 110),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 190),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text(
                'Get Started',
                style: TextStyle(
                  color: Color(0xFFFFF9C4),
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

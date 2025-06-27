import 'dart:convert';

import 'package:afran/constant/app_colors.dart';
import 'package:afran/constant/app_images.dart';
import 'package:afran/constant/app_strings.dart';
import 'package:afran/constant/secure_storage.dart';
import 'package:afran/entity/user_model.dart';
import 'package:afran/home/screens/app_nav_bar.dart';
import 'package:afran/onboarding/screens/onBoarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';




import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () async{
      final secureStorage = SecureStorageService();

      String? userData = await secureStorage.read(user);
      if(userData != null){
        UserModel userModel = UserModel.fromJson(jsonDecode(userData));
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  AppBottomNavBar(userModel: userModel,)),
        );
      }else{
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  OnboardingPage()),
        );
      }

    });

    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.0), // Slide up from bottom
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _scaleAnimation = Tween<double>(
      begin: 0.6,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,

        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              darkPurple2,

              purple2,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SlideTransition(
            position: _slideAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Container(
                width: 290,
                height: 290,

                child: Center(
                  child: Image.asset(splash)
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

}



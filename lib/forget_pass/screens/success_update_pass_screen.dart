import 'package:afran/constant/app_images.dart';
import 'package:afran/constant/app_text_style.dart';
import 'package:afran/constant/main_app_button.dart';
import 'package:afran/login/screen/login_screen.dart';
import 'package:afran/verification/screens/verify_ecreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SuccessUpdatePassScreen extends StatelessWidget {
  const SuccessUpdatePassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(success),
             SizedBox(height: 32,),
             Text(
              'تم تحديث كلمة المرور بنجاح',
              style: text70020,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32,),
            MainAppButton(
              title: 'تسجيل الدخول',
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) =>  OtpVerificationScreen()),
                // );
                Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  LoginPage()),
                    );
              },),

          ],
        ),
      ),
    );
  }
  
}

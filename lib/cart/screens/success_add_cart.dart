import 'package:afran/constant/app_images.dart';
import 'package:afran/constant/app_text_style.dart';
import 'package:afran/constant/main_app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SuccessAddCart extends StatelessWidget {
  const SuccessAddCart({super.key});

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
              'تم الطلب بنجاح!',
              style: text70020,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32,),
            MainAppButton(
              title: 'تابع الطلب',
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) =>  OtpVerificationScreen()),
                // );
              },),

          ],
        ),
      ),
    );
  }
}


import 'package:afran/constant/app_colors.dart';
import 'package:afran/constant/app_text_field.dart';
import 'package:afran/constant/app_text_style.dart';
import 'package:afran/constant/main_app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SuccessTrackingScreen extends StatelessWidget {
  const SuccessTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 96,width: 96,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(1000),
                  child: Image.network(
                      fit: BoxFit.cover,
                      'https://plus.unsplash.com/premium_photo-1690407617542-2f210cf20d7e?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cGVyc29ufGVufDB8fDB8fHww'),
                ),
              ),
              SizedBox(height: 24,),
              Text('تم تسليم طلبك بنجاح',style: text70020,),
              SizedBox(height: 8,),
              Text('منذ ٥ دقايق',style: text50014.copyWith(color: grey3,fontSize: 18),),
              SizedBox(height: 24,),
              Text('كيف كانت تجربتك مع التوصيل ؟',style: text70020,),
              SizedBox(height: 8,),
              Center(
                child: RatingBar.builder(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
              ),
              SizedBox(height: 16,),
              AppTextField(
                  minLines: 2,
                  maxLines: 3,
                  hintText: 'شاركنا تجربتك'),
              SizedBox(height: 16,),
              Row(
                children: [
                  Expanded(child: Container(child: MainAppButton(
                      onPressed: (){}, title: 'ارسال التقييم'))),

                  SizedBox(width: 8,),

                  Expanded(child: Container(child: MainAppButton(
                      backgroundColor: purple,
                      titleColor: darkPurple2,
                      onPressed: (){}, title: 'طلب مرة اخري'))),
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}


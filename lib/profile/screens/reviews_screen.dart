import 'package:afran/constant/app_colors.dart';
import 'package:afran/constant/app_text_style.dart';
import 'package:afran/constant/main_app_bar.dart';
import 'package:afran/products/widgets/feedbacks_widget.dart';
import 'package:flutter/material.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: MainAppBar(title: 'أراء المستخدم'),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 30),
          child: SingleChildScrollView(

            child: Column(
              children: [
                // Row(
                //   children: [
                //     Container(
                //       height: 72,width: 72,
                //       decoration: BoxDecoration(
                //         shape: BoxShape.circle
                //       ),
                //     ),
                //     SizedBox(width: 16,),
                //
                //   ],
                // ),
                ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    itemBuilder: (context,index){
                      // return FeedBackItem();
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


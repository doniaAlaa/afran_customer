
import 'package:afran/constant/app_colors.dart';
import 'package:afran/constant/app_strings.dart';
import 'package:afran/constant/app_text_style.dart';
import 'package:afran/constant/main_app_button.dart';
import 'package:afran/constant/secure_storage.dart';
import 'package:afran/login/screen/login_screen.dart';
import 'package:flutter/material.dart';

class DeleteCartItem{

  Future<bool?> removeItem(BuildContext context){
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        insetPadding: EdgeInsets.symmetric(horizontal: 16), // Remove default padding
        contentPadding: EdgeInsets.zero, // Optional: control inner spacing
        title: Directionality(
            textDirection: TextDirection.rtl,
            child: Text('هل أنت متأكد أنك تريد إزالة العنصر؟',style: text70016,)),
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(height: 8,),
              // Text('سيتم إنهاء الجلسة الحالية، ويمكنك تسجيل الدخول مرة أخرى في أي وقت.',
              //   textAlign: TextAlign.end,
              //   style: text50014.copyWith(color: semiBlack,),),
              SizedBox(height: 20,),

              SizedBox(

                width: MediaQuery.of(context).size.width ,  // custom width
                height: 60, // custom height
                child: Row(
                  children: [
                    Expanded(child: Container(child: MainAppButton(
                        backgroundColor: grey2,
                        titleColor: grey3,
                        onPressed: (){
                          Navigator.pop(context, false);
                        }, title: 'إلغاء'))),
                    SizedBox(width: 16,),
                    Expanded(child: Container(child: MainAppButton(onPressed: ()async{
                      Navigator.pop(context, true);
                    }, title: 'موافق'))),

                  ],
                ),
              ),
            ],
          ),
        ),

      ),
    );

  }
}
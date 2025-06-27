import 'package:afran/constant/app_colors.dart';
import 'package:afran/constant/app_text_style.dart';
import 'package:afran/constant/main_app_bar.dart';
import 'package:flutter/material.dart';

class SettingNotificationsScreen extends StatelessWidget {
  const SettingNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar:MainAppBar(title: 'الإشعارات'),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 30),
                child: ListView.builder(
                  shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.only(bottom :16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: grey,
                        borderRadius: BorderRadius.circular(16)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('السماح بالإشعارات',style: text70016,),
                                SizedBox(height: 4,),
                                Text('إشعارات التطبيق',style: text40012.copyWith(color: grey3),),
                              ],
                            ),
                            Transform.scale(
                              scale: 0.69, // increase or decrease the size
                              child: Switch(
                                value: true,
                                onChanged: (value) {
                                  // setState(() {
                                  //   _isSwitched = value;
                                  // });
                                },
                                activeColor: Colors.white,
                                activeTrackColor: darkPurple,
                                inactiveThumbColor: Colors.white,
                                inactiveTrackColor: Colors.purple,
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  );
                }),
              )
            ],
          ),
        ),

      ),
    );
  }
}


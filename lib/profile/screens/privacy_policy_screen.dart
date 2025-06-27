import 'package:afran/constant/app_colors.dart';
import 'package:afran/constant/app_text_style.dart';
import 'package:afran/constant/main_app_bar.dart';
import 'package:afran/profile/controllers/privacy_policy_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrivacyPolicyScreen extends StatelessWidget {
   PrivacyPolicyScreen({super.key});

  PrivacyPolicyController privacyPolicyController = Get.put(PrivacyPolicyController());
  @override
  Widget build(BuildContext context) {
    privacyPolicyController.getPrivacyPolicy();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: MainAppBar(title: 'سياسة الخصوصية'),
        body:Obx((){
          return privacyPolicyController.loading.value? Center(
            child: Container(
                height: 50,width: 50,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: CircularProgressIndicator(color: darkPurple,strokeWidth: 1.8,),
                )),
          ):  Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 30),
              child: ListView.builder(
                  itemCount: privacyPolicyController.privacyList.length,
                  itemBuilder: (context,index){
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(privacyPolicyController.privacyList[index]['title'],style: text70018,),
                    SizedBox(height: 8,),
                    Text(privacyPolicyController.privacyList[index]['description'],style: text50016.copyWith(color: grey3),),

                  ],
                );
              })
          );
        })
      ),
    );

  }
}


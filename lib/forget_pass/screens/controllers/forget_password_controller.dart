import 'dart:convert';

import 'package:afran/constant/app_apis.dart';
import 'package:afran/constant/app_strings.dart';
import 'package:afran/constant/dio_client.dart';
import 'package:afran/constant/secure_storage.dart';
import 'package:afran/entity/user_model.dart';
import 'package:afran/forget_pass/screens/add_new_pass_screen.dart';
import 'package:afran/forget_pass/screens/success_update_pass_screen.dart';
import 'package:afran/verification/screens/verify_ecreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController{

  RxBool loading = false.obs;
  TextEditingController emailPhoneController = TextEditingController();

  Future<bool> forgetPass(BuildContext context, {bool retry = false}) async{
   loading.value = true;
   bool success = false;
    await DioClient().postAPI(
        forgotPass,
        {
          "identifier": emailPhoneController.text,
          "role": "customer"
        }

    ).then((result) async{
      loading.value = false;
      print(result);
      if(result['statusCode'] == 200 || result['statusCode'] == 201){
        const snackBar = SnackBar(

            backgroundColor: Colors.green,
            content: Text('تم إرسال رمز التحقق بنجاح',textAlign: TextAlign.start,));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) =>  AddNewPassScreen(forgetPasswordController: this,)),
        // );
        if(retry == true){

        }else{
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  OtpVerificationScreen(

              idintifier: emailPhoneController.text,
              forgetPasswordController: this,
            )),
          );
        }

        success = true;

      }else if(result['statusCode'] == 422){
        const snackBar = SnackBar(

            backgroundColor: Colors.red,
            content: Text('هذه البيانات غير معرفة',textAlign: TextAlign.start,));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        success = false;
      }

    }).catchError((error){
      loading.value = false;
      success = false;
    });

    return success;

  }
  //////////////

  TextEditingController confirmPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  RxBool resetPassLoading = false.obs;

  resetPass(BuildContext context,String identifier,String reset_token) async{
    resetPassLoading.value = true;


    await DioClient().postAPI(
        resetPassword,
        {
          "identifier": "${identifier}",
          "reset_token": "${reset_token}",
          "password": newPassController.text,
          "password_confirmation": confirmPassController.text,
          "role": "customer"
        }

    ).then((result) async{
      resetPassLoading.value = false;
      print(result);
      if(result['statusCode'] == 200 || result['statusCode'] == 201){
        const snackBar = SnackBar(

            backgroundColor: Colors.green,
            content: Text('تم تغيير كلمة المرور بنجاح',textAlign: TextAlign.start,));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  SuccessUpdatePassScreen()),
        );

      }else if(result['statusCode'] == 422){
        const snackBar = SnackBar(

            backgroundColor: Colors.red,
            content: Text('حدث خطأ ، يرجى المحاولة مرة أخرى',textAlign: TextAlign.start,));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }

    }).catchError((error){
      resetPassLoading.value = false;
    });

  }


}
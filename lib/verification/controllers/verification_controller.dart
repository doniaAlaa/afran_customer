import 'package:afran/constant/app_apis.dart';
import 'package:afran/constant/dio_client.dart';
import 'package:afran/forget_pass/screens/add_new_pass_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class VerificationController extends GetxController{
  RxBool loading = false.obs;
  TextEditingController otpController = TextEditingController();


  verify(BuildContext context,String otp,String idintifier, {bool toChangePass = false}) async{
    loading.value = true;
    print(idintifier);
    await DioClient().postAPI(
        verifyOtp,
        {
          "identifier": idintifier,
          "otp": otpController.text,
          "role": "customer"
        }

    ).then((result) async{
      loading.value = false;
      print(result);
      if(result['statusCode'] == 200 || result['statusCode'] == 201){
        const snackBar = SnackBar(

            backgroundColor: Colors.green,
            content: Text('تم التحقق بنجاح',textAlign: TextAlign.start,));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        if(toChangePass == true){
          print(toChangePass);
          print( result['data']['data']['reset_token']);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  AddNewPassScreen(identifier:idintifier,reset_token: result['data']['data']['reset_token'],)),
          );
        }
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) =>  OtpVerificationScreen(idintifier: emailPhoneController.text,)),
        // );


      }else if(result['statusCode'] == 422){
        const snackBar = SnackBar(

            backgroundColor: Colors.red,
            content: Text('رمز التحقق غير صحيح أو منتهى الصلاحية',textAlign: TextAlign.start,));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      otpController.clear();
    }).catchError((error){
      loading.value = false;
      const snackBar = SnackBar(

          backgroundColor: Colors.red,
          content: Text('حدث خطأ ، يرجى المحاولة مرة أخرى',textAlign: TextAlign.start,));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
    otpController.clear();


  }

}
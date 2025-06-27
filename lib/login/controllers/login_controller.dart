import 'dart:convert';

import 'package:afran/constant/app_apis.dart';
import 'package:afran/constant/app_strings.dart';
import 'package:afran/constant/dio_client.dart';
import 'package:afran/constant/secure_storage.dart';
import 'package:afran/entity/user_model.dart';
import 'package:afran/home/screens/app_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{

  RxBool isLoading = false.obs;

  login(BuildContext context,dynamic data) async{
    isLoading.value = true;
     await DioClient().postAPI(
      loginApi,
        data

    ).then((result) async {
      isLoading.value = false;
      print('kkkkkkkkkkkkkkkk${result['statusCode']}');
      if(result['statusCode'] == 200 || result['statusCode'] == 201){
        if(result != null && result['data']['status'] == true){
          Map<String, dynamic> userData = result['data']['data']['user'];
          final secureStorage = SecureStorageService();
          await secureStorage.write(userToken,'${result['data']['data']['token']}');
          await secureStorage.write(user, jsonEncode(userData));
          UserModel userModel = UserModel.fromJson(userData);
          String? hh = await secureStorage.read(userToken);

          print('ddddddddddd${hh}');

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AppBottomNavBar(userModel: userModel,)),
          );


        }else{
          const snackBar = SnackBar(

              backgroundColor: Colors.red,
              content: Text('يوجد خطأ فى رقم الهاتف أو كلمة المرور',textAlign: TextAlign.end,));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }else if(result['statusCode'] == 401){
        const snackBar = SnackBar(

            backgroundColor: Colors.red,
            content: Text('البيانات المرسلة غير صحيحة',textAlign: TextAlign.end,));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }

    }).catchError((error){
      isLoading.value = false;
     });



  }
}
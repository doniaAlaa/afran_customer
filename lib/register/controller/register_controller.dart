import 'dart:convert';

import 'package:afran/constant/app_apis.dart';
import 'package:afran/constant/app_strings.dart';
import 'package:afran/constant/dio_client.dart';
import 'package:afran/constant/secure_storage.dart';
import 'package:afran/entity/user_model.dart';
import 'package:afran/home/screens/app_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

class RegisterController extends GetxController{

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController passConfirmationController = TextEditingController();
  RxBool loading = false.obs;

  ////REGISTER ACCOUNT///
  register(BuildContext context) async{
   print(phoneController.text);

    dio.FormData formData = dio.FormData.fromMap({
      'name': nameController.text,
      'email': emailController.text,
      'phone': '+966${phoneController.text}',
      'password': passController.text,
      'role': 'customer',
      'is_active': '1'

      // "image": await MultipartFile.fromFile(filePath, filename: fileName),

    });
    loading.value =true;
    await DioClient().postAPI(
        registerApi,
        formData

    ).then((result) async{
      loading.value = false;
      print(result['data']);
      if(result['statusCode'] == 200 || result['statusCode'] == 201 ){
        print(result['data']['status']);
        if( result['data']['status'] == true){
          Map<String, dynamic> userData = result['data']['data']['user'];
          print(result['data']['data']['user']);
          print(result['data']['data']['token']);
          final secureStorage = SecureStorageService();
          //
          await secureStorage.write(userToken,'${result['data']['data']['token'].toString()}');
          await secureStorage.write(user, jsonEncode(userData));
          print('object');
          UserModel userModel = UserModel.fromJson(userData);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AppBottomNavBar(userModel: userModel,)),
          );


        }else {

        }
      }else if(result['statusCode'] == 422){
        const snackBar = SnackBar(
            backgroundColor: Colors.red,
            content: Text('رقم الهاتف أو البريد الإلكتروني أو كلاهما مسجل بالفعل'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }

    }).catchError((error){
      loading.value = false;
    });
  }



}
import 'dart:convert';


import 'package:afran/constant/app_apis.dart';
import 'package:afran/constant/app_strings.dart';
import 'package:afran/constant/dio_client.dart';
import 'package:afran/constant/secure_storage.dart';
import 'package:afran/entity/user_model.dart';
import 'package:afran/home/screens/app_nav_bar.dart';
import 'package:dio/dio.dart' as dio;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserInfoController extends GetxController{
RxBool updateLoading = false.obs;
RxBool loading = false.obs;
TextEditingController nameController = TextEditingController();
TextEditingController familyNameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController phoneController = TextEditingController();
TextEditingController productCategoryController = TextEditingController();
RxInt selectedCategoryId = (-1).obs;
RxInt selectedButton = (0).obs;

  getUserInfo() async{
    loading.value = true;
    await DioClient().getAPI(
      '${baseUrl}/me',

    ).then((result) async {
      if(result['status'] == true){
        List<dynamic> data = result['data'];
        print('nnnnnnnnnnnn${data.length}');

        try{

          print('object');
        }catch(e){
          print(',,,,,,,,,,,,,${e}');
        }



      }
      loading.value = false;
    }).catchError((err){
      loading.value = false;

    });
  }

  updateAccountInfo(BuildContext context) async{

    final secureStorage = SecureStorageService();
    String? userData = await secureStorage.read(user);
    UserModel userModel = UserModel.fromJson(jsonDecode(userData!));

    var data = dio.FormData.fromMap({
      'name': nameController.text,
      'email': emailController.text,
      'phone': userModel.phone,
      'password': '123456',
      'role': 'provider',
      'location': 'New York',
      'lat': '29.949682',
      'long': '30.901579',
      'owner': familyNameController.text,
      'category_id': '1',
      'open': '10:00 AM',
      'close': '11:00 PM',
      '_method': 'PUT'
    });
    updateLoading.value = true;

    await DioClient().postAPI(
      '${baseUrl}/profile',
      data

    ).then((result) async {
      if(result['data']['status'] == true){

        const snackBar = SnackBar(
            backgroundColor: Colors.green,
            content: Text('تم تعديل معلومات الحساب بنجاح'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Map<String, dynamic> userData = result['data']['data'];
        // print('nnnnnnnnnnnnn${result['data']['data']}');
        await secureStorage.write(user, jsonEncode(userData));
        UserModel userModel = UserModel.fromJson(userData);


        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AppBottomNavBar(userModel: userModel,)),
        );



      }
      updateLoading.value = false;
    }).catchError((err){
      updateLoading.value = false;

    });
  }

  updateProfileImage(BuildContext context,FilePickerResult? result) async{

    final secureStorage = SecureStorageService();
    String? userData = await secureStorage.read(user);
    UserModel userModel = UserModel.fromJson(jsonDecode(userData!));

    var data = dio.FormData.fromMap({
      'image': [
        await dio.MultipartFile.fromFile(result?.files.first.path??'', filename: 'test')
      ],
      // '_method': 'PUT'
    });
    updateLoading.value = true;

    await DioClient().postAPI(
      '${baseUrl}/profile/image',
      data

    ).then((result) async {
      if(result['status'] == true){

        const snackBar = SnackBar(
            backgroundColor: Colors.green,
            content: Text('تم تعديل الصورة الشخصية بنجاح'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);




      }
      updateLoading.value = false;
    }).catchError((err){
      print('//////////////');
      updateLoading.value = false;

    });
  }

}
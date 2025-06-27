import 'dart:convert';

import 'package:afran/cart/screens/cart_steps.dart';
import 'package:afran/constant/app_apis.dart';
import 'package:afran/constant/dio_client.dart';
import 'package:afran/home/models/product_model.dart';
import 'package:afran/profile/models/feedback_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsController extends GetxController{
  RxBool loading = false.obs;
  RxBool feedbackLoading = false.obs;
  RxBool buttonLoading = false.obs;
  RxBool feedbackButtonLoading = false.obs;
  RxList<SizesAndAddons> selectedAddons = <SizesAndAddons>[].obs;
  RxList<int> selectedAddonsIds = <int>[].obs;
  Rx<SizesAndAddons>? selectedAddonItem = SizesAndAddons().obs;
  TextEditingController addonController = TextEditingController();
  TextEditingController feedBackController = TextEditingController();

  ProductModel? productsDetails ;
  RxInt quantity = 1.obs;
  RxString dateDetails = "اختر موعد التوصيل".obs;
  RxList<FeedbackModel> feedbacksListForItem = <FeedbackModel>[].obs;

  getProductDetails(int itemIndex) async{
    loading.value = true;
    await DioClient().getAPI(
      '${baseUrl}/products/${itemIndex}?lat=29.787310&long=31.301227',

    ).then((result) async {

      if(result['statusCode'] == 200 || result['statusCode'] ==  201){
        print('nnnnnnnnnnnn${result}');

        Map<String, dynamic> data = result['data']['data'];

        try{
          productsDetails =  ProductModel.fromJson(data);
        }catch(e){
          print(',,,,,,,,,,,,,${e}');
        }



      }
      loading.value = false;
    }).catchError((err){
      loading.value = false;

    });
  }

  ////ADD PRODUCT TO MY Cart///
  TextEditingController notesController = TextEditingController();
  RxInt sizeId = (-1).obs;
  addToCart(BuildContext context,int productId) async{
    buttonLoading.value = true;
    var data = {
      "product_id": productId,
      "size_id": sizeId.value,
      "quantity": quantity.value,
      "addons": selectedAddonsIds
    };
    await DioClient().postAPI(
        '$baseUrl/cart/add',
        data

    ).then((result) async{
      buttonLoading.value = false;
        if(result['statusCode'] == 200 || result['statusCode'] == 201){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  CartStepper(notes: notesController.text,)),
          );
          const snackBar = SnackBar(

              backgroundColor: Colors.green,
              content: Text('تم إضافة العنصر إلى السلة',textAlign: TextAlign.start,));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);


        }


    }).catchError((error){
      print(error);
      buttonLoading.value = false;
      const snackBar = SnackBar(

          backgroundColor: Colors.red,
          content: Text('حدث خطأ ، يرجى المحاولة مرة أخرى',textAlign: TextAlign.end,));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });



  }

  ////ADD FEEDBACK///
  addFeedBack(BuildContext context,int productId) async{
    feedbackButtonLoading.value = true;
    var data = {
      "product_id":productId,
      "rating":5,
      "feedback": feedBackController.text
    };
    await DioClient().postAPI(
        '$baseUrl/feedbacks',
        data

    ).then((result) async{
      feedbackButtonLoading.value = false;
      print(result);


      const snackBar = SnackBar(

          backgroundColor: Colors.green,
          content: Text('تم إرسال رأيك بنجاح',textAlign: TextAlign.start,));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);



    }).catchError((error){
      print(error);
      feedbackButtonLoading.value = false;
      const snackBar = SnackBar(

          backgroundColor: Colors.red,
          content: Text('حدث خطأ ، يرجى المحاولة مرة أخرى',textAlign: TextAlign.end,));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });



  }

  getItemFeedbacks(int itemID) async{
    feedbackLoading.value = true;
    await DioClient().getAPI(
      '${baseUrl}/feedbacks?product_id=${itemID}',

    ).then((result) async {
      feedbackLoading.value =false;
      if(result['data']['status'] == true){
        List<dynamic> data = result['data']['data'];
        data.forEach((e){
          feedbacksListForItem.add(FeedbackModel.fromJson(e));
        });





      }
    }).catchError((err){
      feedbackLoading.value = false;

    });
  }


}
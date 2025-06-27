import 'package:afran/cart/models/cart_model.dart';
import 'package:afran/constant/app_apis.dart';
import 'package:afran/constant/dio_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController{

  RxBool loading = true.obs;
  RxBool deleteCartItemLoading = false.obs;
  Rx<CartModel> cartItems = CartModel().obs;
  Rx<int> cartItemQuantity = (-1).obs;
  RxString dateDetails = "اختر موعد التوصيل".obs;
  RxString deliveryWay = "".obs;
  RxBool deliveryWayTap = false.obs;
  Rx<TextEditingController> deliveryWayController = TextEditingController().obs;
  String selectedDate = ''; // like 2025-06-25 20:48:00.000
  getCart() async{
    loading.value = true;
    await DioClient().getAPI(
      '${baseUrl}/cart',

    ).then((result) async {
      loading.value = false;
      print('-----------${result['data']}');
      Map<String,dynamic> data = result['data'];

      try{

        cartItems.value = CartModel.fromJson(data);

        print(cartItems.value.total_price);
      }catch(e){
        print(',,,,,,,,,,,,,${e}');
      }


    }).catchError((err){
      print(err);
      loading.value = false;

    });
  }

  removeCartItem(int index,int itemId,BuildContext context) async{
    // loading.value = true;
    await DioClient().postAPI(
      '${baseUrl}/cart/remove',
        {
          "cart_item_id": itemId
        }

    ).then((result) async {
      // loading.value = false;
      if(result['statusCode'] == 200 || result['statusCode'] == 201){
        // Map<String,dynamic> data = result;
        // print('nnnnnnnnnnnn${data.toString()}');

        cartItems.value.items?.removeAt(index);
        print(cartItems.value.items!.isEmpty);
        getCart();

        const snackBar = SnackBar(

            backgroundColor: Colors.green,
            content: Text('تم إزالة العنصر بنجاح',textAlign: TextAlign.start,));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }



    }).catchError((err){
      print(err);
      // loading.value = false;

    });
  }

  ///// TAP ON DELIVERY WAY /////
  tapOnDeliveryWay(){
    deliveryWayTap.value = !deliveryWayTap.value;
  }
  //////    MAKE ORDER   //////
  RxBool addingOrderLoading = false.obs;
  String notes = '';
  Future<bool> orderProduct(BuildContext context) async{
    bool success = false;
    print(deliveryWay.value == 'توصيل'?"delivery":"pickup");
    print('notes$notes');
    addingOrderLoading.value = true;
    await DioClient().postAPI(
        '${baseUrl}/orders',
        {
          "delivery_method": deliveryWay.value == 'توصيل'?"delivery":"pickup",
          "delivery_date": selectedDate,
          "notes": notes,
          "location": "1234 Elm St, City, Country",
          "lat": "40.7128",
          "long": "-74.0060",
          "payment_method": "cash"

        }


    ).then((result) async {
      addingOrderLoading.value = false;
      if(result['statusCode'] == 200 || result['statusCode'] == 201){
        const snackBar = SnackBar(

            backgroundColor: Colors.green,
            content: Text('تم إرسال طلبك بنحاح',textAlign: TextAlign.end,));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        success = true;
      }else{
        success = false;
      }



    }).catchError((err){
      // print(err);
      addingOrderLoading.value = false;
      success = false;

    });

    return success;

  }

}
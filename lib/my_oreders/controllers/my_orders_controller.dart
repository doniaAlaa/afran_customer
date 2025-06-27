import 'package:afran/constant/app_apis.dart';
import 'package:afran/constant/dio_client.dart';
import 'package:afran/my_oreders/models/my_orders_model.dart';
import 'package:get/get.dart';

class MyOrderController extends GetxController{
  RxBool loading = false.obs;
  RxList<MyOrdersModel> myOrdersList = <MyOrdersModel>[].obs;

  getMyOrders() async{
    loading.value = true;
    await DioClient().getAPI(
      '${baseUrl}/myOrders',

    ).then((result) async {
      loading.value = false;
      print(result['data']['data'].runtimeType);
      List<dynamic> orders = result['data']['data'];
      orders.forEach((e){
        myOrdersList.add(MyOrdersModel.fromJson(e));
      });
      // if(result['data']['data'])
      // {status: true, data: [], message: Orders fetched successfully}
      // Map<String,dynamic> data = result;
      try{
        // cartItems.value = CartModel.fromJson(data);
        //
      }catch(e){
        print(',,,,,,,,,,,,,${e}');
      }


    }).catchError((err){
      print(err);
      loading.value = false;

    });
  }

}
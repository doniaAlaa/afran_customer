import 'package:afran/profile/models/feedback_model.dart';
import 'package:get/get.dart';

class FeedBackController extends GetxController{

  RxBool loading = false.obs;
  // RxList<FeedbackModel> myFeedbacks = [];

  // getFeedbacks() async{
  //   loading.value = true;
  //   await DioClient().getAPI(
  //     '${baseUrl}/myOrders',
  //
  //   ).then((result) async {
  //     loading.value = false;
  //     print(result['data']['data'].runtimeType);
  //     List<dynamic> orders = result['data']['data'];
  //     orders.forEach((e){
  //       myOrdersList.add(MyOrdersModel.fromJson(e));
  //     });
  //     // if(result['data']['data'])
  //     // {status: true, data: [], message: Orders fetched successfully}
  //     // Map<String,dynamic> data = result;
  //     try{
  //       // cartItems.value = CartModel.fromJson(data);
  //       //
  //     }catch(e){
  //       print(',,,,,,,,,,,,,${e}');
  //     }
  //
  //
  //   }).catchError((err){
  //     print(err);
  //     loading.value = false;
  //
  //   });
  // }

}
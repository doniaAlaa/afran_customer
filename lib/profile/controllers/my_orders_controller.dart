// import 'package:afran_provider/constant/app_apis.dart';
// import 'package:afran_provider/constant/dio_client.dart';
// import 'package:get/get.dart';
//
// class MyOrdersController extends GetxController{
//
//   RxBool loading = false.obs;
//   // RxList<FaqModel> faqList = <FaqModel>[].obs;
//
//   getMyOrders() async{
//     loading.value = true;
//     await DioClient().getAPI(
//       '${baseUrl}/myOrders',
//
//     ).then((result) async {
//       if(result['status'] == true){
//         // faqList.clear();
//         List<dynamic> data = result['data'];
//         print('nnnnnnnnnnnn${result}');
//
//         try{
//           // data.forEach((e){
//           //   faqList.add(FaqModel.fromJson(e));
//           // });
//         }catch(e){
//           print(',,,,,,,,,,,,,${e}');
//         }
//
//
//
//       }
//       loading.value = false;
//     }).catchError((err){
//       loading.value = false;
//
//     });
//   }
//
//
// }
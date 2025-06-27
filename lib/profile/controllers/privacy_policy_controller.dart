
import 'package:afran/constant/app_apis.dart';
import 'package:afran/constant/dio_client.dart';
import 'package:get/get.dart';

class PrivacyPolicyController extends GetxController{

  RxBool loading = false.obs;
  RxList<dynamic> privacyList = <dynamic>[].obs;

  getPrivacyPolicy() async{
    loading.value = true;
    await DioClient().getAPI(
      '${baseUrl}/terms?type=privacy_policy&user_type=customer',

    ).then((result) async {
      if(result['status'] == true){
        privacyList.clear();
        List<dynamic> data = result['data'];

        try{
          data.forEach((e){
            privacyList.add(e);
          });
        }catch(e){
        }



      }
      loading.value = false;
    }).catchError((err){
      loading.value = false;

    });
  }


}
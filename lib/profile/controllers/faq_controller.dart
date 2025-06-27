
import 'package:afran/constant/app_apis.dart';
import 'package:afran/constant/dio_client.dart';
import 'package:afran/profile/models/faq_model.dart';
import 'package:get/get.dart';

class FAQController extends GetxController{

  RxBool loading = false.obs;
  RxList<FaqModel> faqList = <FaqModel>[].obs;

  getFAQ() async{
    loading.value = true;
    await DioClient().getAPI(
      '${baseUrl}/faqs?type=customer',

    ).then((result) async {
      if(result['status'] == true){
        faqList.clear();
        List<dynamic> data = result['data'];
        print('nnnnnnnnnnnn${data.length}');

        try{
          data.forEach((e){
            faqList.add(FaqModel.fromJson(e));
          });
        }catch(e){
          print(',,,,,,,,,,,,,${e}');
        }



      }
      loading.value = false;
    }).catchError((err){
      loading.value = false;

    });
  }

}
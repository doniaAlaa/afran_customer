import 'package:afran/constant/app_apis.dart';
import 'package:afran/constant/dio_client.dart';
import 'package:afran/home/models/product_model.dart';
import 'package:get/get.dart';

class FavoriteController extends GetxController{

  RxBool loading = false.obs;
  RxList<ProductModel> favoriteProducts = <ProductModel>[].obs;


  ////GET Favorite LIST///
  getFavorites() async{
    loading.value = true;
    await DioClient().getAPI(
      '${baseUrl}/favorites',

    ).then((result) async {
      if(result['status'] == true){
        favoriteProducts.clear();
        List<dynamic> data = result['data'];
        print('nnnnnnnnnnnn${data.length}');

        try{
          data.forEach((e){
            favoriteProducts.add(ProductModel.fromJson(e));
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
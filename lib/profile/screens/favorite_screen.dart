import 'package:afran/constant/app_colors.dart';
import 'package:afran/constant/app_text_style.dart';
import 'package:afran/constant/main_app_bar.dart';
import 'package:afran/profile/controllers/favorite_controller.dart';
import 'package:afran/profile/widgets/empty_favorit.dart';
import 'package:afran/profile/widgets/favorit_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoriteScreen extends StatelessWidget {
   FavoriteScreen({super.key});

  FavoriteController favoriteController = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {
    favoriteController.getFavorites();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: MainAppBar(title: 'المفضلة'),
        body:Obx((){
          return favoriteController.loading.value?
          Center(
            child: Container(
                height: 30,width: 30,
                child: CircularProgressIndicator(color: darkPurple,strokeWidth: 1.5,)),
          ):

          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                favoriteController.favoriteProducts.isEmpty?
                EmptyFavorit():
                 FavoritData(favoriteProducts: favoriteController.favoriteProducts,),
              ],
            ),
          );
        }),

      ),
    );
  }
}


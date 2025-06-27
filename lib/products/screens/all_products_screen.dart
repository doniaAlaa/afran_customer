import 'package:afran/constant/app_colors.dart';
import 'package:afran/constant/app_images.dart';
import 'package:afran/constant/app_text_style.dart';
import 'package:afran/constant/main_app_button.dart';
import 'package:afran/home/controllers/home_controller.dart';
import 'package:afran/home/models/product_model.dart';

import 'package:afran/constant/main_app_bar.dart';
import 'package:afran/home/screens/home_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AllProductsScreen extends StatefulWidget {
  AllProductsScreen({super.key,});

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {

  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // executes after build
      homeController.selectedProductTypeIndex.value = 0;
      homeController.getProducts();

    });
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        // appBar: AppBar(
        //     foregroundColor: Colors.white,
        //     backgroundColor: Colors.white,
        //     surfaceTintColor: Colors.white,
        //     // shadowColor: Colors.white,
        //     leading: Icon(Icons.arrow_back_ios,size: 20,color: darkPurple2,),
        //     titleSpacing: 0,
        //     title:  Text('المنتجات',style: text70018.copyWith(color: darkPurple2),)),
        appBar: MainAppBar(title: 'المنتجات'),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 30),
            child: Column(
              children: [
                // Products List
                Obx((){
                  if (homeController.loading.value) return Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Container(
                          height: 30,width: 30,
                          child: CircularProgressIndicator(color: darkPurple,strokeWidth: 1.5,)),
                    ),
                  ) ;
                  return
                    homeController.products.isEmpty?
                    Center(child: Padding(
                      padding: const EdgeInsets.only(top: 24.0,bottom: 24),
                      child: Text('لا توجد منتجات',style: text70020,),
                    ))
                        :
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: homeController.products.length,
                        itemBuilder: (context,index){
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: HomeScreen.productItem(homeController.products[index],context,homeController,index),
                          );

                        },
                      ),
                    )
                  ;
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}


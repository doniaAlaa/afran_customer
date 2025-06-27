import 'package:afran/constant/app_colors.dart';
import 'package:afran/constant/app_images.dart';
import 'package:afran/constant/app_text_style.dart';
import 'package:afran/constant/main_app_bar.dart';
import 'package:afran/entity/product_category_model.dart';
import 'package:afran/home/controllers/home_controller.dart';
import 'package:afran/home/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProductCategoryScreen extends StatelessWidget {
  final ProductCategoryModel categorie;
  final HomeController homeController;
  const ProductCategoryScreen({super.key,required this.categorie, required this.homeController});

  @override
  Widget build(BuildContext context) {
    homeController.getProductsByCategory(categorie.id??-1);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: MainAppBar(title: categorie.name??''),
        body: Obx((){
          return homeController.productCategoriesLoading.value ?  Center(
            child: Container(
                height: 30,width: 30,
                child: CircularProgressIndicator(color: darkPurple,strokeWidth: 1.5,)),
          ): homeController.productsByCategory.isEmpty?Center(child: Text('لا توجد منتجات',style: text70020,)) :Padding(

            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 1.0,
                    mainAxisExtent: 300
                ),
                itemCount: homeController.productsByCategory.length,
                itemBuilder: (context,index){
                  List<ProductModel> items =  homeController.productsByCategory;
                  return Stack(
                    children: [
                      Container(
                        // margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: grey,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(

                                'assets/images/1.png', width: 140, height: 140, fit: BoxFit.cover),

                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(items[index].name??'', style: text50016),
                                      Row(
                                        children: [
                                          SvgPicture.asset(star),
                                          Text('٤', style: text50016),

                                        ],
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text('اسم الأسرة المنتجة', style: text50012.copyWith(color: darkPurple)),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      SvgPicture.asset(pin),
                                      SizedBox(width: 4,),
                                      Text(items[index].distance??'', style: text50012),
                                    ],
                                  ),

                                  // if (price.isNotEmpty)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('${items[index].price}'+'ر.س', style: text70016.copyWith(color: darkPurple2)),
                                      SizedBox(width: 8,),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(100),
                                        child: Container(
                                            height: 40,width: 40,
                                            decoration: BoxDecoration(
                                                color: darkPurple,
                                                shape: BoxShape.circle
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: SvgPicture.asset(whiteCart),
                                            )
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    color: purple,
                                    borderRadius: BorderRadius.circular(8)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4),
                                  child: Text('خصم ٢٠٪'),
                                )),
                            Container(
                              height: 32,width: 32,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle
                              ),
                              child: Icon(Icons.favorite,color: darkPurple,),
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                }),
          );
        })
      ),
    );
  }
}

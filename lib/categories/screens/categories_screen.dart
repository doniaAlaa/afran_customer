import 'package:afran/categories/product_category_screen.dart';
import 'package:afran/constant/app_colors.dart';
import 'package:afran/constant/app_text_style.dart';
import 'package:afran/constant/main_app_bar.dart';
import 'package:afran/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesScreen extends StatefulWidget {
   CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
   HomeController homeController = Get.put(HomeController());


   @override
   void initState() {
     super.initState();
     WidgetsBinding.instance.addPostFrameCallback((_) async{
       homeController.getProductCategories();

       setState(() {

       });
     });

   }

   @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: MainAppBar(title: 'التصنيفات'),
        body: Scaffold(
          backgroundColor: Colors.white,
          body:Obx((){
            return homeController.categoriesLoading.value? Center(
              child: Container(
                  height: 30,width: 30,
                  child: CircularProgressIndicator(color: darkPurple,strokeWidth: 1.5,)),
            ):  Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 30),
              child: GridView.builder(
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // Number of columns
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 1.0,
                      mainAxisExtent: 130
                  ),
                  itemCount: homeController.categories.length,
                  itemBuilder: (context,index){
                    return InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  ProductCategoryScreen(categorie: homeController.categories[index], homeController: homeController)),
                        );
                      },
                      child: Column(
                        children: [
                          Container(
                            height: 100,width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: grey
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Image.asset('assets/images/food.png'),
                            ),

                          ),
                          SizedBox(height: 8,),
                          Text(homeController.categories[index].name??'',style: text50014,)
                        ],
                      ),
                    );
                  }),
            );
          })
        ),
      ),
    );
  }
}


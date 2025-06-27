import 'package:afran/categories/product_category_screen.dart';
import 'package:afran/categories/screens/categories_screen.dart';
import 'package:afran/constant/app_colors.dart';
import 'package:afran/constant/app_images.dart';
import 'package:afran/constant/app_strings.dart';
import 'package:afran/constant/app_text_style.dart';
import 'package:afran/constant/secure_storage.dart';
import 'package:afran/entity/product_category_model.dart';
import 'package:afran/entity/user_model.dart';
import 'package:afran/home/controllers/home_controller.dart';
import 'package:afran/home/models/product_model.dart';
import 'package:afran/notifications/screens/notification_screen.dart';
import 'package:afran/notifications/widgets/top_sliding_notification.dart';
import 'package:afran/products/controllers/product_details_controller.dart';
import 'package:afran/products/screens/family_products_screen.dart';
import 'package:afran/products/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  final UserModel? userModel;
  const HomeScreen({super.key,this.userModel});

  @override
  State<HomeScreen> createState() => _HomeScreenState();


  static Widget categoryItem(ProductCategoryModel categorie,BuildContext context,HomeController homeController) {
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  ProductCategoryScreen(categorie: categorie, homeController: homeController,)),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        width: 90,
        child: Column(
          children: [

            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Container(
                color: Color(0xFFF6F6F6),
                height: 82,width: 82,
                child:  Image.asset('assets/images/food.png'),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              categorie.name??'',
              style: const TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // Product item widget
  static Widget productItem(ProductModel product,BuildContext context,HomeController homeController,int index) {
    return InkWell(
      onTap: (){
        if(homeController.selectedProductTypeIndex.value == 1){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  FamilyProductsScreen(family: product,homeController: homeController,)),
          );
        }else{
          Get.delete<ProductDetailsController>();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  ProductDetailsScreen(product: product,)),
          );
        }




      },
      child: Stack(
        children: [
          Container(
            // margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: grey,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('assets/images/1.png', width: 140, height: 140, fit: BoxFit.cover),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width*0.3,
                              child: Text(
                                homeController.selectedProductTypeIndex.value == 1?product.owner??'':
                                product.name??''
                                , maxLines: 1,style: text50016,overflow: TextOverflow.ellipsis,)),
                          Row(
                            children: [
                              SvgPicture.asset(star),
                              SizedBox(width: 4,),
                              Text('${product.rate??0}'.toString(),style: text50014,)
                            ],
                          )

                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                          homeController.selectedProductTypeIndex.value == 1 ||
                          homeController.selectedProductTypeIndex.value == 2

                          ?
                          product.category_name??''
                              :
                          product.description??''
                          , style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500,color: darkPurple)),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          SvgPicture.asset(pin),
                          SizedBox(width: 8,),
                          Text(product.distance??'', style: text50012),
                        ],
                      ),
                      const SizedBox(height: 16),
                      homeController.selectedProductTypeIndex.value == 1 ?
                      Container(
                        width: 80,
                        decoration: BoxDecoration(
                          color: purple,
                          borderRadius: BorderRadius.circular(12)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 6),
                          child: Row(
                            children: [
                              SvgPicture.asset(shipping),
                              SizedBox(width: 4,),
                              Text('مجاني',style: text50012.copyWith(color: darkPurple2),),

                            ],
                          ),
                        ),
                      ):

                      product.price != null && product.price!.isNotEmpty?
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text('${product.price}'+'ر.س', style: text70018.copyWith(color: darkPurple2)),
                                SizedBox(width: 8,),
                                Text(
                                    '40', style:
                                    TextStyle(fontSize: 14, fontWeight: FontWeight.w500,color: Color(0xFF666666),
                                        decoration:TextDecoration.lineThrough )
                                ),
                              ],
                            ),
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
                        ):Container(),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Row(
            children: [
              homeController.selectedProductTypeIndex.value == 4 ?
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                    decoration: BoxDecoration(
                        color: purple,
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4),
                      child: Text('خصم ٢٠٪',style: text50012.copyWith(color: darkPurple2),),
                    )),
              ):
              homeController.selectedProductTypeIndex.value == 1 ||
              homeController.selectedProductTypeIndex.value == 2

              ?
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                    decoration: BoxDecoration(
                        color:product.is_active == true? Color(0xFF55B938):grey3,
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4),
                      child: Text(product.is_active == true ?'متاح الان':'غير متاح',style: text50012.copyWith(color: Colors.white),),
                    )),
              ):Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                    decoration: BoxDecoration(
                        color: purple,
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4),
                      child: Text(product.category??'',style: text50012.copyWith(color: darkPurple2),),
                    )),
              )
              ,

              homeController.addToFavoriteLoading.value? Container():
              InkWell(
                onTap: (){
                  homeController.addToFavorite(context, product.id??-1,index);

                },
                child: Container(
                  height: 32,width: 32,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(product.is_favorite != null && product.is_favorite == true ? purpleFav:favorite),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HomeScreenState extends State<HomeScreen> {
  List productFilters = [
    'الكل',
    'الأسر المنتجة المميزة',
    'الأقرب إليك',
    'الأكثر طلباً',
    'العروض الحالية',
    'جديدنا',
  ];

  HomeController homeController = Get.put(HomeController());
  // @override
  // void initState() {
  //   super.initState();
  //   homeController.getProducts();
  //   homeController.getProductCategories();
  // }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Bar
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Container(
                              height: 48,width: 48,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle
                              ),
                              child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRSZsINAeXhg_aONZrbZrMTZEjopaRJ1xmlVA&s',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 16,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:  [
                              Text(
                                widget.userModel?.name??'',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [

                                  SvgPicture.asset('assets/images/pin.svg'),
                                  SizedBox(width: 4,),

                                  Text(
                                    'الرياض شارع النماص عمارة النماص',
                                    style: TextStyle(fontSize: 12, color: Colors.black54),
                                  ),
                                ],
                              ),
                            ],
                          ),

                        ],
                      ),
                      InkWell(
                        onTap: () async{
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  NotificationScreen()),
                          );
                          homeController.notificationNotReaded.value = false;
                          final secureStorage = SecureStorageService();

                          await secureStorage.write(notReadedNotification,'false');


                        },
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [

                            Container(
                              width: 50,
                              // color: Colors.green,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Container(
                                    height: 38,width: 38,
                                    decoration: BoxDecoration(
                                        color: Color(0xFFEAD4EC),
                                        shape: BoxShape.circle
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SvgPicture.asset('assets/images/notification.svg'),
                                    )
                                ),
                              ),
                            ),
                            Obx((){
                              return homeController.notificationNotReaded.value?  Padding(
                                padding: const EdgeInsets.only(left: 0.0),
                                child: Container(
                                  height: 14,width: 14,
                                  decoration: BoxDecoration(
                                      color:  Colors.green,
                                      shape: BoxShape.circle
                                  ),
                                  // child: Center(child: Text('1',style: TextStyle(color: Colors.white),)),
                                ),
                              ):Container();
                            })
                          ],
                        ),
                      )

                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Search Bar
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(

                    decoration: InputDecoration(
                      filled: true,
                      fillColor: grey,
                      hintText: 'ابحث عن منتجات أو أسر منتجة...',
                      hintStyle:TextStyle(
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w500,
                        fontSize: 14
                      ),
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: grey, width: 2),
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Banner
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(16),
                  // height: 160,
                  decoration: BoxDecoration(
                    color: Colors.purple.shade100,
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      // stops: [0.8, 1.9,],
                      colors: [
                        Color(0xFF9B4D9C),
                        Color(0xFF722B79),

                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Image.asset('assets/images/burger.png', width: 110, height: 110, fit: BoxFit.cover),
                      SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:  [
                            Row(
                              children: [
                                SvgPicture.asset(star),
                                SizedBox(width: 6,),
                                Text(
                                  '٤.٥',
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700,color: grey),
                                ),
                              ],
                            ),
                            Text(
                              'لا تفوتوا العروض! ',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700,color: grey),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'تنتهي خلال٠٢:١٥:٣٢',
                              style:text50012.copyWith(color: grey),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'توصيل خلال ٣ ساعات للطلبات قبل ٤ عصرًا',
                              style:text40010.copyWith(color: grey2),
                            ),
                            SizedBox(height: 8),

                            Container(
                              // height: 22,
                              decoration:BoxDecoration(
                                color: grey,
                                borderRadius: BorderRadius.circular(20)
                              ),
                              child:  Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8),
                                child: Text(
                                  'اطلب الآن',
                                  style:text40010.copyWith(color: darkPurple),
                                ),
                              ),
                            )

                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Categories
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  [
                      Text(
                        'التصنيفات',
                        style: text70018.copyWith(color: darkPurple2),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  CategoriesScreen()),
                          );
                        },
                        child: Text(
                          'عرض الكل',
                          style: TextStyle(color: Colors.purple),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),
                Obx((){
                  if (homeController.categoriesLoading.value) return Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Container(
                          height: 30,width: 30,
                          child: CircularProgressIndicator(color: darkPurple,strokeWidth: 1.5,)),
                    ),
                  )  ;
                  return
                  SizedBox(
                    height: 130,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: homeController.categories.length,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemBuilder: (context,index){
                        return   HomeScreen.categoryItem(homeController.categories[index],context,homeController);
                      },
                    ),
                  );
                }),


                const SizedBox(height: 24),

                // Title
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'استمتع بكل المنتجات',
                    textAlign: TextAlign.start,
                    style: text70018.copyWith(color: darkPurple2),
                  ),
                ),
                const SizedBox(height: 16),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child:

                  Container(
                    height: 40,
                    child: ListView.builder(
                        itemCount: productFilters.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context,index){
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: InkWell(
                          onTap: () {
                            homeController.selectedProductTypeIndex.value = index;
                            if(index == 0){
                              homeController.getProducts();
                            }else if(index == 1){
                              homeController.getProvidersSortedByRate();
                            }else if(index == 2){
                              homeController.getNearestProvider();
                            }
                            else if(index == 3){
                              homeController.getProductsOrderedByMostOrdered();
                            }
                            else if(index == 4){
                              homeController.getProductsWithOffers();
                            }else if(index == 5){
                              homeController.getProductsByDescId();
                            }
                          },
                          child:  Obx((){
                            return Container(
                                decoration: BoxDecoration(
                                    color:homeController.selectedProductTypeIndex.value == index ? darkPurple: grey,
                                    borderRadius: BorderRadius.circular(8)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
                                  child: Text(productFilters[index],style: text70014.copyWith(color: homeController.selectedProductTypeIndex.value == index? Colors.white:Colors.black),),
                                ));
                          })

                        ),
                      );
                    }),
                  )

                ),

                const SizedBox(height: 16),

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
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
import 'package:afran/constant/app_colors.dart';
import 'package:afran/constant/app_images.dart';
import 'package:afran/constant/app_text_style.dart';
import 'package:afran/constant/main_app_bar.dart';
import 'package:afran/home/controllers/home_controller.dart';
import 'package:afran/home/models/product_model.dart';
import 'package:afran/home/screens/home_screen.dart';
import 'package:afran/products/controllers/product_details_controller.dart';
import 'package:afran/products/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class FamilyProductsScreen extends StatefulWidget {
  final ProductModel family;
  final HomeController homeController;
  const FamilyProductsScreen({super.key,required this.family,required this.homeController});

  @override
  State<FamilyProductsScreen> createState() => _FamilyProductsScreenState();
}

class _FamilyProductsScreenState extends State<FamilyProductsScreen> {


  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      widget.homeController.getProductsByProviderId(widget.family.id??-1);
      setState(() {

      });
    });


  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: MainAppBar(title: widget.family.owner??'',
        actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
              decoration: BoxDecoration(
              color:widget.family.is_active == true? Color(0xFF55B938):grey3,
                        borderRadius: BorderRadius.circular(8)
                    ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4),
                        child: Text(widget.family.is_active == true ?'متاح الان':'غير متاح',style: text50012.copyWith(color: Colors.white),),
                      )),
            ),

        ],
        ),
        body: Column(
          children: [
            Container(
              height: 230,
              child: Image.network(
                  fit: BoxFit.cover,
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRwViDCA89-gGtEOTcCAj2gUQSp8vbpY4nTWg&s'),
            ),
            Obx((){
              return widget.homeController.providerProductsLoading.value?Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Container(
                      height: 30,width: 30,
                      child: CircularProgressIndicator(color: darkPurple,strokeWidth: 1.5,)),
                ),
              ) : Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 24),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.homeController.providerProducts.length,
                    itemBuilder: (context,index){
                      ProductModel productItem = widget.homeController.providerProducts[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child:
                        // HomeScreen.productItem(widget.homeController.providerProducts[index],context,widget.homeController,index),
                          InkWell(
                            onTap: (){
                              Get.delete<ProductDetailsController>();
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>  ProductDetailsScreen(product: widget.homeController.providerProducts[index],)),
                              );



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
                                                      productItem.name??''
                                                      , maxLines: 1,style: text50016,overflow: TextOverflow.ellipsis,)),
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(star),
                                                    SizedBox(width: 4,),
                                                    Text('${productItem.rate??0}'.toString(),style: text50014,)
                                                  ],
                                                )

                                              ],
                                            ),
                                            const SizedBox(height: 8),

                                            const SizedBox(height: 8),
                                            Row(
                                              children: [
                                                SvgPicture.asset(pin),
                                                SizedBox(width: 8,),
                                                Text(productItem.distance??'', style: text50012),
                                              ],
                                            ),
                                            const SizedBox(height: 16),

                                            productItem.price != null && productItem.price!.isNotEmpty?
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text('${productItem.price}'+'ر.س', style: text70018.copyWith(color: darkPurple2)),
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

                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Container(
                                          decoration: BoxDecoration(
                                              color:productItem.is_active == true? Color(0xFF55B938):grey3,
                                              borderRadius: BorderRadius.circular(8)
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4),
                                            child: Text(productItem.is_active == true ?'متاح الان':'غير متاح',style: text50012.copyWith(color: Colors.white),),
                                          )),
                                    ),

                                    widget.homeController.addToFavoriteLoading.value? Container():
                                    InkWell(
                                      onTap: (){
                                        widget.homeController.addToFavorite(context, productItem.id??-1,index);

                                      },
                                      child: Container(
                                        height: 32,width: 32,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SvgPicture.asset(productItem.is_favorite != null && productItem.is_favorite == true ? purpleFav:favorite),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                      );
                
                    },
                  ),
                ),
              );
            })

          ],
        ),
      ),
    );

  }
}

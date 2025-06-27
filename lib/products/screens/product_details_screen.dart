import 'package:afran/constant/app_colors.dart';
import 'package:afran/constant/app_images.dart';
import 'package:afran/constant/app_text_field.dart';
import 'package:afran/constant/app_text_style.dart';
import 'package:afran/constant/main_app_button.dart';
import 'package:afran/home/models/product_model.dart';
import 'package:afran/products/controllers/product_details_controller.dart';
import 'package:afran/products/widgets/addons_bottom_sheet.dart';
import 'package:afran/products/widgets/choose_date_widget.dart';
import 'package:afran/products/widgets/feedbacks_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductModel product;
  ProductDetailsScreen({required this.product});
  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {

  final PageController _controller = PageController();
  final List<String> _images = [
    'https://images.unsplash.com/photo-1504674900247-0877df9cc836?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Zm9vZHxlbnwwfHwwfHx8MA%3D%3D',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRwViDCA89-gGtEOTcCAj2gUQSp8vbpY4nTWg&s'

  ];

  ProductDetailsController productDetailsController = Get.put(ProductDetailsController());


  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async{
      await productDetailsController.getProductDetails(widget.product.id??-1);
      productDetailsController.getItemFeedbacks(widget.product.id??-1);

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
        body: SafeArea(
          child: Obx((){

            return productDetailsController.loading.value?
            Center(
              child:  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        height: 30,width: 30,
                        child: CircularProgressIndicator(color: darkPurple,strokeWidth: 1.5,)),
                  ],
                ),

            )
                :SingleChildScrollView(
                  child: Column(
                          children: [
                  Container(
                    height: 292,
                    color: grey,
                    child:Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Row(
                                children: [

                                  InkWell(
                                      onTap: (){
                                        Navigator.pop(context);
                                      },
                                      child: Icon(Icons.arrow_back_ios, color: darkPurple)),
                                  SizedBox(width: 8,),
                                  Text(
                                    productDetailsController.productsDetails?.name??'',
                                    style: text70018.copyWith(color: darkPurple2),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              Container(
                                  height: 30,width: 30,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle
                                  ),
                                  child: Icon(Icons.favorite_border, color: darkPurple)),

                            ],
                          ),
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 200, // height of the image viewer
                              child: PageView.builder(
                                controller: _controller,
                                itemCount: _images.length,
                                itemBuilder: (_, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        _images[index].toString(),
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 12),
                            SmoothPageIndicator(
                              controller: _controller,
                              count: _images.length,
                              effect: WormEffect(
                                activeDotColor: darkPurple,
                                dotHeight: 10,
                                dotWidth: 10,
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                    ,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                          productDetailsController.productsDetails?.name??'',
                          style:text70016,
                        ),
                        SizedBox(height: 8,),
                        Text(
                          productDetailsController.productsDetails?.category??'',
                          style:text50014.copyWith(color: darkPurple),
                        ),
                        SizedBox(height: 8,),
                        Text(
                            productDetailsController.productsDetails?.description??'',
                            style: text50014.copyWith(color: grey3)),
                        SizedBox(height: 8,),
                        Text(productDetailsController.productsDetails?.is_active == true? 'المنتج متوفر حالياً':'المنتج غير متوفر حاليا',style: text50014.copyWith(color:
                        productDetailsController.productsDetails?.is_active == true?
                        Color(0xFF55B938):Colors.red),),
                        SizedBox(height: 16,),
                        Row(
                          children: [
                            Container(
                              width: 60,
                              child:  Row(
                                children: [
                                  SvgPicture.asset(star),
                                  SizedBox(width: 4,),
                                  Text(productDetailsController.productsDetails?.rate.toString()??'',style: text50014,)
                                ],
                              ),
                            ),
                            SizedBox(width: 8,),

                            Row(
                              children: [
                                SvgPicture.asset(time),
                                SizedBox(width: 4,),
                                Text('${productDetailsController.productsDetails?.duration??''}${productDetailsController.productsDetails?.duration_type??''}',style: text50014,)
                              ],
                            ),
                            SizedBox(width: 8,),
                            Row(
                              children: [
                                SvgPicture.asset(pin),
                                SizedBox(width: 4,),
                                Text(productDetailsController.productsDetails?.distance??'',style: text50014,)
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 24,),

                        // Size Options
                        Row(
                          children: [
                            Text('الحجم:',style: text50014.copyWith(color: darkGrey),),
                            SizedBox(width: 8,),
                            Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width*0.7,

                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: productDetailsController.productsDetails?.sizes?.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context,index){
                                    List<SizesAndAddons>? sizes =   productDetailsController.productsDetails?.sizes;
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Obx((){
                                        return InkWell(
                                          onTap: (){
                                            productDetailsController.sizeId.value = productDetailsController.productsDetails?.sizes?[index].id??-1;
                                            print(productDetailsController.sizeId.value);
                                          },
                                          child: SizedBox(
                                            child: DecoratedBox(decoration: BoxDecoration(
                                                color:productDetailsController.sizeId.value == productDetailsController.productsDetails?.sizes?[index].id ?darkPurple:grey,
                                                borderRadius: BorderRadius.circular(8)
                                            ),child:  Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 9),
                                              child:

                                              Text(
                                                sizes?[index].name == 'S' ? 'صغير':
                                                sizes?[index].name == 'M' ? 'متوسط':
                                                sizes?[index].name == 'L' ? 'كبير':
                                                sizes?[index].name == 'XL' ? 'كبير جدا':
                                                sizes?[index].name == 'Family' ? 'عائلي':
                                                'عادى'
                                                ,

                                                style: text50014.copyWith(color: productDetailsController.sizeId.value == productDetailsController.productsDetails?.sizes?[index].id ? Colors.white: Colors.black),),
                                            ),),
                                          ),
                                        );
                                      })
                                    );
                                  }),
                            )

                          ],
                        ),
                        SizedBox(height: 24),

                        // Customization section
                        Text("خصم طلبك حسب رغبتك",style: text70016.copyWith(color: darkGrey),),
                        SizedBox(height: 16,),
                        Row(
                          children: [
                            Expanded(
                              child: AppTextField(
                                controller:productDetailsController.addonController,
                                readOnly: true,
                                  onTap: (){
                                    AddonsBottomSheet().chooseAddons(context,productDetailsController.productsDetails?.addons,productDetailsController);
                                  },
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Icon(Icons.keyboard_arrow_down),
                                  ),
                              
                                  hintText: 'اختر المكون'),
                            ),
                            SizedBox(width: 8,),
                            InkWell(
                              onTap: (){
                                if(productDetailsController.addonController.text.isNotEmpty){
                                  if(productDetailsController.selectedAddons.contains(productDetailsController.selectedAddonItem!.value)){
                                    const snackBar = SnackBar(

                                        backgroundColor: Color(0xFFDC9538),
                                        content: Text('هذا المكون تمت إضافته مسبقا',textAlign: TextAlign.start,));
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  }else{
                                    productDetailsController.selectedAddonsIds.add(productDetailsController.selectedAddonItem!.value.id??-1);

                                    productDetailsController.selectedAddons.add(productDetailsController.selectedAddonItem!.value);
                                    productDetailsController.addonController.clear();

                                  }

                                }

                              },
                              child: SizedBox(
                                height: 56,
                                width: 70,
                                child: DecoratedBox(decoration: BoxDecoration(
                                    color: darkPurple,
                                    borderRadius: BorderRadius.circular(8)
                                ),child:  Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 7),
                                  child: Center(
                                    child: Text(
                                      'أضف',
                                      style: text50014.copyWith(color: Colors.white),),
                                  ),
                                ),),
                              ),
                            ),
                          ],
                        ),
                        productDetailsController.selectedAddons.isEmpty? Container():
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount:productDetailsController.selectedAddons.length ,
                              itemBuilder: (context,index){
                            return SizedBox(
                              child: DecoratedBox(decoration: BoxDecoration(
                                  color: grey,
                                  borderRadius: BorderRadius.circular(20)
                              ),child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(productDetailsController.selectedAddons[index].name??'',style: text50016.copyWith(color: darkGrey),),
                                    Row(
                                      children: [
                                        Text('${productDetailsController.selectedAddons[index].price}'+"ر.س",style: text70014.copyWith(color: darkPurple2),),
                                        // SizedBox(width: 8,),
                                        // InkWell(
                                        //   onTap: (){
                                        //
                                        //   },
                                        //   child: SizedBox(
                                        //     child: DecoratedBox(decoration: BoxDecoration(
                                        //         color: darkPurple,
                                        //         borderRadius: BorderRadius.circular(8)
                                        //     ),child:  Padding(
                                        //       padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 7),
                                        //       child: Text(
                                        //         'أضف',
                                        //         style: text50014.copyWith(color: Colors.white),),
                                        //     ),),
                                        //   ),
                                        // ),
                                        SizedBox(width: 10,),
                                        InkWell(
                                            onTap: (){
                                              productDetailsController.selectedAddons.removeAt(index);
                                            },
                                            child: SvgPicture.asset(delete))
                                      ],
                                    ),
                                  ],
                                ),
                              ),),
                            );
                          })
                        ),
                        SizedBox(height: 24,),
                        Text("ملاحظات",style: text70016.copyWith(color: darkGrey),),
                        SizedBox(height: 16),


                        // Notes
                        TextFormField(
                          maxLines: 3,
                          controller: productDetailsController.notesController,
                          decoration: InputDecoration(
                            hintText: 'اكتب ملحوظة',
                            hintStyle: text50014.copyWith(color: grey3),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: grey2), // Normal border
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: grey2, width: 2), // On focus
                              borderRadius: BorderRadius.circular(12),
                            ),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          ),

                        ),
                        // SizedBox(height: 24),
                        //
                        // // Delivery Time
                        // ChooseDateWidget(productDetailsController: productDetailsController,),

                        Obx((){
                          return
                          productDetailsController.feedbackLoading.value? Padding(
                            padding: const EdgeInsets.only(top: 24.0),
                            child: Center(
                                child: Container(
                                height: 50,width: 50,
                                child: Padding(
                                padding: const EdgeInsets.all(4.0),
                            child: CircularProgressIndicator(color: darkPurple,strokeWidth: 1.8,),
                            ))),
                          ):
                          productDetailsController.feedbacksListForItem.isEmpty?
                          Center(child: Padding(
                            padding: const EdgeInsets.only(top: 24.0,bottom: 24),
                            child: Text('لا يوجد تقييمات حتى الآن',style: text50014,),
                          ))
                              :
                          FeedbacksWidget(feedbacksList: productDetailsController.feedbacksListForItem,);
                        }),
                        SizedBox(height: 16),
                        // TextFormField(
                        //   controller: productDetailsController.feedBackController,
                        //   decoration: InputDecoration(
                        //     hintText: 'عبر عن رأيك',
                        //     suffixIcon: InkWell(
                        //       onTap: (){
                        //         if(productDetailsController.feedBackController.text.trim().isEmpty){
                        //           const snackBar = SnackBar(
                        //
                        //               backgroundColor: Colors.red,
                        //               content: Text('قم بكتابة رأيك أولا',textAlign: TextAlign.start,));
                        //           ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        //         }else{
                        //           productDetailsController.addFeedBack(context, widget.product.id??-1);
                        //
                        //         }
                        //       },
                        //       child: Column(
                        //         children: [
                        //           Container(
                        //               height: 30,width: 30,
                        //               child: Image.asset(send)),
                        //         ],
                        //       ),
                        //     ),
                        //     hintStyle: text50014.copyWith(color: grey3),
                        //     enabledBorder: OutlineInputBorder(
                        //       borderSide: BorderSide(color: grey2), // Normal border
                        //       borderRadius: BorderRadius.circular(12),
                        //     ),
                        //     focusedBorder: OutlineInputBorder(
                        //       borderSide: BorderSide(color: grey2, width: 2), // On focus
                        //       borderRadius: BorderRadius.circular(12),
                        //     ),
                        //     border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        //   ),
                        //
                        // ),
                      ],
                    ),
                  ),
                  Container(
                    // height: 140,
                    decoration: BoxDecoration(
                        color: grey,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 24),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("٨ ر.س",style: text70020.copyWith(color: darkPurple2),),
                              Container(
                                decoration: BoxDecoration(
                                    color: purple,
                                    borderRadius: BorderRadius.circular(12)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 12),
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: (){
                                          productDetailsController.quantity ++;
                                        },
                                        child: Container(
                                          height: 22,width: 22,
                                          decoration: BoxDecoration(
                                              color: darkPurple,
                                              shape: BoxShape.circle
                                          ),
                                          child: Icon(Icons.add,color: Colors.white,size: 16,),
                                        ),
                                      ),
                                      Obx((){
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                          child: Text(productDetailsController.quantity.value.toString(),style: text70014.copyWith(color: darkPurple),),
                                        );
                                      }),

                                      InkWell(
                                        onTap: (){
                                          if(productDetailsController.quantity != 1){
                                            productDetailsController.quantity --;
                                          }
                                        },
                                        child: Container(
                                          height: 22,width: 22,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle
                                          ),
                                          child: Icon(Icons.remove,color: darkPurple,size: 16,),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )

                            ],
                          ),
                          SizedBox(height: 16,),
                          Obx((){
                             return productDetailsController.buttonLoading.value ?
                            Center(
                            child: Container(
                                height: 30,width: 30,
                                child: CircularProgressIndicator(color: darkPurple,strokeWidth: 1.5,)),
                            ):MainAppButton(
                                icon: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: SvgPicture.asset('assets/images/white_cart.svg'),
                                ),
                                onPressed: (){
                                  if(productDetailsController.sizeId.value ==-1){
                                    const snackBar = SnackBar(

                                        backgroundColor: Colors.red,
                                        content: Text('قم بإختيار الحجم أولا',textAlign: TextAlign.end,));
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  }else{
                                    productDetailsController.addToCart(context,widget.product.id??-1);

                                  }

                                }, title: 'أضف إلى السلة');
                          }),

                        ],
                      ),
                    ),
                  ),
                                  ],
                                ),
                );

          }),
        ),

      ),
    );
  }
}

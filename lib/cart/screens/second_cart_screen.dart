import 'package:afran/cart/controllers/cart_controller.dart';
import 'package:afran/constant/app_colors.dart';
import 'package:afran/constant/app_text_field.dart';
import 'package:afran/constant/app_text_style.dart';
import 'package:afran/constant/main_app_button.dart';
import 'package:afran/products/widgets/choose_date_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SecondCartScreen extends StatelessWidget {
  final Function()? onPressed;
  final CartController cartController;

  const SecondCartScreen({super.key, required this.onPressed, required this.cartController});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("اختيار طريقة الاستلام",style: text70016,),
                  SizedBox(height: 16,),
                  Obx((){
                    return  AppTextField(
                      readOnly: true,
                      controller: cartController.deliveryWayController.value,
                      onTap: (){
                        cartController.tapOnDeliveryWay();
                      },
                      hintText: 'اختيار طريقة الاستلام',suffixIcon: Icon(
                        cartController.deliveryWayTap.value?Icons.keyboard_arrow_up_outlined:
                        Icons.keyboard_arrow_down_sharp),);
                  }),

                  SizedBox(height: 8,),
                  Obx((){
                    return cartController.deliveryWayTap.value? Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: grey2,width: 1)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                                onTap:(){
                                  cartController.deliveryWayController.value.text = 'توصيل';
                                  cartController.deliveryWay.value = 'توصيل';
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                      // color:cartController.deliveryWayController.value.text == 'توصيل'? darkPurple:null,
                                      color:cartController.deliveryWay.value == 'توصيل'? darkPurple:null,
                                      borderRadius: BorderRadius.circular(6)
                                    ),
                                    width: MediaQuery.of(context).size.width,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 16),
                                      child: Text("توصيل",style: text50014.copyWith(
                                        color:cartController.deliveryWay.value == "توصيل"? Colors.white:null,
                                      ),),
                                    ))),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6.0),
                              child: Divider(
                                color: grey2,
                              ),
                            ),
                            InkWell(
                                onTap: (){
                                  cartController.deliveryWayController.value.text = "استلام يدوي";
                                  cartController.deliveryWay.value = "استلام يدوي";
                                },
                                child: Container(
                                    width:MediaQuery.of(context).size.width ,
                                    decoration: BoxDecoration(
                                        color:cartController.deliveryWay.value == "استلام يدوي"? darkPurple:null,
                                        borderRadius: BorderRadius.circular(6)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 16),
                                      child: Text("استلام يدوي",style: text50014.copyWith(
                                        color:cartController.deliveryWay.value == "استلام يدوي"? Colors.white:null,
                                      ),),
                                    ))),
                          ],
                        ),
                      ),
                    ):Container();
                  }),
                  SizedBox(height: 16,),
                  Text("توصيل إلى",style: text70016,),
                  SizedBox(height: 16,),
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 62,height: 62,
                        decoration: BoxDecoration(
                          color: purple,
                          borderRadius: BorderRadius.circular(12)
                        ),
                      ),
                      SizedBox(width: 12,),
                      Text("لتشملا عراش , ضايرلا , موطرخلا",style: text50014,),
              
                    ],
                  ),
                  // SizedBox(height: 16,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 16),
                    child: ChooseDateWidget(cartController: cartController,),
                  ),
                  SizedBox(height: 16,),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Obx((){
                      return cartController.addingOrderLoading.value?  Center(
                        child: Container(
                            height: 30,width: 30,
                            child: CircularProgressIndicator(color: darkPurple,strokeWidth: 1.5,)),
                      ) : MainAppButton(
                          onPressed:onPressed, title: 'أكمل الطلب');
                    })
                  )


              
                ],
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(bottom: 16.0),
          //   child: MainAppButton(
          //       onPressed: onPressed, title: 'أكمل الطلب'),
          // )

        ],
      ),
    );
  }

}

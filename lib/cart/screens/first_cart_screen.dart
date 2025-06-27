import 'package:afran/cart/controllers/cart_controller.dart';
import 'package:afran/cart/models/cart_model.dart';
import 'package:afran/cart/widgets/cart_product_item.dart';
import 'package:afran/constant/app_colors.dart';
import 'package:afran/constant/app_text_style.dart';
import 'package:afran/constant/main_app_button.dart';
import 'package:afran/products/widgets/choose_date_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirstCartScreen extends StatelessWidget {
  final Function()? onPressed;
  // final CartModel cartModel;
  final CartController cartController;
  const FirstCartScreen({super.key,required this.onPressed,
    // required this.cartModel,
    required this.cartController});

  @override
  Widget build(BuildContext context) {
    return Column(
      // shrinkWrap: true,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Obx((){
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: cartController.cartItems.value.items?.length,
                        itemBuilder: (context,index){
                          List<CartItemModel>? items =cartController.cartItems.value.items;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: CartProductItem(cartItemModel: items![index], imagePath: 'assets/images/1.png', cartController: cartController, index: index,),
                          );
                        });
                  }),

                  Divider(
                    thickness: 1.5,
                    color: grey,
                  ),
                  SizedBox(height: 16,)
                        
                ],
              ),
            ),
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
                    Text("عدد الطلبات",style: text60014,),
                    Text("${cartController.cartItems.value.total_qty} طلب ",style: text50014,),

                  ],
                ),
                SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("التوصيل",style: text60014,),
                    Text("٨ ر.س",style: text50014),

                  ],
                ),
                SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("الإجمالي",style: text60014,),
                    Text(' ${cartController.cartItems.value.total_price.toString()} '+'ر.س',style: text50014),

                  ],
                ),
                SizedBox(height: 24,),
                MainAppButton(

                    onPressed: onPressed, title: 'أكمل الطلب')
              ],
            ),
          ),
        ),


      ],
    );
  }

}

import 'package:afran/constant/app_colors.dart';
import 'package:afran/constant/app_text_style.dart';
import 'package:afran/constant/main_app_bar.dart';
import 'package:afran/constant/main_app_button.dart';
import 'package:afran/my_oreders/controllers/my_orders_controller.dart';
import 'package:afran/my_oreders/screens/view_order_item_components.dart';
import 'package:afran/my_oreders/widgets/no_orders.dart';
import 'package:afran/my_oreders/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyOrdersScreen extends StatelessWidget {
   MyOrdersScreen({super.key});

  MyOrderController myOrderController = Get.put(MyOrderController());

  @override
  Widget build(BuildContext context) {
    myOrderController.getMyOrders();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: MainAppBar(title: 'طلباتي'),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              SizedBox(height: 16,),
              Container(
                height: 80,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: MainAppButton(
                          title: 'الحالية',
                          onPressed: () {
          
                          },),
                      ),
                    ),
                    SizedBox(width: 8,),
                    Expanded(
                      child: Container(
          
                        child: MainAppButton(
                          title: 'السابقة',
                          onPressed: () {
          
                          },),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Obx((){
                  return myOrderController.loading.value?
                  Center(
                    child: Container(
                        height: 30,width: 30,
                        child: CircularProgressIndicator(color: darkPurple,strokeWidth: 1.5,)),
                  ): myOrderController.myOrdersList.isEmpty?NoOrders():Padding(
                    padding:  EdgeInsets.only(top: 16.0),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: myOrderController.myOrdersList.length,
                        itemBuilder: (context,index){

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 24.0),
                            child: OrderItem(order: myOrderController.myOrdersList[index],),
                          );
                        }),
                  );
                }),
              )
          
            ],
          ),
        ),
      ),
    );
  }


}

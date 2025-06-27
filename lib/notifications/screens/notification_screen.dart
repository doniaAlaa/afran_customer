import 'package:afran/constant/app_colors.dart';
import 'package:afran/constant/app_images.dart';
import 'package:afran/constant/app_text_style.dart';
import 'package:afran/constant/main_app_bar.dart';
import 'package:afran/constant/main_app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: MainAppBar(title: 'الإشعارات'),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                    itemCount: 4,
                    itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: OrderNotificationItem());
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OfferNotificationItem extends StatelessWidget {
  const OfferNotificationItem({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: grey,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('عرض جديد',style: text70016,),
            SizedBox(height: 16,),
            Container(
              height: 60,
              child: Row(
                children: [
                  Image.asset('assets/images/food.png'),
                  SizedBox(width: 12,),
                  Column(
                    // mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('لديك عرض جديد من الأسرة المنتجة مطعم السلطان ، يحتوي على خصم ٢٠٪',style: text70016.copyWith(fontSize: 12),),
                      SizedBox(height: 8,),
                      Text('منذ ٣٠ دقيقة',style: text40012.copyWith(color: grey3),)
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                Expanded(child: Container(child: MainAppButton(onPressed: (){}, title: 'عرض التفاصيل'))),
                SizedBox(width: 8,),
                Expanded(child: Container(child: MainAppButton(onPressed: (){}, title: 'الغاء'))),
              ],
            )

          ],
        ),
      ),
    );
  }
}

class OrderNotificationItem extends StatelessWidget {
  const OrderNotificationItem({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: grey,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 48,width: 48,
                  decoration: BoxDecoration(

                    color: Colors.white,
                    shape: BoxShape.circle,

                    // borderRadius: BorderRadius.circular(12)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset(noData),
                  ),
                ),
                SizedBox(width: 8,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('الطلب رقم '+'${22}',style: text60014,),
                    SizedBox(height: 4,),
                    Text('تم الطلب بتاريخ ' + 'orderDate' ,style: text50012.copyWith(color: grey3),),


                  ],
                ),

              ],
            ),

          ],
        ),
      ),
    );
  }
}
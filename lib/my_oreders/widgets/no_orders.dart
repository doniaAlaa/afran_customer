import 'package:afran/constant/app_colors.dart';
import 'package:afran/constant/app_images.dart';
import 'package:afran/constant/app_text_style.dart';
import 'package:afran/constant/main_app_button.dart';
import 'package:afran/products/screens/all_products_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoOrders extends StatelessWidget {
  const NoOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(noData),
            SizedBox(height: 32,),
            Text(
              'لا توجد طلبات حالية',
              style: text70020,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8,),
            Text(
              'لنبدأ رحلة طلب جديدة و نكتشف نكهات الأسر المنتجة',
              style: text50016.copyWith(color: grey3),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32,),
            MainAppButton(
              title: 'اطلب الان',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  AllProductsScreen()),
                );
              },),

          ],
        ),
      ),
    );
  }
}


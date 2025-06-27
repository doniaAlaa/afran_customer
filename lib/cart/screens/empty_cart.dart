import 'package:afran/constant/app_colors.dart';
import 'package:afran/constant/app_text_style.dart';
import 'package:afran/constant/main_app_button.dart';
import 'package:afran/products/screens/all_products_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/images/cart_image.svg'),
          SizedBox(height: 32,),
          Text("سلة التسوق الخاصة بك فارغة",style: text70020,),
          SizedBox(height: 8,),
          Text("لنبدأ رحلة التسوق معاً ونكتشف نكهات الأسر المنتجة",
            textAlign: TextAlign.center,
            style: text50016.copyWith(color: grey3),),
          SizedBox(height: 32,),
          MainAppButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  AllProductsScreen()),
                );

              }, title: 'تصفح المنتجات')


        ],
      ),
    );
  }

}

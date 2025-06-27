import 'package:afran/constant/app_colors.dart';
import 'package:afran/constant/app_images.dart';
import 'package:afran/constant/app_text_style.dart';
import 'package:afran/constant/main_app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyFavorit extends StatelessWidget {
  const EmptyFavorit({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(

        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.2,),
          SvgPicture.asset(favoriteImage),
          SizedBox(height: 32,),
          Text('المفضلة فارغة',style: text70020,),
          SizedBox(height: 8,),
          Text('اضغط ♡ على أي منتج لحفظه هنا للمستقبل',style: text50016.copyWith(color: grey3),),
          SizedBox(height: 32,),
          MainAppButton(onPressed: (){}, title: 'تصفح المنتجات')
        ],
      ),
    );
  }
}


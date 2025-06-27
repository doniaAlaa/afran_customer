import 'package:afran/constant/app_colors.dart';
import 'package:afran/constant/app_images.dart';
import 'package:afran/constant/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemComponentWidget extends StatelessWidget {
  final String imagePath;
  final String title;
  final String title1;
  final String price;
  const ItemComponentWidget({super.key,
    required this.imagePath,
    required this.title,
    required this.title1,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){

      },
      child: Container(
        // margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: grey,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(imagePath, width: 76, height: 76, fit: BoxFit.cover),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: text60014),
                  const SizedBox(height: 4),
                  Text(title1, style: text40010.copyWith(color: grey3)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text('السعر: ',style: text50012.copyWith(color: darkPurple),),
                      Text('١٦ ر.س',style: text50012,),
                    ],
                  ),
                  SizedBox(height: 8,),
                  Row(
                    children: [
                      Text('الكمية: ',style: text50012.copyWith(color: darkPurple),),
                      Text('١٦',style: text50012,),
                    ],
                  ),


                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}

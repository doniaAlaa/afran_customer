import 'package:afran/constant/app_colors.dart';
import 'package:afran/constant/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductiveFamilyItem extends StatelessWidget {
  final String imagePath;
  final String title;
  final String title1;
  final String title2;
  final String price;
  const ProductiveFamilyItem({super.key,
  required this.imagePath,
  required this.title,
  required this.title1,
  required this.title2,
  required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) =>  ProductDetailsScreen()),
        // );

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
                Image.network(imagePath, width: 140, height: 140, fit: BoxFit.cover),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 8),
                      Text(title1, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500,color: darkPurple)),
                      const SizedBox(height: 16),
                      Text(title2, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 16),

                      if (price.isNotEmpty)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(price, style: text70018.copyWith(color: darkPurple2)),
                                SizedBox(width: 8,),
                                Text(
                                    price, style:
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
                                    child: SvgPicture.asset('assets/images/white_cart.svg'),
                                  )
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
                decoration: BoxDecoration(
                    color: purple,
                    borderRadius: BorderRadius.circular(8)
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4),
                  child: Text('خصم ٢٠٪'),
                )),
          ),
        ],
      ),
    );
  }

}

import 'package:afran/constant/app_colors.dart';
import 'package:afran/constant/app_images.dart';
import 'package:afran/constant/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ApplePay extends StatelessWidget {
  const ApplePay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: grey,
          borderRadius: BorderRadius.circular(12)
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(applePay),
                    Text("الغاء",style: text50016.copyWith(color: darkPurple),),

                  ],
                ),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(mastercard),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text("MASTERCARD PLATINUM(•••• 2505)",style: text50016,)),
                    Icon(Icons.arrow_forward_ios_sharp,color: darkPurple,size: 18,)

                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Divider(color: Color(0xFFB2B2B2),thickness: 0.5,),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('العنوان',style: text40010.copyWith(fontSize: 12,color: grey3),),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text('العنوان',style: text50016,)),
                    Icon(Icons.arrow_forward_ios_sharp,color: darkPurple,size: 18,)

                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Divider(color: Color(0xFFB2B2B2),thickness: 0.5,),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('اتصل',style: text40010.copyWith(fontSize: 12,color: grey3),),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text('example@gmail.come +96612345678',style: text50016,)),
                    Icon(Icons.arrow_forward_ios_sharp,color: darkPurple,size: 18,)

                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Divider(color: Color(0xFFB2B2B2),thickness: 0.5,),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('الإجمالي',style: text40010.copyWith(fontSize: 12,color: grey3),),
                    Text(' ٢٤ ر.س',style: text40010.copyWith(fontSize: 12,),),


                  ],
                ),
                SizedBox(height: 4,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('الشحن',style: text40010.copyWith(fontSize: 12,color: grey3),),
                    Text(' ٢٤ ر.س',style: text40010.copyWith(fontSize: 12,),),


                  ],
                ),
                SizedBox(height: 12,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('دفع',style: text40010.copyWith(fontSize: 12,color: grey3),),
                    Text(' ٢٤ ر.س',style: text50016,),


                  ],
                ),

              ],
            ),
          )
        ],
      ),
    );
  }

}

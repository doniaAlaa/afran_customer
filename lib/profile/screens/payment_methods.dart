import 'package:afran/constant/app_colors.dart';
import 'package:afran/constant/app_text_style.dart';
import 'package:afran/constant/main_app_bar.dart';
import 'package:flutter/material.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: MainAppBar(title: 'طرق الدفع'),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ListView.builder(
                  shrinkWrap: true,
                    itemCount: 4,
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context,index){
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: grey,
                            borderRadius: BorderRadius.circular(16)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(

                                  children: [
                                    Container(
                                      height: 62,width: 62,
                                      decoration: BoxDecoration(
                                        color: purple,
                                        shape: BoxShape.circle
                                      ),
                                    ),
                                    SizedBox(width: 16,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('بطاقة مدى',style:text70016,),
                                        SizedBox(height:4,),
                                        Text('XXXX  XXXX  XXXX  5678',style: text40012.copyWith(color: grey3),),
                                        SizedBox(height: 4,),
                                        Row(
                                          children: [
                                            Text('انتهاء الصلاحية: 01/22',style: text50010,),
                                            SizedBox(width: 8,),
                                            Text('908 :CVV',style: text50010,),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Icon(Icons.keyboard_arrow_down_sharp,color: darkPurple,)
                              ],
                            ),
                          ),
                        ),
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


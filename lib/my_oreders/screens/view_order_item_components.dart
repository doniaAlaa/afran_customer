import 'package:afran/constant/app_colors.dart';
import 'package:afran/constant/app_images.dart';
import 'package:afran/constant/app_text_style.dart';
import 'package:afran/constant/main_app_button.dart';
import 'package:afran/my_oreders/widgets/item_component_widget.dart';
import 'package:afran/my_oreders/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ViewOrderItemComponents extends StatelessWidget {
  const ViewOrderItemComponents({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.white,
            leading: Icon(Icons.arrow_back_ios,size: 20,color: darkPurple2,),
            titleSpacing: 0,
            title:  Text('عرض العناصر',style: text70018.copyWith(color: darkPurple2),)),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              SizedBox(height: 16,),
              Container(
            decoration: BoxDecoration(
                color: grey,
                borderRadius: BorderRadius.circular(12)
            ),
            child:Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
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
                              Text('الطلب رقم 90898',style: text60014,),
                              SizedBox(height: 4,),
                              Text('تم الطلب بتاريخ ١٢ أبريل ٢٠٢٥م',style: text50012.copyWith(color: grey3),),
                              SizedBox(height: 8,),
                              Row(
                                children: [
                                  Text(' عدد العناصر: ',style: text50012.copyWith(color: darkPurple),),
                                  Text('٢',style: text50012,),
                                  SizedBox(width:8),
                                  Text('الاجمالي: ',style: text50012.copyWith(color: darkPurple),),
                                  Text('٢٤ ر.س',),
                                ],
                              ),

                            ],
                          ),

                        ],
                      ),
                      Icon(Icons.keyboard_arrow_down)

                    ],
                  ),
                  SizedBox(height: 16,),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: 3,
                      itemBuilder: (context,index){

                    return  Column(
                      children: [
                        ItemComponentWidget(title1:'متوسط الحجم'  ,title: 'خبز خمير تقليدي', imagePath: 'assets/images/1.png', price: ' ١٦ ر.س',),
                        if (index < 2)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Divider(color: grey3,thickness: 0.8,),
                        ),
                      ],
                    );

                  }),



                ],
              ),
            ) ,
          )

            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 16),
          child: MainAppButton(onPressed: (){}, title: 'اعادة الطلب'),
        ),
      ),
    );

  }
}


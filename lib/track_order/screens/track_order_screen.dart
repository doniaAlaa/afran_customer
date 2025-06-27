import 'package:afran/constant/app_colors.dart';
import 'package:afran/constant/app_images.dart';
import 'package:afran/constant/app_text_style.dart';
import 'package:afran/my_oreders/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class  TrackOrderScreen extends StatelessWidget {
  const  TrackOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [

                Container(
                  height: MediaQuery.of(context).size.height ,
                  color: purple,
                ),
                Container(
                  height: MediaQuery.of(context).size.height ,

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 50),
                        child: Row(
                          children: [
                            Icon(Icons.arrow_back_ios,color: darkPurple,),
                            SizedBox(width: 16,),
                            Text('تتبع طلبك',style: text70018.copyWith(color: darkPurple2),)
                          ],
                        ),
                      ),

                      Container(
                        height: MediaQuery.of(context).size.height * 0.45,
                        decoration: BoxDecoration(
                          color: Colors.white,
                            borderRadius:BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30))
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    child: DecoratedBox(decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: purple,

                                    ),child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 19),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 56,width: 56,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(14.0),
                                              child: SvgPicture.asset(deliveryIcon),
                                            ),
                                          ),
                                          SizedBox(width: 12,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('طلبك في الطريق إليك',style: text70016,),
                                              SizedBox(height: 8,),
                                              Text('يُتوقع الوصول ٢٠ دقيقة ',style: text70014.copyWith(color: darkPurple2,fontSize: 12),)
                                            ],
                                          )
                                        ],
                                      ),
                                    ),),
                                  ),
                                  OrderTimeline(),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 50,width: 50,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(1000),
                                          child: Image.network(
                                              fit: BoxFit.cover,
                                              'https://plus.unsplash.com/premium_photo-1690407617542-2f210cf20d7e?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cGVyc29ufGVufDB8fDB8fHww'),
                                        ),
                                      ),
                                      SizedBox(width: 16),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('محمد علي',style: text70014,),
                                          SizedBox(height: 4,),
                                          Text('السائق',style: text40012.copyWith(color: grey3),)
                                        ],
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: 40,width: 40,
                                        decoration: BoxDecoration(
                                            color: darkPurple,
                                            shape: BoxShape.circle
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SvgPicture.asset(white_phone),
                                        ),
                                      ),
                                      SizedBox(width: 8,),
                                      Container(
                                        height: 40,width: 40,
                                        decoration: BoxDecoration(
                                            color: purple,
                                            shape: BoxShape.circle
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SvgPicture.asset(chat),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}


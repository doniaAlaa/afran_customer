import 'package:afran/constant/app_colors.dart';
import 'package:afran/constant/app_images.dart';
import 'package:afran/constant/app_text_style.dart';
import 'package:afran/constant/main_app_button.dart';
import 'package:afran/my_oreders/models/my_orders_model.dart';
import 'package:afran/my_oreders/screens/view_order_item_components.dart';
import 'package:afran/my_oreders/widgets/vertical_dash_line_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class OrderItem extends StatefulWidget {
  final MyOrdersModel order;
   OrderItem({super.key,required this.order});

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  String orderDate = '';

  void date() async {
    // Must be called before formatting with Arabic
    await initializeDateFormatting('ar');

    String dateStr =  widget.order.created_at??'';
    DateTime date = DateTime.parse(dateStr);

    String formatted = DateFormat('d MMMM y', 'ar').format(date);
    orderDate = formatted + 'م' ;
    print(formatted + 'م'); // Example: ٢٥ مايو ٢٠٢٥م
  }

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async{
       date();
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
     date();
    return Container(
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
                        Text('الطلب رقم '+'${widget.order.id.toString()}',style: text60014,),
                        SizedBox(height: 4,),
                        Text('تم الطلب بتاريخ ' + orderDate ,style: text50012.copyWith(color: grey3),),
                        InkWell(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>  ViewOrderItemComponents()),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10.0,bottom: 10),
                            child: Text(
                              style:TextStyle(decoration: TextDecoration.underline,fontSize: 12,fontWeight: FontWeight.w500,color: darkPurple),
                              'عرض العناصر',),
                          ),
                        ),
                        Row(
                          children: [
                            Text(' عدد العناصر: ',style: text50012.copyWith(color: darkPurple),),
                            Text(widget.order.total_quantity.toString(),style: text50012,),
                            SizedBox(width:8),
                            Text('الاجمالي: ',style: text50012.copyWith(color: darkPurple),),
                            Text(' ${widget.order.total_price} '+'ر.س',),
                          ],
                        ),

                      ],
                    ),

                  ],
                ),
                Icon(Icons.keyboard_arrow_down)

              ],
            ),
            OrderTimeline(),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    child: MainAppButton(
                      icon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: SvgPicture.asset(followOrder),
                      ),

                      title: 'تتبع الطلب',
                      onPressed: () {

                      },),
                  ),
                ),
                SizedBox(width: 8,),
                Expanded(
                  child: Container(
                    height: 40,
                    child: MainAppButton(
                      title: 'الغاء',
                      backgroundColor: grey2,
                      titleColor: grey3,
                      onPressed: () {

                      },),
                  ),
                ),
              ],
            ),


          ],
        ),
      ) ,
    );
  }
}



class OrderTimeline extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              // Column for status and timeline
              Row(
                children: [
                  Icon(Icons.circle,size: 20,color: darkPurple,),
                  SizedBox(width: 16,),
                  Text('تم تأكيد الطلب',style: text70014.copyWith(color: darkPurple,fontSize: 12),),

                ],
              ),
              Text(' ١٢ أبريل ٢٠٢٥م',style: text50012.copyWith(color: grey3),)
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child:
            // Container(height: 18,color: darkPurple,width: 1.5,),
              VerticalDashLineWidegt(height: 18,color: grey3.withOpacity(0.3),)
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              // Column for status and timeline
              Row(
                children: [
                  Icon(Icons.circle,size: 20,color: darkPurple,),
                  SizedBox(width: 16,),
                  Text('قيد التحضير',style: text70014.copyWith(color: darkPurple,fontSize: 12),),

                ],
              ),
              Text(' ١٢ أبريل ٢٠٢٥م',style: text50012.copyWith(color: grey3),)
            ],
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child:
              // Container(height: 18,color: darkPurple,width: 1.5,),
              VerticalDashLineWidegt(height: 18,color: grey3.withOpacity(0.3),)
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              // Column for status and timeline
              Row(
                children: [
                  Icon(Icons.circle,size: 20,color: darkPurple,),
                  SizedBox(width: 16,),
                  Text('جاري التحضير',style: text70014.copyWith(color: darkPurple,fontSize: 12),),

                ],
              ),
              Text('قيد الانتظار',style: text50012.copyWith(color: grey3),)
            ],
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child:
              // Container(height: 18,color: darkPurple,width: 1.5,),
              VerticalDashLineWidegt(height: 18,color: grey3.withOpacity(0.3),)
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              // Column for status and timeline
              Row(
                children: [
                  Icon(Icons.circle,size: 20,color: darkPurple,),
                  SizedBox(width: 16,),
                  Text('تم التسليم',style: text70014.copyWith(color: darkPurple,fontSize: 12),),

                ],
              ),
              Text('قيد الانتظار',style: text50012.copyWith(color: grey3),)
            ],
          ),

        ],
      ),
    );
  }
}

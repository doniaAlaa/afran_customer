import 'package:afran/constant/app_colors.dart';
import 'package:afran/constant/app_text_style.dart';
import 'package:afran/constant/main_app_bar.dart';
import 'package:afran/profile/controllers/faq_controller.dart';
import 'package:afran/profile/models/faq_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FaqScreen extends StatelessWidget {
  FaqScreen({super.key});

  FAQController faqController = Get.put(FAQController());
  @override
  Widget build(BuildContext context) {
    faqController.getFAQ();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: MainAppBar(title: 'الأسئلة الشائعة'),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 30),
            child:
            Obx((){
              return faqController.loading.value? Center(
                child: Container(
                    height: 50,width: 50,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: CircularProgressIndicator(color: darkPurple,strokeWidth: 1.8,),
                    )),
              ):faqController.faqList.isEmpty?Center(child: Text('لا توجد أسئلة حتى الآن', style: text70020,
                textAlign: TextAlign.center,))
                  : SingleChildScrollView(
                child: Column(
                  children: [

                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: faqController.faqList.length,
                        itemBuilder: (context,index){

                          return


                            CollapsibleWidget(faqModel: faqController.faqList[index],);

                        })
                  ],
                ),
              );
            })


        ),
      ),
    );
  }
}

class CollapsibleWidget extends StatefulWidget {

  final FaqModel faqModel;

  CollapsibleWidget({required this.faqModel});
  @override
  _CollapsibleWidgetState createState() => _CollapsibleWidgetState();
}

class _CollapsibleWidgetState extends State<CollapsibleWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => setState(() => isExpanded = !isExpanded),
          child: Container(
            decoration: BoxDecoration(
                color:isExpanded ? purple: grey,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16),
                  topLeft: Radius.circular(16),
                  bottomRight:isExpanded ? Radius.zero: Radius.circular(16),
                  bottomLeft:isExpanded ? Radius.zero: Radius.circular(16),
                )
            ),
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.faqModel.question??'',style: text70016,),
                Icon(isExpanded ? Icons.expand_less : Icons.expand_more, color: darkPurple),
              ],
            ),
          ),
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          height: isExpanded ? 100 : 0,
          child: Container(
            decoration: BoxDecoration(
                color: purple,

                borderRadius: BorderRadius.only(

                  bottomRight: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                )
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 16),
              child: Text('يمكنك تعديل أو إلغاء الطلب قبل تأكيد التحضير من خلال صفحة "طلباتي"',style: text40012,),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:afran/constant/app_colors.dart';
import 'package:afran/constant/app_images.dart';
import 'package:afran/constant/app_text_style.dart';
import 'package:afran/profile/models/feedback_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FeedbacksWidget extends StatelessWidget {
  List<FeedbackModel> feedbacksList ;
   FeedbacksWidget({super.key,required this.feedbacksList});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top:24.0),
          child: Text("التقييمات",style: text70016.copyWith(color: darkGrey),),
        ),
        SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: feedbacksList.length,
            itemBuilder: (context,index){
          return FeedBackItem(feedbackModel: feedbacksList[index],);
        }),
      ],
    );
  }
}

class FeedBackItem extends StatelessWidget {
  final FeedbackModel feedbackModel;
  const FeedBackItem({super.key,required this.feedbackModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        decoration: BoxDecoration(
            color: grey,
            borderRadius: BorderRadius.circular(12)
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 72,width: 72,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(1000),
                        child: Image.network(
                            fit: BoxFit.cover,
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTefdAYZ6uy2rn4ODl9zSL1KwCAhiEPo9Xm-g&s')),
                  ),
                  SizedBox(width: 16,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(feedbackModel.user?.name??'',style: text70016),
                      SizedBox(height: 4,),
                      Row(
                        children: List.generate(feedbackModel.rating??0, (i) => SvgPicture.asset(star)),
                      ),
                      SizedBox(height: 4,),
                      Text(feedbackModel.time_ago??'',style: text40010.copyWith(color: grey3,fontSize: 12)),

                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Divider(color: grey2,thickness: 2,),
              ),
              Text(feedbackModel.feedback??'',style: text40010.copyWith(color: grey3,fontSize: 12)),

            ],
          ),
        ),
      ),
    );
  }
}

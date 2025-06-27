
import 'package:afran/constant/app_colors.dart';
import 'package:afran/constant/app_text_style.dart';
import 'package:afran/home/models/product_model.dart';
import 'package:afran/products/controllers/product_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddonsBottomSheet{


  chooseAddons(BuildContext context,List<SizesAndAddons>? addons,ProductDetailsController productDetailsController){

    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            height: 300,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              color: Colors.white,

            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("اختر المكونات",style: text70016,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 30),
                    child:Container(
                      height: 180,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: addons?.length,
                          itemBuilder: (context,index){
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: InkWell(
                                  onTap: (){

                                    // if(productDetailsController.selectedAddons.contains(addons?[index])){
                                    //   // productDetailsController.selectedAddonsIds.removeAt(index);
                                    // }else{
                                    //   productDetailsController.selectedAddons.add(addons![index]);
                                    //
                                    // }
                                    if(productDetailsController.selectedAddonsIds.contains(addons?[index])){
                                      // productDetailsController.selectedAddonsIds.removeAt(index);
                                    }else{
                                      productDetailsController.addonController.text = addons?[index].name??'';
                                      productDetailsController.selectedAddonItem?.value = addons![index];
                                      Navigator.pop(context);


                                    }
                                  },
                                  child:
                                   Text(addons?[index].name??''),

                                // Obx((){
                                  //   return Row(
                                  //     children: [
                                  //       Container(
                                  //         height: 20,width: 20,
                                  //         decoration: BoxDecoration(
                                  //             shape: BoxShape.circle,
                                  //             // border: Border.all(color: darkPurple)
                                  //         ),
                                  //         child: Padding(
                                  //           padding: const EdgeInsets.all(4.0),
                                  //           child: Container(
                                  //             height: 15,width: 15,
                                  //
                                  //             decoration: BoxDecoration(
                                  //                 shape: BoxShape.circle,
                                  //                 color:
                                  //                 // productDetailsController.selectedAddons.contains(addons?[index])
                                  //                 productDetailsController.selectedAddonItem == addons?[index]
                                  //                     ? null:null
                                  //             ),),
                                  //         ),
                                  //       ),
                                  //       SizedBox(width: 16,),
                                  //       Text(addons?[index].name??''),
                                  //     ],
                                  //   );
                                  // })
                              ),
                            );
                          }),
                    )
                  )

                ],
              ),
            ),
          ),
        );
      },
    );

  }
}
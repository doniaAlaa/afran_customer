import 'package:afran/cart/controllers/cart_controller.dart';
import 'package:afran/cart/models/cart_model.dart';
import 'package:afran/cart/widgets/delete_cart_item.dart';
import 'package:afran/constant/app_colors.dart';
import 'package:afran/constant/app_images.dart';
import 'package:afran/constant/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CartProductItem extends StatelessWidget {
  final String imagePath;
  final int index;
  // final String price;
  final CartItemModel cartItemModel;
  final CartController cartController;
  const CartProductItem({super.key,
    required this.imagePath,
    required this.cartItemModel,
    required this.cartController,
    // required this.price,
    required this.index,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(cartItemModel.product?.name??'', style: text60014),
                      InkWell(
                          onTap: () async{
                            final result = await DeleteCartItem().removeItem(context);

                            if (result == true) {
                               cartController.removeCartItem(index, cartItemModel.id??-1,context);
                            } else {
                            }

                          },
                          child: SvgPicture.asset(delete))
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(cartItemModel.product?.description??'', style: text40010.copyWith(color: grey3)),
                  const SizedBox(height: 16),

                  if (cartItemModel.product!.price!.isNotEmpty)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text('${cartItemModel.product!.price??' '}' +'ر.س' , style: text70016.copyWith(color: darkPurple2)),

                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: purple,
                              borderRadius: BorderRadius.circular(12)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0,horizontal: 4),
                            child: Row(
                              children: [
                                InkWell(
                                  child: Container(
                                    height: 18,width: 18,
                                    decoration: BoxDecoration(
                                        color: darkPurple,
                                        shape: BoxShape.circle
                                    ),
                                    child: Icon(Icons.add,color: Colors.white,size: 16,),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(cartItemModel.quantity.toString(),style: text70014.copyWith(color: darkPurple),),
                                ),
                                InkWell(
                                  onTap: (){
                                    // cartController.removeCartItem(index, cartItemModel.id??-1,context);
                                  },
                                  child: Container(
                                    height: 18,width: 18,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle
                                    ),
                                    child: Icon(Icons.remove,color: darkPurple,size: 16,),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )

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

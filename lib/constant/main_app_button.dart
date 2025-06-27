import 'package:afran/constant/app_colors.dart';
import 'package:afran/constant/app_text_style.dart';
import 'package:flutter/material.dart';

class MainAppButton extends StatelessWidget{
  final Function()? onPressed;
  final String title;
  final Color? disabledColor;
  final Widget? icon;
  final Color? titleColor;
  final Color? backgroundColor ;
  MainAppButton({required this.onPressed,required this.title,this.icon, this.disabledColor,this.titleColor,this.backgroundColor});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        // onPressed: () {
        //
        // },

        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,             // Removes shadow
          shadowColor: Colors.transparent,
          backgroundColor:backgroundColor?? darkPurple,
          disabledBackgroundColor: disabledColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon??SizedBox(),
            Text(
              title,
              style: text60014.copyWith(color:titleColor?? Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:afran/constant/app_colors.dart';
import 'package:afran/constant/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? fieldLabel;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color?  backgroundColor;
  final Color? borderColor;
  final double? height ;
  final int? maxLines ;
  final int? minLines ;
  final bool? readOnly;
  final Function()? onTap;
  final int? maxLength;
  final EdgeInsetsGeometry? contentPadding;
  final TextAlign? inputAlignment;
  const AppTextField({
    this.controller,
    this.validator,
    this.height,
    this.maxLines,
    this.minLines,
    this.inputFormatters,
    this.keyboardType,
    this.readOnly,
    this.onTap,
    this.contentPadding,
    this.maxLength,
    this.inputAlignment,
    this.fieldLabel,required this.hintText,this.prefixIcon,this.suffixIcon,this.backgroundColor,this.borderColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        fieldLabel != null?
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            fieldLabel!,
            style: text70014,
          ),
        ):SizedBox(height: 0,),
        Container(
          height:height,
          child: TextFormField(
              textAlign: inputAlignment??TextAlign.start, // Aligns text to the center

              controller:controller,
              keyboardType:keyboardType,
              maxLength: maxLength,
              inputFormatters: inputFormatters,
              maxLines: maxLines,
              minLines: minLines,
              readOnly:readOnly??false,
              onTap: onTap,

              decoration: InputDecoration(
                contentPadding: contentPadding,

                filled:backgroundColor != null? true:false,
                // contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 12),
                fillColor: backgroundColor??null,
                suffixIcon: suffixIcon,
                hintText: hintText,
                hintStyle: text50014.copyWith(color: grey3),
                prefixIcon: prefixIcon,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color:borderColor?? grey2,width: 1.5), //
                  borderRadius: BorderRadius.circular(12),

                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color:borderColor?? grey2,width: 1.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: darkPurple,width: 1.5),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              validator: validator
          ),
        ),
      ],
    );
  }
}

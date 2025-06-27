import 'package:afran/constant/app_colors.dart';
import 'package:afran/constant/app_form_validation.dart';
import 'package:afran/constant/app_images.dart';
import 'package:afran/constant/app_text_field.dart';
import 'package:afran/constant/app_text_style.dart';
import 'package:afran/constant/main_app_button.dart';
import 'package:afran/forget_pass/screens/controllers/forget_password_controller.dart';
import 'package:afran/forget_pass/screens/success_update_pass_screen.dart';
import 'package:afran/login/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class AddNewPassScreen extends StatefulWidget {
  final String identifier;
  final String reset_token;
  const AddNewPassScreen({Key? key,required this.identifier,required this.reset_token}) : super(key: key);

  @override
  State<AddNewPassScreen> createState() => _AddNewPassScreenState();
}

class _AddNewPassScreenState extends State<AddNewPassScreen> {

  final _formKey = GlobalKey<FormState>();
  ForgetPasswordController forgetPasswordController = Get.put(ForgetPasswordController());
  @override
  void initState() {
    super.initState();
    forgetPasswordController.newPassController.clear();
    forgetPasswordController.confirmPassController.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,

        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const SizedBox(height: 24),
                // const Align(
                //   alignment: Alignment.topRight,
                //   child: Icon(Icons.arrow_back_ios_new, size: 20),
                // ),
                const SizedBox(height: 48),
                const Text(
                  'تعيين كلمة مرور جديدة',
                  style: text70020,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'يرجى إدخال كلمة مرور جديدة لحسابك.',
                  style:text50014.copyWith(color: grey3),
                  // textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                Form(
                    key: _formKey,
                    child: Column(
                  children: [
                    AppTextField(
                      controller: forgetPasswordController.newPassController,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SvgPicture.asset(lockIcon,width: 16,height: 16,),
                      ),
                      suffixIcon: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Icon( Icons.visibility_off_rounded,color: grey3.withOpacity(0.5),)
                      ),

                      fieldLabel: "كلمة المرور الجديدة",
                      hintText: "أدخل كلمة المرور الجديدة",
                      validator: (value) => FormValidators.validateNewPass(value, fieldName: 'Username'),
                    ),
                    SizedBox(height: 16,),
                    AppTextField(
                      controller: forgetPasswordController.confirmPassController,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SvgPicture.asset(lockIcon,width: 16,height: 16,),
                      ),
                      suffixIcon: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Icon( Icons.visibility_off_rounded,color: grey3.withOpacity(0.5),)
                      ),
                      fieldLabel: "تأكيد كلمة المرور",
                      hintText: "أعد إدخال كلمة المرور",
                      validator: (value) => FormValidators.validatePassConfirmation(value,forgetPasswordController.newPassController.text),

                    ),
                  ],
                )),

                const SizedBox(height: 32),
                Obx((){

                  return forgetPasswordController.resetPassLoading.value?Center(
                    child: Container(
                        height: 30,width: 30,
                        child: CircularProgressIndicator(color: darkPurple,strokeWidth: 1.5,)),
                  ) :MainAppButton(

                    title: 'تحديث كلمة المرور',
                    onPressed: () {

                      if (_formKey.currentState!.validate()) {

                        forgetPasswordController.resetPass(context,widget.identifier,widget.reset_token);


                      }else{

                      }
                    },);
                })



              ],
            ),
          ),
        ),
      ),
    );
  }
}
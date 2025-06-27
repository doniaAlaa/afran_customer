import 'package:afran/constant/app_colors.dart';
import 'package:afran/constant/app_text_field.dart';
import 'package:afran/constant/app_text_style.dart';
import 'package:afran/constant/main_app_button.dart';
import 'package:afran/forget_pass/screens/add_new_pass_screen.dart';
import 'package:afran/forget_pass/screens/controllers/forget_password_controller.dart';
import 'package:afran/login/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailOrPhoneController = TextEditingController();

  ForgetPasswordController forgetPasswordController = Get.put(ForgetPasswordController());

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

                const SizedBox(height: 48),
                const Text(
                  'نسيت كلمة المرور؟',
                  style: text70020,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                 Text(
                  'لا تقلق! فقط أدخل بريدك الإلكتروني أو رقم هاتفك وسنرسل لك رابطًا لإعادة تعيين كلمة المرور',
                  style:text50014.copyWith(color: grey3),
                  // textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),

                AppTextField(
                  controller: forgetPasswordController.emailPhoneController,
                  fieldLabel: 'البريد الإلكتروني أو رقم الهاتف',
                  hintText: "أدخل البريد الإلكتروني أو رقم الهاتف",),
                const SizedBox(height: 32),
                Obx((){
                  return forgetPasswordController.loading.value? Center(
                    child: Container(
                        height: 30,width: 30,
                        child: CircularProgressIndicator(color: darkPurple,strokeWidth: 1.5,)),
                  ):MainAppButton(
                    title: 'إرسال',
                    onPressed: () {

                      forgetPasswordController.forgetPass(context);

                    },);
                }),

                const SizedBox(height: 32),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      // TODO: Navigate to Register Page
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  LoginPage()),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            "تذكرت كلمة المرور؟",
                            style: text50014
                        ),
                        Text(
                            "تسجيل الدخول",
                            style: text50014.copyWith(color: darkPurple,decoration: TextDecoration.underline)
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
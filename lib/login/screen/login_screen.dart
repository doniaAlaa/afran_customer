import 'package:afran/constant/app_colors.dart';
import 'package:afran/constant/app_form_validation.dart';
import 'package:afran/constant/app_images.dart';
import 'package:afran/constant/app_text_field.dart';
import 'package:afran/constant/app_text_style.dart';
import 'package:afran/constant/main_app_button.dart';
import 'package:afran/constant/main_app_button.dart';
import 'package:afran/forget_pass/screens/forget_pass_screen.dart';
import 'package:afran/login/controllers/login_controller.dart';
import 'package:afran/register/screens/register_screen.dart';
import 'package:afran/verification/screens/verify_ecreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool rememberMe = false;
  bool passwordVisible = false;
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  LoginController loginController = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: Directionality(
        textDirection: TextDirection.ltr, // For Arabic layout
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "مرحباً بعودتك",
                      style: text70020,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "سجل دخولك للوصول إلى عالم الأسر المنتجة.",
                      style: text50014.copyWith(color: grey3),
                    ),
                    SizedBox(height: 32),

                    // Phone field
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'رقم الهاتف',
                        style: text70014,
                      ),
                    ),
                    SizedBox(height: 8,),
                    AppTextField(
                      controller: phoneController,
                      // prefixIcon: Padding(
                      //   padding: const EdgeInsets.all(15.0),
                      //   child: SvgPicture.asset(phoneIcon,width: 16,height: 16,),
                      // ),
                      maxLength: 9,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Container(
                          width: 50,
                          height: 56,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: grey2)
                          ),
                          child: Center(child: Text('+966',style: text50014,)),
                        ),
                      ),
                      keyboardType: TextInputType.number,

                      inputFormatters:
                      [FilteringTextInputFormatter.digitsOnly],
                      validator: (value) => FormValidators.validatePhone(value, fieldName: 'Username'),

                      // fieldLabel: "رقم الهاتف",
                      hintText: "أدخل رقم الهاتف",),
                    SizedBox(height: 24),

                    // Password field
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "كلمة المرور",
                        style: text70014,
                      ),
                    ),
                    SizedBox(height: 8,),
                    AppTextField(
                      controller: passwordController,
                      keyboardType: TextInputType.number,
                      inputFormatters:
                      [FilteringTextInputFormatter.digitsOnly],
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SvgPicture.asset(lockIcon,width: 16,height: 16,),
                      ),
                      validator: (value) => FormValidators.validateRequired(value, fieldName: 'Username'),

                      // fieldLabel: "كلمة المرور",
                      hintText: "أدخل كلمة المرور",),



                    SizedBox(height: 16),

                    // Remember Me + Forgot Password
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            // TODO: Forgot Password Navigation
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>  ForgotPasswordScreen()),
                            );
                          },
                          child: Text(
                            "نسيت كلمة المرور؟",
                            style: text50012.copyWith(color: darkPurple,decoration: TextDecoration.underline),
                          ),
                        ),
                        Row(
                          children: [

                            Text(
                              "تذكرني",
                              style:text50012,
                            ),
                            Checkbox(
                              value: rememberMe,
                              onChanged: (value) {
                                setState(() {
                                  rememberMe = value!;
                                });
                              },
                              activeColor: Color(0xFFB46EB4),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 32),

                    // Login button
                    Obx((){
                      return loginController.isLoading.value? Center(
                        child: Container(
                            height: 30,width: 30,
                            child: CircularProgressIndicator(color: darkPurple,strokeWidth: 1.5,)),
                      ) :MainAppButton(
                        title: 'تسجيل الدخول',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            dynamic data = {
                              "phone": '+966${phoneController.text}',
                              "password": passwordController.text,
                              "role": "customer",
                              "remember_me": rememberMe

                            };
                            loginController.login(context,data);
                          }else{
                          }


                        },);
                    }),
                    SizedBox(height: 20),

                    // Don't have account
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          // TODO: Navigate to Register Page
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  RegisterPage()),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "ليس لديك حساب؟ ",
                              style: text50014
                            ),
                            Text(
                             "أنشئ حساباً جديداً",
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
        ),
      ),
    );
  }
}

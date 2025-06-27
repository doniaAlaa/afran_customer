import 'package:afran/constant/app_colors.dart';
import 'package:afran/constant/app_form_validation.dart';
import 'package:afran/constant/app_images.dart';
import 'package:afran/constant/app_text_field.dart';
import 'package:afran/constant/app_text_style.dart';
import 'package:afran/constant/main_app_button.dart';
import 'package:afran/login/screen/login_screen.dart';
import 'package:afran/register/controller/register_controller.dart';
import 'package:afran/verification/screens/verify_ecreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool passwordVisible = false;
  bool confirmPasswordVisible = false;
  bool agreeToTerms = false;
  final _formKey = GlobalKey<FormState>();

  RegisterController registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "انضم إلينا",
                    style: text70020
                  ),
                  SizedBox(height: 8),
                  Text(
                    "أنشئ حساباً جديداً واستمتع بمنتجات الأسر المنتجة.",
                    style: text50014.copyWith(color: grey3),
                  ),
                  SizedBox(height: 32),
            
                  // Full Name
                  AppTextField(
                    controller: registerController.nameController,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SvgPicture.asset(person,width: 16,height: 16,),
            
                    ),
                    validator: (value) => FormValidators.validateRequired(value, fieldName: 'Username'),

                    fieldLabel:"الاسم كامل",
                    hintText:  "أدخل الاسم كامل",
            
                  ),
            
                  SizedBox(height: 16),
            
                  // Phone Number
                  Align(
                    alignment: Alignment.centerRight,

                    child: Text(
                      'رقم الهاتف',
                      style: text70014,
                    ),

                  ),
                  SizedBox(height: 8,),
                  AppTextField(
                    controller: registerController.phoneController,
                    inputAlignment: TextAlign.end,

                    maxLength: 9,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Container(
                        width: 50,
                        height: 56,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: grey2)
                        ),
                        child: Center(child: Text('966+',style: text50014,)),
                      ),
                    ),
                    keyboardType: TextInputType.number,
            
                    inputFormatters:
                    [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) => FormValidators.validatePhone(value, fieldName: 'Username'),
            
                    // fieldLabel: "رقم الهاتف",
                    hintText: "أدخل رقم الهاتف",),
            
            
                  SizedBox(height: 10),
                  // email
                  Align(
                    alignment: Alignment.centerRight,

                    child: Text(
                      'البريد الإلكتروني',
                      style: text70014,
                    ),

                  ),
                  SizedBox(height: 8,),
                  AppTextField(
                    controller: registerController.emailController,
                    // inputAlignment: TextAlign.end,

                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Icon(Icons.alternate_email,color:Colors.grey ,),
                    ),

                    validator: (value) => FormValidators.validateEmail(value,),

                    // fieldLabel: "رقم الهاتف",
                    
                    hintText: "أدخل البريد الإلكتروني",),
                  SizedBox(height: 16),

                  // Password
                  AppTextField(
                    controller: registerController.passController,
                    inputAlignment: TextAlign.end,
                    validator: (value) => FormValidators.validatePassword(value,),

                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SvgPicture.asset(lockIcon,width: 16,height: 16,),
                    ),
                    fieldLabel: "كلمة المرور",
                    hintText: "أدخل كلمة المرور",),
                  SizedBox(height: 16),
                  // Confirm Password
            
                  AppTextField(
                    controller: registerController.passConfirmationController,
                    inputAlignment: TextAlign.end,
                    validator: (value) => FormValidators.validatePassConfirmation(value,registerController.passController.text),

                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SvgPicture.asset(lockIcon,width: 16,height: 16,),
                    ),
                    fieldLabel: "تأكيد كلمة المرور",
                    hintText: "أعد إدخال كلمة المرور",),
            
            
                  SizedBox(height: 16),
            
                  // Agree to Terms
                  Row(
                    children: [
                      Theme(
                        data: Theme.of(context).copyWith(
                          checkboxTheme: CheckboxThemeData(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4), //
                            ),
                          ),),
                        child: Checkbox(
                          value: agreeToTerms,
                          onChanged: (value) {
                            setState(() {
                              agreeToTerms = value!;
                            });
                          },
                          activeColor: Color(0xFFB46EB4),
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, //
                          visualDensity: VisualDensity.compact,
                          side: BorderSide(color: grey3),
            
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "أوافق على ",
                            style: text50012,
                          ),
                          Text(
                            "الشروط والأحكام",
                            style: text50012.copyWith(color: darkPurple,decoration:TextDecoration.underline ),
                          ),
                          Text(
                            " و ",
                            style: text50012,
                          ),
                          Text(
                            "سياسة الخصوصية",
                            style: text50012.copyWith(color: darkPurple,decoration:TextDecoration.underline ),
                          ),
            
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
            
                  // Create Account button
                  Obx((){
                    return registerController.loading.value? Center(
                      child: Container(
                          height: 30,width: 30,
                          child: CircularProgressIndicator(color: darkPurple,strokeWidth: 1.5,)),
                    ):  MainAppButton(
                      title:  "إنشاء حساب",
                      disabledColor:grey2 ,
                      onPressed:
                      agreeToTerms
                          ? () {
                        // TODO: Register action

                        if (_formKey.currentState!.validate()) {
                          registerController.register(context);
                        }else{
                        }

                      }
                          : null,
                    );
                  }),


                  SizedBox(height: 20),
            
                  // Already have an account
                  Center(
                    child: InkWell(
                      onTap: () {
                        // TODO: Navigate to login
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  LoginPage()),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "لديك حساب بالفعل؟ ",
                            style: text50014,
                          ),
                          Text(
                            "تسجيل الدخول",
                            style: text50014.copyWith(color: darkPurple),
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
    );
  }
}

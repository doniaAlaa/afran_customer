import 'package:afran/constant/app_colors.dart';
import 'package:afran/constant/app_form_validation.dart';
import 'package:afran/constant/app_images.dart';
import 'package:afran/constant/app_text_field.dart';
import 'package:afran/constant/main_app_bar.dart';
import 'package:afran/constant/main_app_button.dart';
import 'package:afran/entity/user_model.dart';
import 'package:afran/profile/controllers/user_info_controller.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class UserInfoScreen extends StatefulWidget {
  final UserModel userModel;
  const UserInfoScreen({super.key,required this.userModel});

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {

  UserInfoController userInfoController = Get.put(UserInfoController());
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // executes after build
      userInfoController.nameController.text = widget.userModel.name??'';
      userInfoController.familyNameController.text = widget.userModel.owner??'';
      userInfoController.emailController.text = widget.userModel.email??'';
      String phone = widget.userModel.phone!.replaceAll('+', '');
      userInfoController.phoneController.text = '${phone}+';

    });
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: MainAppBar(title: 'بياناتي'),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          height: 106,width: 106,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(1000),
                            child: Image.network(
                                fit: BoxFit.cover,
                                'https://plus.unsplash.com/premium_photo-1690407617542-2f210cf20d7e?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cGVyc29ufGVufDB8fDB8fHww'),
                          ),

                        ),
                        InkWell(
                          onTap: () async {
                            FilePickerResult? result = await FilePicker.platform.pickFiles(
                                allowMultiple: false,
                                type: FileType.custom,
                                allowedExtensions: ['jpg']
                            );
                            if(result != null){
                              // ProfileImageAlert().changeProfileImageAlert(context,result,userInfoController);
                              userInfoController.updateProfileImage(context,result);
                            }
                          },
                          child: Container(
                            height: 36,width: 36,
                            decoration: BoxDecoration(
                                color: darkPurple,
                                shape: BoxShape.circle
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SvgPicture.asset(editIcon),
                            ),
                          ),
                        )

                      ],
                    ),
                  ),
                  SizedBox(height: 16,),
                  AppTextField(
                    controller: userInfoController.nameController,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SvgPicture.asset(person,width: 16,height: 16,),

                    ),
                    validator: (value) => FormValidators.validateRequired(value, fieldName: 'Username'),

                    fieldLabel:"الاسم كامل",
                    hintText:  "أدخل الاسم كامل",

                  ),
                  SizedBox(height: 16,),
                  AppTextField(
                    controller: userInfoController.emailController,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SvgPicture.asset(person,width: 16,height: 16,),

                    ),
                    validator: (value) => FormValidators.validateEmail(value,),
                    fieldLabel:"البريد الإلكتروني",
                    hintText:  "example@email.com",

                  ),
                  SizedBox(height: 16),

                  // Phone Number
                  AppTextField(
                    controller: userInfoController.phoneController,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SvgPicture.asset(phoneIcon,width: 16,height: 16,),
                    ),
                    validator: (value) => FormValidators.validateRequired(value, fieldName: 'Username'),

                    fieldLabel: "رقم الهاتف",
                    hintText: "أدخل رقم الهاتف",),

                  SizedBox(height: 16),

                  // Password
                  AppTextField(
                    // controller: userInfoController.p,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SvgPicture.asset(lockIcon,width: 16,height: 16,),
                    ),
                    suffixIcon: Icon(Icons.visibility_off_outlined,color: Colors.black.withOpacity(0.3),),
                    fieldLabel: "كلمة المرور",
                    hintText: "أدخل كلمة المرور",),
                  SizedBox(height: 16),

                  // Password
                  AppTextField(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SvgPicture.asset(lockIcon,width: 16,height: 16,),
                    ),
                    suffixIcon: Icon(Icons.visibility_off_outlined,color: Colors.black.withOpacity(0.3),),
                    fieldLabel: "كلمة المرور الجديدة",
                    hintText: "أدخل كلمة المرورالجديدة",),
                  // Confirm Password
                  SizedBox(height: 16,),
                  AppTextField(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SvgPicture.asset(lockIcon,width: 16,height: 16,),
                    ),
                    fieldLabel: "تأكيد كلمة المرور",
                    hintText: "أعد إدخال كلمة المرور",),
                  SizedBox(height: 24,),
                  Row(
                    children: [
                      Obx((){
                        return userInfoController.updateLoading.value?
                        Container(
                            height: 50,width: 50,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: CircularProgressIndicator(color: darkPurple,strokeWidth: 1.8,),
                            )):
                        Expanded(child: Container(child:
                        MainAppButton(onPressed: (){
                          if(userInfoController.selectedButton.value == 0){
                            userInfoController.updateAccountInfo(context);
                          }
                        }, title: 'حفظ')));
                      }),

                      SizedBox(width: 16,),
                      Expanded(child: Container(child: MainAppButton(
                          backgroundColor: grey,
                          titleColor: grey3,
                          onPressed: (){}, title: 'تجاهل'))),

                    ],
                  ),
                  SizedBox(height: 16,)


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


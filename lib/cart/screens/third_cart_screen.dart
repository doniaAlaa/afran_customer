import 'package:afran/cart/controllers/cart_controller.dart';
import 'package:afran/cart/widgets/apple_pay.dart';
import 'package:afran/cart/widgets/mada_pay.dart';
import 'package:afran/constant/app_colors.dart';
import 'package:afran/constant/app_images.dart';
import 'package:afran/constant/app_text_style.dart';
import 'package:afran/constant/main_app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';

class ThirdCartScreen extends StatefulWidget {
  final Function()? onPressed;
  const ThirdCartScreen({super.key,required this.onPressed});

  @override
  State<ThirdCartScreen> createState() => _ThirdCartScreenState();
}

class _ThirdCartScreenState extends State<ThirdCartScreen> {
  ////////////////// PAY THROUGH DIFFERENT PAYMENT METHOD //////////////
  List<MFPaymentMethod> methods = [];

  Future<List<MFPaymentMethod>> fetchPaymentMethods() async {
    final request = MFInitiatePaymentRequest(invoiceAmount: 10.0, currencyIso: MFCurrencyISO.KUWAIT_KWD);

    try {
      final response = await MFSDK.initiatePayment(request, MFLanguage.ENGLISH);
      response.paymentMethods?.forEach((e){
        if(e.paymentMethodEn?.toLowerCase() == 'mada' || e.paymentMethodEn?.toLowerCase() == 'apple pay' ){
          methods.add(e);
        }

      });
      // methods = response.paymentMethods ?? [];

      setState(() {

      });
      return response.paymentMethods ?? [];
    } catch (e) {
      // Handle the exception or log it
      print("Error fetching payment methods: $e");
      return [];
    }
  }
  ////////////////// PAY THROUGH DIFFERENT PAYMENT METHOD //////////////
  void executePayment(int methodId) async {
    var request = MFExecutePaymentRequest(
      invoiceValue: 10.0,
      paymentMethodId: methodId, // ✅ Set it here
    );

    try {
      var response = await MFSDK.executePayment(
        request,
        "en", // ✅ Pass language as string now
            (invoiceId) {
          print("Invoice ID: $invoiceId");
        },
      );

      // print("Payment URL: ${response.invoiceUrl}");

      // Optional: Open the browser
      // MFSDK.launchPayment(
      //   response.invoiceUrl!,
      //   MFLanguage.EN,
      //       (paymentStatus) {
      //     if (paymentStatus.isSuccess) {
      //       print("✅ Payment Successful");
      //     } else {
      //       print("❌ Payment Failed: ${paymentStatus.errorMessage}");
      //     }
      //   },
      // );
    } catch (e) {
      print("🚨 Payment error: $e");
    }
  }

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      fetchPaymentMethods();
    });
  }

  int paymentMethod = -1;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("الدفع عن طريق",style: text70016,),
            SizedBox(height: 16,),
            Container(
              height: 90,
              padding: EdgeInsets.symmetric(vertical: 0),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: methods.length,
                itemBuilder: (context, index) {
                  final method = methods[index];
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: InkWell(
                        onTap: (){
                          print('Selected Payment Method: ${method.paymentMethodId}');
                          print('Selected Payment Method: ${method.paymentMethodEn?.toLowerCase()}');
                          setState(() {
                            paymentMethod = index;

                          });
                          executePayment(method.paymentMethodId??-1);
                          // You can proceed to payment here
                        },
                        child: Container(

                          width: MediaQuery.of(context).size.width *0.45,
                          decoration: BoxDecoration(
                            color: paymentMethod == index? darkPurple:null,

                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: grey2),

                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // SvgPicture.asset(method.paymentMethodEn?.toLowerCase() == 'mada'? mada:applePay),
                                SvgPicture.asset(method.paymentMethodEn?.toLowerCase() == 'mada'?
                                paymentMethod == index? whiteMada:mada

                                    :

                                paymentMethod == index? whiteApplePay:
                                applePay),
                                SizedBox(width: 16,),
                                Column(
                                  children: [
                                    Text("٢٤ ر.س",style: text60014.copyWith(color: paymentMethod == index? Colors.white:grey3),),
                                    Text(method.paymentMethodEn?.toLowerCase() == 'mada'?"عبر مدي":'Apple Pay',style: text60014.copyWith(color:paymentMethod == index? Colors.white:grey3),),

                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ),
                  );
                },
              ),
            ),

            // PaymentScreen(),
            ///////////////////////////////
            // Padding(
            //   padding: const EdgeInsets.only(top: 16.0,bottom: 16),
            //   child: MainAppButton(
            //       onPressed: widget.onPressed, title: 'الدفع'),
            // )

          ],
        ),
      ),
    );
  }
}

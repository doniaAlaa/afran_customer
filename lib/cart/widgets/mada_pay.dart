import 'package:afran/constant/app_colors.dart';
import 'package:afran/constant/app_images.dart';
import 'package:afran/constant/app_text_field.dart';
import 'package:afran/constant/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';

class PaymentScreen extends StatefulWidget {
   PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  List<MFPaymentMethod> paymentMethods = [];
  final cardNumberController = TextEditingController();
  final expiryMonthController = TextEditingController();
  final expiryYearController = TextEditingController();
  final cvvController = TextEditingController();

  bool isLoading = true;

  // void getPaymentMethods() async {
  //   MFSDK.init("rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL",
  //       MFCountry.SAUDIARABIA, MFEnvironment.TEST);
  //
  //   var request = MFInitiatePaymentRequest(invoiceAmount: 100.0, currencyIso: MFCurrencyISO.SAUDIARABIA_SAR); // Replace with your amount/currency
  //
  //   MFInitiatePaymentResponse response =
  //   await MFSDK.initiatePayment(request, 'AR');
  //
  //   setState(() {
  //     paymentMethods = response.paymentMethods!;
  //     isLoading = false;
  //   });
  // }

  bool saveCard = false;



  executeDirectPayment() async {
    var executePaymentRequest = MFExecutePaymentRequest(invoiceValue: 10);
    executePaymentRequest.paymentMethodId = 20;

    var mfCardRequest = MFCard(
      cardHolderName: 'myFatoorah',
      number: '5454545454545454',
      expiryMonth: '10',
      expiryYear: '23',
      securityCode: '000',
    );

    var directPaymentRequest = MFDirectPaymentRequest(
        executePaymentRequest: executePaymentRequest,
        token: null,
        card: mfCardRequest);

    await MFSDK
        .executeDirectPayment(directPaymentRequest, MFLanguage.ENGLISH,
            (invoiceId) {
          debugPrint(invoiceId);
        })
        .then((value) => debugPrint(value.toString()))
        .catchError((error) => {debugPrint(error.message)});
  }

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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 90,
          padding: EdgeInsets.symmetric(vertical: 0),
          child: Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: methods.length,
              itemBuilder: (context, index) {
                final method = methods[index];
                return InkWell(
                  onTap: (){
                    print('Selected Payment Method: ${method.paymentMethodId}');
                    print('Selected Payment Method: ${method.paymentMethodEn?.toLowerCase()}');
                    executePayment(method.paymentMethodId??-1);
                    // You can proceed to payment here
                  },
                  child: Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Container(

                        width: MediaQuery.of(context).size.width *0.45,

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: grey2),

                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(mada),
                              SizedBox(width: 16,),
                              Column(
                                children: [
                                  Text("٢٤ ر.س",style: text60014.copyWith(color: grey3),),
                                  Text("عبر مدي",style: text60014.copyWith(color: grey3),),

                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16)
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: SvgPicture.asset(visa,fit: BoxFit.cover,),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 190,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16)
              ),
              child:Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(

                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    // GridView.builder(
                    //
                    //   padding: EdgeInsets.all(16),
                    //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //     crossAxisCount: 2, // or 1 for list
                    //     childAspectRatio: 1.5,
                    //     crossAxisSpacing: 12,
                    //     mainAxisSpacing: 12,
                    //   ),
                    //   itemCount: paymentMethods.length,
                    //   itemBuilder: (context, index) {
                    //     final method = paymentMethods[index];
                    //     return GestureDetector(
                    //       // onTap: () => executePayment(method.paymentMethodId!),
                    //       child: Card(
                    //         shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(16),
                    //         ),
                    //         elevation: 4,
                    //         child: Column(
                    //           mainAxisAlignment: MainAxisAlignment.center,
                    //           children: [
                    //             Image.network(method.imageUrl ?? '', height: 40),
                    //             SizedBox(height: 12),
                    //             Text(
                    //               method.paymentMethodAr ?? method.paymentMethodEn ?? '',
                    //               style: TextStyle(fontWeight: FontWeight.bold),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     );
                    //   },
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset(visaLogo,fit: BoxFit.cover,),
                        Text("Credit",style: text50016.copyWith(color: Colors.white),),


                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("Mahmoud Ahmed",style: text50016.copyWith(color: Colors.white),),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("12/30",style: text50016.copyWith(color: Colors.white),),
                            Text("4802 2215 1183 4289",style: text50016.copyWith(color: Colors.white),),
                          ],
                        ),



                      ],
                    )
                  ],
                ),
              )
            ),
          ],
        ),
        AppTextField(
            backgroundColor: grey,
            borderColor: grey,
            prefixIcon: Padding(

              padding: const EdgeInsets.all(15.0),
              child: SvgPicture.asset(person,width: 16,height: 16,),

            ),
            hintText:
        'الاسم على البطاقة'),
        AppTextField(
            backgroundColor: grey,
            borderColor: grey,
            prefixIcon: Padding(

              padding: const EdgeInsets.all(15.0),
              child: SvgPicture.asset(mada,width: 16,height: 16,),

            ),
            hintText:
        'رقم البطاقة'),
        Row(
          children: [
            Expanded(
              child: Container(
                child: AppTextField(
                    backgroundColor: grey,
                    borderColor: grey,
                    prefixIcon: Padding(

                      padding: const EdgeInsets.all(15.0),
                      child: Icon(Icons.calendar_month_outlined,color: grey3,),

                    ),
                    hintText:
                'شهر / سنة'),
              ),
            ),
            SizedBox(width: 8,),
            Expanded(
              child: Container(

                child: AppTextField(
                    backgroundColor: grey,
                    borderColor: grey,
                    prefixIcon: Padding(

                      padding: const EdgeInsets.all(15.0),
                      child: SvgPicture.asset(lockIcon,width: 16,height: 16,),

                    ),
                    hintText:
                'رمز التحقق'),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Transform.scale(
              scale: 0.69, // increase or decrease the size
              child: Switch(
                value: true,
                onChanged: (value) {
                  // setState(() {
                  //   _isSwitched = value;
                  // });
                },
                activeColor: Colors.white,
                activeTrackColor: darkPurple,
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: Colors.purple,
              ),
            ),
            Text(
              'احتفظ بهذه البطاقة',
              style: text50012
            ),

          ],
        ),
        InkWell(
          onTap: (){
            executeDirectPayment();
          },
          child: Container(
            height: 70,
            width: 100,
            child: Text('test'),
          ),
        )

      ],
    );
  }
}


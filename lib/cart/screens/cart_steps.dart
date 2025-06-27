import 'package:afran/cart/controllers/cart_controller.dart';
import 'package:afran/cart/screens/empty_cart.dart';
import 'package:afran/cart/screens/first_cart_screen.dart';
import 'package:afran/cart/screens/second_cart_screen.dart';
import 'package:afran/cart/screens/third_cart_screen.dart';
import 'package:afran/cart/widgets/dash_line.dart';
import 'package:afran/cart/widgets/mada_pay.dart';
import 'package:afran/constant/app_colors.dart';
import 'package:afran/constant/main_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartStepper extends StatefulWidget {
  final String? notes;
  const CartStepper({super.key, this.notes});

  @override
  State<CartStepper> createState() => _CartStepperState();
}

class _CartStepperState extends State<CartStepper> {
  final PageController _pageController = PageController();

  CartController cartController = Get.put(CartController());
  int _currentStep = 0;

  final List<String> steps = ['الطلب', 'البيانات', 'الدفع'];

  void _onStepTapped(int index) {
    setState(() {
      _currentStep = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  Widget buildStepper() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(steps.length * 2 - 1, (index) {
          if (index.isEven) {
            int stepIndex = index ~/ 2;
            bool isActive = _currentStep == stepIndex;
            return GestureDetector(
              // onTap: () => _onStepTapped(stepIndex),
              child: Column(

                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isActive ? darkPurple : grey,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${stepIndex + 1}',
                      style: TextStyle(
                        color: isActive ? Colors.white : grey3,
                      ),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    steps[stepIndex],
                    style: TextStyle(
                      color: isActive ? darkPurple : Colors.black54,
                      fontWeight:
                      isActive ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Expanded(
              child: Container(
                height: 48,
                child: Center(
                  child: DashedLine(
                    height: 1.5,
                    color: grey3,
                    dashWidth: 4,
                    dashSpacing: 2,
                  ),
                ),
              ),

            );
          }
        }),
      ),
    );
  }

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      cartController.getCart();
      setState(() {

      });
    });
  }
  @override
  Widget build(BuildContext context) {
    // cartController.getCart();
    cartController.notes = widget.notes??'';

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: MainAppBar(title: 'السلة'),
        body:
        Obx((){

          return  cartController.loading.value?

          Center(
            child: Container(
                height: 30,width: 30,
                child: CircularProgressIndicator(color: darkPurple,strokeWidth: 1.5,)),
          ):
          cartController.cartItems.value.items!.isEmpty?
          EmptyCart():
          // PaymentScreen():
          Column(
            children: [
              const SizedBox(height: 16),
              buildStepper(),
              const SizedBox(height: 24),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: steps.length,
                  onPageChanged: (index) {
                    setState(() => _currentStep = index);
                  },
                  itemBuilder: (context, index) {
                     return
                      _currentStep == 0?  FirstCartScreen(onPressed:(){
                        setState(() => _currentStep = 1,);
                      },
                        // cartModel: cartController.cartItems.value,
                        cartController: cartController ,):_currentStep == 1?SecondCartScreen(onPressed: () async{
                         if(cartController.deliveryWay ==''){
                           const snackBar = SnackBar(

                          backgroundColor: Colors.red,
                          content: Text('يرجى إختيار طريقة التوصيل أولا',textAlign: TextAlign.end,));
                           ScaffoldMessenger.of(context).showSnackBar(snackBar);

                         }else if(cartController.selectedDate == ''){
                            const snackBar = SnackBar(

                          backgroundColor: Colors.red,
                          content: Text('يرجى إختيار موعد التوصيل أولا',textAlign: TextAlign.end,));
                           ScaffoldMessenger.of(context).showSnackBar(snackBar);
                         }else{
                            bool success = await  cartController.orderProduct(context);
                         if(success){
                           setState(() => _currentStep = 2);
                         }

                         }


                      }, cartController: cartController,):ThirdCartScreen(onPressed: (){},);

                  },
                ),
              ),
            ],
          );

        }),

      ),
    );
  }
}

import 'package:afran/cart/controllers/cart_controller.dart';
import 'package:afran/constant/app_colors.dart';
import 'package:afran/constant/app_text_style.dart';
import 'package:afran/products/controllers/product_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class ChooseDateWidget extends StatelessWidget {
  final CartController? cartController;
  final ProductDetailsController? productDetailsController;
  const ChooseDateWidget({super.key,  this.cartController,this.productDetailsController});


  @override
  Widget build(BuildContext context) {
    Future<void> pickDateTime() async {
      // Pick Date
      DateTime? selectedDateTime;

      DateTime? date = await showDatePicker(
        context: context,
        // initialDate: DateTime.now(),
        firstDate:  DateTime.now(),
        lastDate: DateTime(2026),
        selectableDayPredicate: (DateTime date) {
          // Allow only weekdays (Mon-Fri)
          return date.weekday >= 1 && date.weekday <= 5;
        },
      );

      if (date == null) return;

      final DateFormat _formatter = DateFormat('yyyy-MM-dd');
      // _formatter.format(date);

      // Pick Time
      TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (time == null) return;

      print(time);

      // setState(() {
      selectedDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
      print('hhhhhhhhhhhhhh${selectedDateTime.toString()}');
      // cartController?.selectedDate = selectedDateTime.toString();
      DateTime dateTime = DateTime.parse(selectedDateTime.toString());
      cartController?.selectedDate  = DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
      initializeDateFormatting('ar', null);

      // Format the weekday, day, month, and year in Arabic
      final String weekday = DateFormat.EEEE('ar').format(date); // الخميس
      final String day = DateFormat.d('ar').format(date);         // ١٧
      final String month = DateFormat.MMMM('ar').format(date);    // أبريل
      final String year = DateFormat.y('ar').format(date);        // ٢٠٢٥
      // final String hour = DateFormat.;        // ٢٠٢٥

      const westernToArabicDigits = {
        '0': '٠',
        '1': '١',
        '2': '٢',
        '3': '٣',
        '4': '٤',
        '5': '٥',
        '6': '٦',
        '7': '٧',
        '8': '٨',
        '9': '٩',
      };

      String arabicYear =  year.split('').map((e) => westernToArabicDigits[e] ?? e).join();
      String arabicDay =  day.split('').map((e) => westernToArabicDigits[e] ?? e).join();
      String arabicHour =  time.hourOfPeriod.toString().split('').map((e) => westernToArabicDigits[e] ?? e).join();
      String arabicMinute =  time.minute.toString().split('').map((e) => westernToArabicDigits[e] ?? e).join();
      String arabicPeriod =  time.period.name.split('').map((e) => westernToArabicDigits[e] ?? e).join() == "am"? 'ص':'م';
      String arabicTime = '${arabicHour}:${arabicMinute}${arabicPeriod}';
      print("يوم $weekday، $arabicDay $month $arabicYear,$arabicTime");

      String selectedDateTimeString ="يوم $weekday، $arabicDay $month $arabicYear"+" ، "+' $arabicTime';
      if(cartController != null){
        cartController?.dateDetails.value = selectedDateTimeString;

      }else{
        productDetailsController?.dateDetails.value = selectedDateTimeString;
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("اختر موعد التوصيل",style: text70016.copyWith(color: darkGrey),),
        SizedBox(height: 16,),
        Row(
          children: [
            SizedBox(
              height: 48,width: 48,
              child: DecoratedBox(decoration: BoxDecoration(
                  color: grey,
                  shape: BoxShape.circle
              ),child: Icon(Icons.calendar_month_outlined,color: darkPurple,),),

            ),
            SizedBox(width: 16,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx((){
                  return Text(
                      cartController != null ?
                      cartController!.dateDetails.value:productDetailsController!.dateDetails.value,
                      style: text50014);
                }),
                InkWell(
                    onTap: pickDateTime,
                    child: Text("تغيير",style: text50014.copyWith(color: darkPurple,decoration: TextDecoration.underline))),

              ],
            )

          ],
        ),
      ],
    );
  }

}

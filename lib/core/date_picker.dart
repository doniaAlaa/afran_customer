// import 'package:flutter/material.dart';
//
//
// class pickDate{
//  DateTime? _selectedDate;
//   Future<void> _pickDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(), // current date
//       firstDate: DateTime(2000),   // earliest date
//       lastDate: DateTime(2100),    // latest date
//       locale: const Locale('ar'), // optional: for Arabic
//     );
//
//     if (picked != null && picked != _selectedDate)
//       setState(() {
//         _selectedDate = picked;
//       });
//   }
//
// }
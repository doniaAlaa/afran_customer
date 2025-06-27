import 'package:afran/cart/controllers/cart_controller.dart';
import 'package:afran/cart/screens/cart_steps.dart';
import 'package:afran/categories/screens/categories_screen.dart';
import 'package:afran/constant/app_images.dart';
import 'package:afran/entity/user_model.dart';
import 'package:afran/home/screens/home_screen.dart';
import 'package:afran/my_oreders/screens/my_orders_screen.dart';
import 'package:afran/profile/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';



class AppBottomNavBar extends StatefulWidget {
  final UserModel? userModel;
  AppBottomNavBar({this.userModel});
  @override
  _AppBottomNavBarState createState() => _AppBottomNavBarState();
}

class _AppBottomNavBarState extends State<AppBottomNavBar> {
  int _selectedIndex = 4;


  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> _items = [
      {'icon': userCircle, 'label': 'حسابي','page':ProfileScreen()},
      {'icon': dark_order, 'label': 'طلباتي','page':MyOrdersScreen()},
      {'icon': store, 'label': 'التصنيفات','page':CategoriesScreen()},
      {'icon': cart, 'label': 'السلة','page':CartStepper()},
      {'icon': home, 'label': 'الرئيسية','page':HomeScreen(userModel: widget.userModel,)},
    ];

    return Scaffold(
      body: _items[_selectedIndex]['page'],
      bottomNavigationBar: Container(
        height: 76,
        decoration: BoxDecoration(
          // border: Border(top: BorderSide(color: Colors.purple.shade100)),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(_items.length, (index) {
            final item = _items[index];
            final isSelected = _selectedIndex == index;

            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                  Get.delete<CartController>();
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(_items[index]['icon']),
                  SizedBox(height: 4),
                  Text(
                    item['label'],
                    style: TextStyle(
                      color: isSelected ? Colors.purple : Colors.grey,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}


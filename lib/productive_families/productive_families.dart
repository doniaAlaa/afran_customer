import 'package:flutter/material.dart';

class ProductiveFamilies extends StatelessWidget {
  const ProductiveFamilies({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:ListView.builder(
          shrinkWrap: true,
          itemCount: 20,
          itemBuilder: (context,index){
        return Text('data');
      })
    );
  }

}

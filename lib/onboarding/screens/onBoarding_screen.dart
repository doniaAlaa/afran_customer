import 'package:afran/login/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingPage extends StatefulWidget {
  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  PageController _controller = PageController();
  int _currentIndex = 0;

  List<Map<String, String>> onboardingData = [

    {
      "image": "assets/images/app_order.svg",
      "title": "أهلاً بك في أفران",
      "desc": "منصة تواصل الأسر المنتجة معكم\nاكتشفوا منتجات منزلية طازجة مصنوعة بعناية",
    },
    {
      "image": "assets/images/delivery.svg",
      "title": "توصيل سريع وآمن",
      "desc": "اختر طريقة الاستلام المفضلة: توصيل لباب\nالمنزل أو استلام من أقرب نقطة لك",
    },
    {
      "image": "assets/images/chef.svg",
      "title": "أسر منتجة إبداع بلا حدود",
      "desc": "استمتع بمنتجات طازجة وحصرية مصنوعة بحب\nوتفخر من الأسر المنتجة",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // Important for Arabic
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: onboardingData.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          SvgPicture.asset(
                            onboardingData[index]["image"]!,
                            height: 300,
                          ),
                          SizedBox(height: 30),
                          Text(
                            onboardingData[index]["title"]!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            onboardingData[index]["desc"]!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  onboardingData.length,
                      (index) => buildDot(index: index),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_currentIndex == onboardingData.length - 1) {
                        // Navigator.pushReplacementNamed(context, '/home');
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  LoginPage()),
                        );

                      } else {
                        _controller.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFB46EB4), // your purple color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      "ابدأ الآن",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDot({required int index}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 5),
      width: _currentIndex == index ? 20 : 10,
      height: 10,
      decoration: BoxDecoration(
        color: _currentIndex == index ? Color(0xFFB46EB4) : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}

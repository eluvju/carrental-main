import 'package:car_rental/flutter/flutter_util.dart';
import 'package:car_rental/pages/login_page/login_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';


import 'constant.dart';


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  Widget _buildPageContent(
      {required String image, required String title, required String description, required String svg}) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          child: Image.asset(
            image,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF000000).withOpacity(0.0), // Start with transparent black
                Color(0xFF000000).withOpacity(1.0), // End with solid black
              ],
              stops: [0.0, 1.0],
            ),
          ),
        ),
        Positioned(
          bottom: 120,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.raleway(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.w700 // Ensure the text is visible over the gradient
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  description,
                  style: GoogleFonts.raleway(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w400 // Ensure the text is visible over the gradient
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 80,
          left: 50,
          right: 50,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SvgPicture.asset(
              svg,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            children: [
              _buildPageContent(
                image: 'assets/images/splash_1-min.jpg',
                title: "Self-Drive cars\nwhere you need them",
                description: "Cars within walking distance of your home\nor office, delivered to your doorstep.",
                svg: 'assets/images/first.svg',
              ),
              _buildPageContent(
                image: 'assets/images/splash_2-min.jpg',
                title: "Hatchback, SUV,\nSedan or Luxury",
                description: "Date night or long drive trip to the hills,\nwe have a car for everything",
                svg: 'assets/images/second.svg',
              ),
              _buildPageContent(
                image: 'assets/images/Splash_3-min.jpg',
                title: "Choose your\ndesired destination",
                description: "Whether you are driving far in a short period of\ntime, or near over a longer period, we have the\nright price-package for you",
                svg: 'assets/images/third.svg',
              ),
              // Add more pages as needed
            ],
          ),
          Positioned(
            bottom: 20,
            left: 16,
            right: 16,
            child: ElevatedButton(
              onPressed: () {
                if (_currentPage < 2) {
                  _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeIn);
                } else {
                  Helper.moveToScreenwithPush(context, LoginPageWidget());
                  // context.pushNamed(
                  //   'HomePage',
                  //   extra: <String, dynamic>{
                  //     kTransitionInfoKey:
                  //     TransitionInfo(
                  //       hasTransition: true,
                  //       transitionType:
                  //       PageTransitionType.fade,
                  //       duration: Duration(
                  //           milliseconds: 0),
                  //     ),
                  //   },
                  // );
                  // Navigate to another screen or perform any action when the last page is reached
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF553FA5), // Button background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Border radius
                ),
                padding: EdgeInsets.symmetric(vertical: 16.0), // Padding inside the button
              ),
              child: Text(
                _currentPage == 2 ? 'Get Started' : 'Next',
                style: GoogleFonts.raleway(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w400 // Ensure the text is visible over the gradient
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }

  Widget buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: 10,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == index ? Colors.red : Colors.grey,
      ),
    );
  }
}

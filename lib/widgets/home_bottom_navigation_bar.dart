import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/constants/app_colors.dart';
import 'package:weather_app/constants/app_images.dart';
import 'package:weather_app/custom/navbar_clipper.dart';
import 'package:weather_app/helpers/responsive_helper.dart';
import 'package:weather_app/models/weather_models.dart';
import 'package:weather_app/screens/second_screen.dart';

class HomeBottomNavigationBar extends StatelessWidget {
  final WeatherData? weather;
  const HomeBottomNavigationBar({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: ClipPath(
        clipper: NavBarClipper(),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              height: Responsive.heightPercentage(context, 0.12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                border: Border.all(color: Colors.white.withOpacity(0.2)),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.widthPercentage(context, 0.06),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      debugPrint("Menu button tapped!");
                    },
                    child: Image.asset(
                      AppImages.menuIcon,
                      width: Responsive.dimension(
                        context,
                        mobile: 40,
                        tablet: 45,
                        desktop: 50,
                      ),
                      height: Responsive.dimension(
                        context,
                        mobile: 35,
                        tablet: 40,
                        desktop: 45,
                      ),
                      fit: BoxFit.contain,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      debugPrint("Add button tapped!");
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.navBarCenterColor,
                        shape: BoxShape.circle,
                      ),
                      padding: EdgeInsets.all(
                        Responsive.dimension(
                          context,
                          mobile: 12,
                          tablet: 14,
                          desktop: 16,
                        ),
                      ),
                      child: Icon(
                        Icons.add,
                        size: Responsive.dimension(
                          context,
                          mobile: 32,
                          tablet: 36,
                          desktop: 40,
                        ),
                        color: Colors.black,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      debugPrint("List button tapped!");
                      if (weather != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SecondScreen(weather: weather!),
                          ),
                        );
                      } else {
                        debugPrint("Weather data not loaded yet!");
                      }
                    },
                    child: Image.asset(
                      AppImages.listIcon,
                      width: Responsive.dimension(
                        context,
                        mobile: 40,
                        tablet: 45,
                        desktop: 50,
                      ),
                      height: Responsive.dimension(
                        context,
                        mobile: 50,
                        tablet: 55,
                        desktop: 60,
                      ),
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

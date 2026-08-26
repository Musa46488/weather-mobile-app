import 'dart:ui';

import 'package:flutter/material.dart';
import '../constants/app_icons.dart';
import '../constants/app_colors.dart';
import '../helpers/clipper_helper.dart';
import '../helpers/responsive_helper.dart';
import '../models/weather_model.dart';
import '../view/second_view.dart';

class HomeBottomNavigationBar extends StatelessWidget {
  final WeatherModel? weather;
  const HomeBottomNavigationBar({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: ClipPath(
        clipper: ClipperHelper(),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              height: ResponsiveHelper.heightPercentage(context, 0.12),
              decoration: BoxDecoration(
                color: AppColors.whiteColor.withValues(alpha: 0.15),
                border: Border.all(
                  color: AppColors.whiteColor.withValues(alpha: 0.2),
                ),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveHelper.widthPercentage(context, 0.06),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      debugPrint("Menu button tapped!");
                    },
                    child: Image.asset(
                      AppIcons.menuIcon,
                      width: ResponsiveHelper.dimension(
                        context,
                        mobile: 40,
                        tablet: 45,
                        desktop: 50,
                      ),
                      height: ResponsiveHelper.dimension(
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
                        color: AppColors.redColor,
                        shape: BoxShape.circle,
                      ),
                      padding: EdgeInsets.all(
                        ResponsiveHelper.dimension(
                          context,
                          mobile: 12,
                          tablet: 14,
                          desktop: 16,
                        ),
                      ),
                      child: Icon(
                        Icons.add,
                        size: ResponsiveHelper.dimension(
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
                      if (weather == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Weather data is still loading."),
                          ),
                        );
                        return;
                      }

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => SecondScreen()),
                      );
                    },
                    child: Image.asset(
                      AppIcons.listIcon,
                      width: ResponsiveHelper.dimension(
                        context,
                        mobile: 40,
                        tablet: 45,
                        desktop: 50,
                      ),
                      height: ResponsiveHelper.dimension(
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

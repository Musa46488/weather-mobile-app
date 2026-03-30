import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/constants/app_images.dart';
import 'package:weather_app/controllers/weather_controller.dart';

import 'package:weather_app/widgets/bottom_panel.dart';
import 'package:weather_app/widgets/home_bottom_navigation_bar.dart';
import 'package:weather_app/widgets/home_custom_scrollview.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = Provider.of<WeatherController>(context, listen: false);
      if (controller.weather == null) {
        controller.loadWeather(null, context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<WeatherController>(context);
    final weather = controller.weather;
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  AppImages.backgroundImage,
                  fit: BoxFit.cover,
                ),
              ),

              SafeArea(
                child: RefreshIndicator(
                  onRefresh: () => controller.loadWeather(null, context),
                  child: HomeCustomScrollView(controller: controller),
                ),
              ),

              BottomPanel(weather: weather),

              // Bottom Navigation Bar
              HomeBottomNavigationBar(weather: weather),
            ],
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:weather_app/constants/app_colors.dart';
import 'package:weather_app/helpers/responsive_helper.dart';

class CityDropdown extends StatelessWidget {
  final String selectedCity;
  final Function(String) onSelected;

  CityDropdown({
    super.key,
    required this.selectedCity,
    required this.onSelected,
  });

  final Map<String, List<String>> countryCityMap = {
    'Pakistan': ['Lahore', 'Karachi', 'Islamabad', 'Peshawar', 'Gujranwala'],
    'USA': ['New York', 'Los Angeles', 'San Antonio', 'Dallas', 'Houston'],
  };

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) async {
        // Step 1: Show country list
        final selectedCountry = await showMenu<String>(
          context: context,
          position: RelativeRect.fromLTRB(
            details.globalPosition.dx,
            details.globalPosition.dy,
            details.globalPosition.dx,
            details.globalPosition.dy,
          ),
          items: countryCityMap.keys.map((country) {
            return PopupMenuItem<String>(
              value: country,
              child: Text(country, style: const TextStyle(color: Colors.white)),
            );
          }).toList(),
          color: AppColors.handleBarColor,
        );

        // Step 2: Show city list for selected country
        if (selectedCountry != null) {
          final selectedCity = await showMenu<String>(
            context: context,
            position: RelativeRect.fromLTRB(
              details.globalPosition.dx,
              details.globalPosition.dy + 50,
              details.globalPosition.dx,
              details.globalPosition.dy,
            ),
            items: countryCityMap[selectedCountry]!.map((city) {
              return PopupMenuItem<String>(
                value: city,
                child: Text(
                  city,
                  style: TextStyle(
                    color: AppColors.whiteTextColor,
                    fontSize: Responsive.fontSize(
                      context,
                      mobile: 14,
                      tablet: 16,
                      desktop: 18,
                    ),
                  ),
                ),
              );
            }).toList(),
            color: AppColors.handleBarColor,
          );

          // Step 3: Call callback to notify parent of selection
          if (selectedCity != null) {
            onSelected(selectedCity);
          }
        }
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            selectedCity,
            style: TextStyle(
              color: AppColors.whiteTextColor,
              fontSize: Responsive.fontSize(
                context,
                mobile: 28,
                tablet: 32,
                desktop: 36,
              ),
            ),
          ),
          const Icon(Icons.arrow_drop_down, color: Colors.white),
        ],
      ),
    );
  }
}

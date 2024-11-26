import 'package:flutter/material.dart';


class ChartDataProvider with ChangeNotifier {
   List<double> ChartValues = [46.6, 37.6, 8.2, 5.2, 1.3, 0.8, 0.3, 0.1];
  
    List<Color> Chartcolors = [
      const Color(0xFF0E3D66),
      const Color(0xFF43C478),
      const Color(0xFF3D8DF5),
      const Color(0xFF08548A),
      const Color(0xFF7681FC),
      const Color(0xFF8BD3F7),
      const Color(0xFF075E45),
      const Color(0xFFF7B7E2),
    ];
    
    List<String> Chartlabels = [
      'Cash & Equivalents',
      'Domestic Equities',
      'To Be Classified',
      'Fixed Income',
      'International Equities',
      'Real Estate Securities',
      'Alternative Investments',
      'Unclassified'
    ];
}

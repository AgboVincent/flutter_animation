
import 'package:flutter/material.dart';
import 'package:flutter_animation/view/screens/home.dart';

import '../../view/screens/search.dart';




var customRoutes = <String, WidgetBuilder>{
 // '/pages': (context) => const PagesScreen(),
  '/home': (context) => const AnimatedPage(),
  '/search': (context) => const SearchScrean(),
};

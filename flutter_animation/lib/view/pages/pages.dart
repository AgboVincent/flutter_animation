import 'package:flutter/material.dart';
import 'package:flutter_animation/controller/app_controller.dart';
import 'package:flutter_animation/view/screens/home.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../widgets/bottom_nav.dart';
import '../screens/search.dart';


class PagesScreen extends ConsumerStatefulWidget {
  const PagesScreen({super.key});

  @override
  ConsumerState<PagesScreen> createState() => _PagesScreenState();
}

class _PagesScreenState extends ConsumerState<PagesScreen>   with SingleTickerProviderStateMixin{
  final navigationBarKey = GlobalKey();
  int selectedIndex = 0;

  late AnimatedPage homeScreen;
  late SearchScrean searchScreen;
  late List<Widget> pages;
  late Widget currentPage;

  @override
  void initState() {
    homeScreen = const AnimatedPage();
    searchScreen = const SearchScrean();
    pages = [
      searchScreen,
      Container(),
      homeScreen,
      Container(),
      Container(),
    ];
    currentPage = const AnimatedPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          currentPage,
          if(ref.watch(bottomNavProvider) == true)
          Positioned(
           bottom: 10,
           right: 50,
           left: 50,
           child: SlidingFabWithItems( onIconClicked: (index){
              setState(() {
                currentPage = pages[index];
                selectedIndex = index;
              });
           })
         ) 
        ],
      ),
    );
  }
}

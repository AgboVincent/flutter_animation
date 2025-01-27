import 'package:flutter/material.dart';
import 'package:flutter_animation/core/resources/icons.dart';
import 'package:flutter_animation/core/resources/images.dart';
import 'package:flutter_animation/core/resources/strings.dart';
import 'package:flutter_animation/view/widgets/c_textform_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class SearchScrean extends StatefulWidget {
  const SearchScrean({super.key});

  @override
  State<SearchScrean> createState() => _SearchScreanState();
}

class _SearchScreanState extends State<SearchScrean> with TickerProviderStateMixin {
   bool _isPopupOpen = false;
  late AnimationController _controller;
  late AnimationController _inputcontroller;
  late Animation<double> _scaleAnimation;
   Offset _popupPosition = Offset.zero;
   late Animation<double> _widthAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _inputcontroller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _scaleAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    _widthAnimation = Tween<double>(begin: 150, end: 310).animate(
      CurvedAnimation(parent: _inputcontroller, curve: Curves.easeInOut),
    );

     _inputcontroller.forward();
  }

  void _togglePopup(GlobalKey buttonKey) {
    if (_isPopupOpen) {
      _controller.reverse();
    } else {
      final renderBox =
          buttonKey.currentContext!.findRenderObject() as RenderBox;
      final position = renderBox.localToGlobal(Offset.zero);

      setState(() {
        _popupPosition = Offset(position.dx, position.dy - renderBox.size.height-100);
      });
      _controller.forward();
    }

    setState(() {
      _isPopupOpen = !_isPopupOpen;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _inputcontroller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
     final fab1Key = GlobalKey();
    final fab2Key = GlobalKey();
    return Scaffold(
      body: Container(
         height: double.infinity,
         width: double.infinity,
        decoration: const BoxDecoration(
         image: DecorationImage(
          image: AssetImage(AppImages.mapImage),
          fit: BoxFit.cover
          )
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedBuilder(
                      animation: _widthAnimation,
                      builder: (context, child){
                        return SizedBox(
                        width: _widthAnimation.value,
                        child: const CTextFormField(
                          hintText: AppStrings.title,
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(left: 20, right: 10),
                            child: Icon(Icons.search, size: 26),
                          )
                        ),
                      );
                      },
                    ),
                    Gap(20.w),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        AppIcons.filterIcon1, 
                        height: 10,
                        width: 10,  
                        fit: BoxFit.scaleDown,
                        ),
                      )
                  ],
                ),
              ),
             if (_isPopupOpen)
            Positioned(
              left: _popupPosition.dx,
              top: _popupPosition.dy,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    width: 200,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        Text(
                          "Copy areas",
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Price",
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Infrastructure",
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Without parent",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 100.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FloatingActionButton(
              key: fab1Key,
              heroTag: 'fab1',
              onPressed: () => _togglePopup(fab1Key),
              backgroundColor: Colors.grey,
              child: const Icon(Icons.menu),
            ),
            const SizedBox(height: 16),
            FloatingActionButton(
              key: fab2Key,
              heroTag: 'fab2',
              onPressed: () {
          
              },
              backgroundColor: Colors.grey,
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
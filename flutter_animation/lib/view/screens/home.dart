import 'package:flutter/material.dart';
import 'package:flutter_animation/core/resources/images.dart';
import 'package:flutter_animation/core/resources/strings.dart';
import 'package:flutter_animation/view/screens/apartments.dart';
import 'package:flutter_animation/view/screens/bottom_nav.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AnimatedPage extends StatefulWidget {
  const AnimatedPage({super.key}); 

  @override
  State<AnimatedPage> createState() => _AnimatedPageState();
}

class _AnimatedPageState extends State<AnimatedPage> with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  int maxNumber1 = 1034;
  int maxNumber2 = 2212;
  bool showHorizontalLayout = false;
  int currentNumber1 = 0;
  int currentNumber2 = 0;

  double maxContainer1 = 100.0;
  double maxContainer2 = 100.0;

  double _containerWidth = 0.0; 
  bool _showText = false;
  bool _showGreetings = false;
  bool _showCounter = false;
  bool _showApartment = false;
  bool _showFab = false;

  final List<String> _lines = [
    AppStrings.description1,
    AppStrings.description2,
  ];

  final List<String> _visibleLines = [];

  void _scrollToTop() {
    _scrollController.animateTo(
      0.0,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
    Future.delayed(const Duration(milliseconds: 1700), () {
        setState(() {
          _showFab = true;
        });
      });
  }


Future<void> _animateLines() async {
    for (var line in _lines) {
      await Future.delayed(const Duration(milliseconds: 150), () {
        setState(() {
          _visibleLines.add(line);
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _containerWidth = 200.0; 
      });

      Future.delayed(const Duration(milliseconds: 800), () {
        setState(() {
          _showText = true;
        });
      });

       Future.delayed(const Duration(milliseconds: 1000), () {
        setState(() {
          _showGreetings = true;
          _animateLines();
        });

         Future.delayed(const Duration(milliseconds: 700), () {
        setState(() {
        _showCounter = true;
        });
      });
      
    });

      Future.delayed(const Duration(seconds: 1), () {
      for (int i = 0; i <= maxNumber1; i++) {
        Future.delayed(Duration(microseconds: i * 900), () {
          setState(() {
            currentNumber1 = i;
          });
        });
      }
      for (int i = 0; i <= maxNumber2; i++) {
        Future.delayed(Duration(microseconds: i * 800), () {
          setState(() {
            currentNumber2 = i;
            if(currentNumber2 == maxNumber2) {
              _showApartment = true;
              Future.delayed(const Duration(seconds: 1), () {
                _scrollToBottom();
            });
            }
          });
        });
      }
    });
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [ Colors.white, Color.fromARGB(255, 185, 181, 172),],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0, bottom:20),
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 20.0),
                   child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 800),
                          padding: const EdgeInsets.all(10),
                          width: _containerWidth,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 500),
                            opacity: _showText ? 1.0 : 0.0,
                            child:  Center(
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    color: Color.fromARGB(255, 158, 146, 118),
                                  ),
                                  Gap(6.w),
                                  Text(
                                    AppStrings.title,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: const Color.fromARGB(255, 185, 181, 172),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        TweenAnimationBuilder(
                        tween: Tween<double>(begin: 0.2, end: 1.0),
                        curve: Curves.easeOut,
                        duration: const  Duration(milliseconds: 800),
                        builder: (context, size, child) {
                          return Transform.scale(
                            scale: size,
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage(AppImages.profileImage),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      ],
                    ),
                 ),
                  Gap(20.h),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity: _showGreetings ? 1.0 : 0.0,
                      child:  Text(
                        AppStrings.greeting,
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w500,
                         color: const Color.fromARGB(255, 185, 181, 172),
                        ),
                      ),
                    ),
                  ),
                  Gap(4.h),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(_visibleLines.length, (index){
                        return AnimatedTextLine(
                          text: _visibleLines[index],
                        );
                      }),
                    ),
                  ),
                  if (_showCounter)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TweenAnimationBuilder(
                          tween: Tween<double>(begin: 0.1, end: 1.0),
                          curve: Curves.easeOut,
                          duration: const Duration(milliseconds: 800),
                          builder: (context, value, child) {
                            return Expanded(
                              child: Transform.scale(
                                scale: value,
                                child: BoxWithCounter(
                                  count: currentNumber1, 
                                  size: value,
                                  shape: BoxShape.circle,
                                  color: const Color.fromARGB(255, 241, 183, 48),
                                  ),
                                ),
                            );
                          },
                        ),
                        const SizedBox(width: 20),
                        TweenAnimationBuilder(
                          tween: Tween<double>(begin: 0.1, end: 1.0),
                          curve: Curves.easeOut,
                          duration: const Duration(milliseconds: 800),
                          builder: (context, value, child) {
                            return Expanded(
                              child: Transform.scale(
                                scale: value,
                                child: SizedBox(
                                  height: 200,
                                  child: BoxWithCounter(
                                    count: currentNumber2, 
                                    size: value,
                                    shape: BoxShape.rectangle,
                                    color: Colors.white,
                                    ),
                                ),
                                ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  if (_showApartment)
                  const AnimatedBoxLayout(),
                  if(_showFab)
                  const SlidingFabWithItems()
                  
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class BoxWithCounter extends StatelessWidget {
  final int? count;
  final double? size;
  final BoxShape shape;
  final Color? color;

  const BoxWithCounter({
    required this.count,
    required this.size, 
    required this.shape,
    required this.color,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 150.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        borderRadius: shape == BoxShape.circle ? 
        null: BorderRadius.circular(30),
        shape: shape
      ),
      child: Column(
        children: [
          Gap(20.h),
           Text(
            shape == BoxShape.circle ? AppStrings.buy: AppStrings.rent,
            style: TextStyle(
              fontSize: 12.sp, 
              fontWeight: FontWeight.w600,
              color: shape == BoxShape.circle ? 
              Colors.white : const Color.fromARGB(255, 137, 122, 90),
            ),
          ),
          Gap(20.h),
          Center(
            child: Text(
              '$count',
              style: TextStyle(
                fontSize: 30.sp, 
                fontWeight: FontWeight.w600,
                color: shape == BoxShape.circle ? 
                Colors.white : const Color.fromARGB(255, 137, 122, 90),
              ),
            ),
          ),
          Gap(4.h),
           Text(
            AppStrings.offers,
            style: TextStyle(
              fontSize: 12.sp, 
              fontWeight: FontWeight.w600,
              color: shape == BoxShape.circle ? 
              Colors.white : const Color.fromARGB(255, 137, 122, 90),
            ),
          ),
        ],
      ),
    );
  }
}


class AnimatedTextLine extends StatefulWidget {
  final String text;

  const AnimatedTextLine({super.key, required this.text});

  @override
  State<AnimatedTextLine> createState() => _AnimatedTextLineState();
}

class _AnimatedTextLineState extends State<AnimatedTextLine>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _positionAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _positionAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: const Offset(0, 0), 
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacityAnimation,
      child: SlideTransition(
        position: _positionAnimation,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.0),
          child: Text(
            widget.text,
            style: TextStyle(
              fontSize: 28.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}


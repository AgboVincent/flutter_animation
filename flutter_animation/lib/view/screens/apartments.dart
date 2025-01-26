import 'package:flutter/material.dart';
import 'package:flutter_animation/core/resources/images.dart';
import 'package:flutter_animation/core/resources/strings.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AnimatedBoxLayout extends StatefulWidget {
  const AnimatedBoxLayout({super.key});
  @override
  State<AnimatedBoxLayout> createState() => _AnimatedBoxLayoutState();
}

class _AnimatedBoxLayoutState extends State<AnimatedBoxLayout>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  double _containerWidthOne = 0.0; 
  double _containerWidthTwo = 0.0;
  double _containerWidthThree = 0.0;
  double _containerWidthFour = 0.0;

  bool _showText1 = false; 
  bool _showText2 = false;
  bool _showText3 = false;
  bool _showText4 = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _animation = Tween<Offset>(
      begin: const Offset(0, 1), 
      end: const Offset(0, 0),   
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward();

     Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _containerWidthOne = 375.w;  
      });

      Future.delayed(const Duration(milliseconds: 800), () {
        setState(() {
          _showText1 = true;
        });
      });

       Future.delayed(const Duration(milliseconds: 1000), () {
        setState(() {
          _containerWidthTwo = 170.w; 
        });

         Future.delayed(const Duration(milliseconds: 700), () {
        setState(() {
        _showText2 = true;
        });
      });

        Future.delayed(const Duration(milliseconds: 800), () {
        setState(() {
          _containerWidthThree = 170.w; 
        });
      });

        Future.delayed(const Duration(milliseconds: 700), () {
        setState(() {
        _showText3 = true;
        });
      });

      Future.delayed(const Duration(milliseconds: 800), () {
        setState(() {
          _containerWidthFour = 170.w; 
        });
      });

        Future.delayed(const Duration(milliseconds: 700), () {
        setState(() {
        _showText4 = true;
        });
      });
      
      });
     });

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
       Stack(
        children: [
          Center(
            child: SlideTransition(
              position: _animation,
              child: Container(
                 padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[200],
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.black.withOpacity(0.1),
                  //     blurRadius: 10,
                  //     spreadRadius: 5,
                  //   ),
                  // ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 140.h,
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            image: DecorationImage(
                              image: AssetImage(AppImages.image1),
                              fit: BoxFit.cover,
                            ),
                          )
                        ),
                        Positioned(
                          bottom: 20,
                          left: 10,
                          child: animatedContainer(
                              title: AppStrings.locationOne, 
                              textAlign: TextAlign.center,
                              showText: _showText1, 
                              containerWidth: _containerWidthOne
                           ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              Container(
                                height: 280.h,
                                margin: const EdgeInsets.only(bottom: 20),
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                  image: DecorationImage(
                                    image: AssetImage(AppImages.image2),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 20,
                                left: 10,
                                child: animatedContainer(
                                  title: AppStrings.locationTwo, 
                                  showText: _showText2, 
                                  containerWidth: _containerWidthTwo
                                ),
                              ),
                            ],
                          ),
                        ),
                        Gap(10.w),
                        Expanded(
                          child: Column(
                            children: [
                             Stack(
                               children: [
                                 Container(
                                    height: 140.h,
                                    margin: const EdgeInsets.only(bottom: 10),
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(15)),
                                      image: DecorationImage(
                                        image: AssetImage(AppImages.image3),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                   ),
                                  Positioned(
                                    bottom: 20,
                                    left: 10,
                                    child: animatedContainer(
                                      title: AppStrings.locationThree, 
                                      showText: _showText3, 
                                      containerWidth: _containerWidthThree
                                    ),
                                  ),
                               ],
                             ),
                              Stack(
                                children: [
                                  Container(
                                    height: 140.h,
                                    margin: const EdgeInsets.only(bottom: 20),
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(15)),
                                      image: DecorationImage(
                                        image: AssetImage(AppImages.image4),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 20,
                                    left: 10,
                                    child: animatedContainer(
                                      title: AppStrings.locationFour, 
                                      showText: _showText4, 
                                      containerWidth: _containerWidthFour
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
  }
  Widget animatedContainer({required String title, required bool showText, required double containerWidth, TextAlign? textAlign}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 800),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      margin: const EdgeInsets.only(right: 8),
      width: containerWidth,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          trailing: Container(
            padding: const EdgeInsets.all(0),
            height: 40,
            width: 40,
            decoration: const  BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle
            ),
            child: const Icon(
              Icons.arrow_forward_ios,
              color: Color.fromARGB(255, 158, 146, 118),
            ),
          ),
          title: AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            opacity: showText ? 1.0 : 0.0,
            child:  Text(
              title,
              textAlign: textAlign ?? TextAlign.start,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: const Color.fromARGB(255, 185, 181, 172),
               ),
              ),
          ),
        ),
      ),
    );
  }
}

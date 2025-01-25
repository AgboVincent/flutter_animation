import 'package:flutter/material.dart';
import 'package:flutter_animation/view/screens/apartments.dart';
import 'package:flutter_animation/view/screens/bottom_nav.dart';

class AnimatedPage extends StatefulWidget {
  const AnimatedPage({super.key}); 

  @override
  State<AnimatedPage> createState() => _AnimatedPageState();
}

class _AnimatedPageState extends State<AnimatedPage> with SingleTickerProviderStateMixin {

  int maxNumber1 = 100;
  int maxNumber2 = 200;
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
    "Welcome to the Flutter App!",
    "Enjoy the seamless animations and features."
  ];

  final List<String> _visibleLines = [];


Future<void> _animateLines() async {
    for (var line in _lines) {
      await Future.delayed(const Duration(microseconds: 1000), () {
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
        _containerWidth = 200.0; // Target width for the container
      });

      // Delay for the text to fade in after the container finishes expanding
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

         Future.delayed(const Duration(milliseconds: 300), () {
        setState(() {
        _showCounter = true;
        });
      });
      
    });

      Future.delayed(const Duration(seconds: 1), () {
      for (int i = 0; i <= maxNumber1; i++) {
        Future.delayed(Duration(milliseconds: i * 10), () {
          setState(() {
            currentNumber1 = i;
          });
        });
      }
      for (int i = 0; i <= maxNumber2; i++) {
        Future.delayed(Duration(milliseconds: i * 8), () {
          setState(() {
            currentNumber2 = i;
            if(currentNumber2 == maxNumber2) {
              _showApartment = true;
            }
            Future.delayed(const Duration(seconds: 3), () {
          setState(() {
            _showFab = true;
          });
        });
          });
        });
      }
    });

    
    });

    // Start number animatio

    // Show horizontal layout
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 800),
                      height: 40,
                      width: _containerWidth,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 500),
                        opacity: _showText ? 1.0 : 0.0,
                        child: const  Center(
                          child: Text(
                            'Animated Title',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
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
                            color: Colors.blue,
                          ),
                        ),
                      );
                    },
                  ),
                  ],
                ),
                const SizedBox(height: 60),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: _showGreetings ? 1.0 : 0.0,
                  child: const Text(
                    'Hi, Marina',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                     // color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: _visibleLines.length,
                    itemBuilder: (context, index) {
                      return AnimatedTextLine(
                        text: _visibleLines[index],
                      );
                    },
                  ),
                ),
          
                const SizedBox(height: 20),
                if (_showCounter)
                Row(
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
                              shape: BoxShape.circle
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
                                shape: BoxShape.rectangle
                                ),
                            ),
                            ),
                        );
                      },
                    ),
                  ],
                ),
                if (_showApartment)
                AnimatedBoxLayout(),
                if(_showFab)
                SlidingFabWithItems()
                
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: CustomFabLocation() ,
    );
  }
}

class CustomFabLocation extends FloatingActionButtonLocation {
  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final double fabX = (scaffoldGeometry.scaffoldSize.width - scaffoldGeometry.floatingActionButtonSize.width) / 2;
    final double fabY = scaffoldGeometry.scaffoldSize.height - scaffoldGeometry.floatingActionButtonSize.height - 450;
    return Offset(fabX, fabY);
  }
}


class BoxWithCounter extends StatelessWidget {
  final int? count;
  final double? size;
  final BoxShape shape;

  const BoxWithCounter({
    required this.count,
    required this.size, 
    required this.shape,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 300,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: shape == BoxShape.circle ? null: BorderRadius.circular(10),
        shape: shape
      ),
      child: Text(
        '$count',
        style: const TextStyle(
          fontSize: 32, 
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}


class AnimatedTextLine extends StatefulWidget {
  final String text;

  const AnimatedTextLine({super.key, required this.text});

  @override
  _AnimatedTextLineState createState() => _AnimatedTextLineState();
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
      duration: Duration(milliseconds: 600),
    );

    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _positionAnimation = Tween<Offset>(
      begin: Offset(0, 1), // Start from below
      end: Offset(0, 0),   // Move to its final position
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
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            widget.text,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}


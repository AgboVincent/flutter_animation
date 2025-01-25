import 'package:flutter/material.dart';

class AnimatedBoxLayout extends StatefulWidget {
  @override
  _AnimatedBoxLayoutState createState() => _AnimatedBoxLayoutState();
}

class _AnimatedBoxLayoutState extends State<AnimatedBoxLayout>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );

    // Define the offset animation to slide the widget up from the bottom
    _animation = Tween<Offset>(
      begin: Offset(0, 1), // Start below the screen
      end: Offset(0, 0),   // Final position
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    // Start the animation
    _controller.forward();
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // First row with a single large box
                  Container(
                    width: 200,
                    height: 100,
                    color: Colors.blue,
                    margin: EdgeInsets.only(bottom: 20),
                    child: Center(
                      child: Text(
                        "Box 1",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),

                  // Second row with vertical and horizontal boxes
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left vertical box
                      Container(
                        width: 80,
                        height: 160,
                        color: Colors.green,
                        margin: EdgeInsets.only(right: 10),
                        child: Center(
                          child: Text(
                            "Box 2",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),

                      // Right horizontal boxes
                      Column(
                        children: [
                          Container(
                            width: 120,
                            height: 70,
                            color: Colors.orange,
                            margin: EdgeInsets.only(bottom: 10),
                            child: Center(
                              child: Text(
                                "Box 3",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ),
                          Container(
                            width: 120,
                            height: 70,
                            color: Colors.red,
                            child: Center(
                              child: Text(
                                "Box 4",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
    );
  }
}

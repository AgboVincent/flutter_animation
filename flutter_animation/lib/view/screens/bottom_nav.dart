import 'package:flutter/material.dart';

class SlidingFabWithItems extends StatefulWidget {
  @override
  _SlidingFabWithItemsState createState() => _SlidingFabWithItemsState();
}

class _SlidingFabWithItemsState extends State<SlidingFabWithItems>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  bool _isFabExpanded = false;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );

    // Define the slide animation for the FAB and items
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 1), // Start from below the screen
      end: Offset(0, -1),   // End near the bottom
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    // Start the slide animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleFab() {
    setState(() {
      _isFabExpanded = !_isFabExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return
       SlideTransition(
         position: _slideAnimation,
         child: Align(
           alignment: Alignment.bottomCenter,
           child: TextButton(
             onPressed: (){
               print("Button 1 pressed");
             },
             child: Container(
               color: Colors.redAccent,
               child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: [
                       GestureDetector(
                         onTap: () {
                           print("Button 1 pressed");
                         },
             
                         child: const  Icon( Icons.add)),
             
                                   Icon(_isFabExpanded ? Icons.close : Icons.add),
                                               Icon(_isFabExpanded ? Icons.close : Icons.add),
                                                           Icon(_isFabExpanded ? Icons.close : Icons.add),
                     ],
                   ),
             
             ),
           ),
            ),
       );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../core/resources/icons.dart';

class SlidingFabWithItems extends StatefulWidget {
  const SlidingFabWithItems({
    this.onIconClicked,
    super.key
  });
  final Function(int val)? onIconClicked;  
  @override
  State<SlidingFabWithItems>createState() => _SlidingFabWithItemsState();
}

class _SlidingFabWithItemsState extends State<SlidingFabWithItems>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  int selectedNavIndex = 2;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1), 
      end: const Offset(0, -0.5),  
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

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
       SlideTransition(
         position: _slideAnimation,
         child: Align(
           alignment: Alignment.bottomCenter,
           child: Container(
            width: 300.w,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
             decoration: BoxDecoration(
               color: Colors.black87,
               borderRadius: BorderRadius.circular(30),
             ),
             child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  bottomNavItems.length, (index) {
                    return GestureDetector(
                      onTap: (){
                        setState(() {
                          selectedNavIndex = index;
                        });
                        widget.onIconClicked!(selectedNavIndex);
                      },
                      child: NavItems(
                        icon: bottomNavItems[index].icon,
                        color: bottomNavItems[index].color,
                        isSelected: selectedNavIndex == index,
                      ),
                    );
                  },
              ),
             ),
          ),
         )
       );
   }
}

class NavItems extends StatelessWidget {
  final String icon;
  final Color color;
  final bool? isSelected;

  const NavItems({
    required this.icon,
    required this.color,
    this.isSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: isSelected! ? const Color.fromARGB(255, 241, 183, 48) : Colors.transparent,
        shape: BoxShape.circle,
      ),
      child: SvgPicture.asset(
        icon,
        height: 10,
        width: 10,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        fit: BoxFit.scaleDown,
      ),
    );
  }
}
List<NavItems> bottomNavItems =  [
  const NavItems(
    icon: AppIcons.searchIcon,
    color: Colors.white,
  ),
  const NavItems(
    icon: AppIcons.messageIcon,
    color: Colors.white,
  ),
  const NavItems(
    icon:  AppIcons.homeIcon,
    color: Colors.white,
  ),
  const NavItems(
    icon:  AppIcons.likeIcon,
    color: Colors.white,
  ),
  const NavItems(
    icon: AppIcons.profileIcon,
    color: Colors.white,
  ),
  ];



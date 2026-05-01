import 'package:market_mate/screens/explore_screen.dart';
import 'package:market_mate/screens/home_screen.dart';
import 'package:market_mate/screens/liked_screen.dart';
import 'package:market_mate/screens/message_screen.dart';
import 'package:flutter/material.dart';


class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex; // ✅ active tab index (0=home,1=explore,2=liked,3=message)
  final bool isDarkMode;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: isDarkMode ? Colors.black : Colors.white,
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavIcon(
              context,
              index: 0,
              icon: Icons.home,
              screen: const HomeScreen(),
            ),
            _buildNavIcon(
              context,
              index: 1,
              icon: Icons.explore,
              screen: const ExploreScreen(),
            ),
            const SizedBox(width: 40),
            _buildNavIcon(
              context,
              index: 2,
              icon: Icons.favorite,
              screen: const LikedScreen(),
            ),
            _buildNavIcon(
              context,
              index: 3,
              icon: Icons.message,
              screen: const MessageScreen(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavIcon(BuildContext context,
      {required int index, required IconData icon, required Widget screen}) {
    return IconButton(
      icon: Icon(
        icon,
        color: currentIndex == index
            ? const Color(0xFFFF5A5F) // Active
            : (isDarkMode ? Colors.white : Colors.grey), // Inactive
      ),
      onPressed: () {
        if (currentIndex != index) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => screen),
          );
        }
      },
    );
  }
}
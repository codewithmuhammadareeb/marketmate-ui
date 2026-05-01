import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_mate/screens/login_screen.dart';
import 'package:market_mate/screens/splash_screen.dart';
import 'package:market_mate/screens/home_screen.dart';
import 'package:market_mate/screens/explore_screen.dart';
import 'package:market_mate/screens/listing_screen.dart';
import 'package:market_mate/screens/order_screen.dart';
import 'package:market_mate/screens/liked_screen.dart';
import 'package:market_mate/screens/profile_screen.dart';
import 'package:market_mate/theme/theme_controller.dart';

void main() {
  Get.put(ThemeController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    
    return Obx(() => GetMaterialApp(
      title: 'ReBuy App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        primaryColor: const Color(0xFFFF5A5F),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: const Color(0xFFFF5A5F),
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: const Color(0xFFFF5A5F),
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.grey[900],
          selectedItemColor: const Color(0xFFFF5A5F),
          unselectedItemColor: Colors.grey[400],
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      themeMode: themeController.isDark.value ? ThemeMode.dark : ThemeMode.light,
      home: const SplashScreen(),
      // Add routes for all screens
      getPages: [
        GetPage(name: '/', page: () => const SplashScreen()),
        GetPage(name: '/login', page: () => const LoginsingupScreen()),
        GetPage(name: '/main', page: () => const MainAppScreen()),
        GetPage(name: '/home', page: () => const HomeScreen()),
        GetPage(name: '/explore', page: () => const ExploreScreen()),
        GetPage(name: '/listings', page: () => const MyListingsScreen()),
        GetPage(name: '/orders', page: () => const MyOrdersScreen()),
        GetPage(name: '/liked', page: () => const LikedScreen()),
        GetPage(name: '/profile', page: () => const ProfileScreen()),
      ],
    ));
  }
}

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key});

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  int _selectedIndex = 0;
  final ThemeController _themeController = Get.find();

  // Screens list for bottom navigation
  final List<Widget> _screens = [
    const HomeScreen(),
    const ExploreScreen(),
    const MyListingsScreen(),
    const MyOrdersScreen(),
    const LikedScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Bottom navigation bar items
  final List<BottomNavigationBarItem> _bottomNavItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      activeIcon: Icon(Icons.home),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.search_outlined),
      activeIcon: Icon(Icons.search),
      label: 'Explore',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.sell_outlined),
      activeIcon: Icon(Icons.sell),
      label: 'Listings',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.shopping_bag_outlined),
      activeIcon: Icon(Icons.shopping_bag),
      label: 'Orders',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.favorite_outline),
      activeIcon: Icon(Icons.favorite),
      label: 'Liked',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person_outline),
      activeIcon: Icon(Icons.person),
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = _themeController.isDark.value;

    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomNavItems,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
        selectedItemColor: const Color(0xFFFF5A5F),
        unselectedItemColor: isDarkMode ? Colors.grey[400] : Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        elevation: 8,
      ),
      floatingActionButton: (_selectedIndex == 0 || _selectedIndex == 1) 
          ? FloatingActionButton(
              backgroundColor: const Color(0xFFFF5A5F),
              child: const Icon(Icons.camera_alt, color: Colors.white),
              onPressed: () {
                // Add camera functionality
                _showCameraOptions(context, isDarkMode);
              },
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _showCameraOptions(BuildContext context, bool isDark) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: isDark ? Colors.grey[900] : Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Add Product",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                ListTile(
                  leading: Icon(
                    Icons.camera_alt,
                    color: const Color(0xFFFF5A5F),
                  ),
                  title: Text(
                    "Take Photo",
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    "Capture product photo using camera",
                    style: TextStyle(
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    // Open camera
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.photo_library,
                    color: const Color(0xFFFF5A5F),
                  ),
                  title: Text(
                    "Choose from Gallery",
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    "Select photo from your gallery",
                    style: TextStyle(
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    // Open gallery
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // Navigate to add listing screen
                    Get.to(() => const MyListingsScreen());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF5A5F),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Add Listing",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }
}
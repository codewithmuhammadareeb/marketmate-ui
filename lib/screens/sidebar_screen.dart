import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_mate/screens/listing_screen.dart';
import 'package:market_mate/screens/login_screen.dart';
import 'package:market_mate/screens/profile_screen.dart';
import 'package:market_mate/screens/order_screen.dart';
import 'package:market_mate/screens/liked_screen.dart';
import 'package:market_mate/theme/theme_controller.dart';

class SidebarScreen extends StatelessWidget {
  final ThemeController themeController = Get.find<ThemeController>();
  final RxBool _isLoggingOut = false.obs;
  
  SidebarScreen({super.key});

  void _performLogout() {
    _isLoggingOut.value = true;
    
  
    // 3 seconds delay
    Future.delayed(const Duration(seconds: 3), () {
      _isLoggingOut.value = false;
      Get.offAll(() => const LoginsingupScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Obx(() {
          final isDarkMode = themeController.isDark.value;
          final backgroundColor = isDarkMode ? Colors.grey[900] : Colors.white;
          final textColor = isDarkMode ? Colors.white : Colors.black;
          final tileColor = isDarkMode ? (Colors.grey[800] ?? Colors.grey) : const Color(0xFFE8F4F8);

          return Scaffold(
            backgroundColor: backgroundColor,
            body: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.only(bottom: 20, top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "ReBuy",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.close, color: textColor),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),

                // Theme Toggle Switch with GetX
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: tileColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            isDarkMode ? Icons.nightlight_round : Icons.wb_sunny,
                            color: textColor,
                            size: 24,
                          ),
                          const SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Theme",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),
                              Text(
                                isDarkMode ? "Dark Mode" : "Light Mode",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Switch(
                        value: isDarkMode,
                        onChanged: (value) {
                          themeController.toggleTheme();
                          _showThemeChangeSnackbar(value);
                        },
                        activeColor: const Color(0xFFFF5A5F),
                        inactiveThumbColor: Colors.grey[400],
                        inactiveTrackColor: Colors.grey[300],
                      ),
                    ],
                  ),
                ),

                // Sidebar Options with GetX Navigation
                _buildSidebarButton(
                  context: context,
                  icon: Icons.person,
                  title: "My Account",
                  subtitle: "Edit your details, account settings",
                  onTap: () {
                    Navigator.pop(context); // Close sidebar
                    Get.to(() => const ProfileScreen());
                  },
                  tileColor: tileColor,
                  textColor: textColor,
                ),
                _buildSidebarButton(
                  context: context,
                  icon: Icons.shopping_bag,
                  title: "My Orders",
                  subtitle: "View all your orders",
                  onTap: () {
                    Navigator.pop(context); // Close sidebar
                    Get.to(() => const MyOrdersScreen());
                  },
                  tileColor: tileColor,
                  textColor: textColor,
                ),
                _buildSidebarButton(
                  context: context,
                  icon: Icons.sell,
                  title: "My Listings",
                  subtitle: "View your products listing for sale",
                  onTap: () {
                    Navigator.pop(context); // Close sidebar
                    Get.to(() => const MyListingsScreen());
                  },
                  tileColor: tileColor,
                  textColor: textColor,
                ),
                _buildSidebarButton(
                  context: context,
                  icon: Icons.favorite,
                  title: "Liked Items",
                  subtitle: "See the products you have wishlisted",
                  onTap: () {
                    Navigator.pop(context); // Close sidebar
                    Get.to(() => const LikedScreen());
                  },
                  tileColor: tileColor,
                  textColor: textColor,
                ),

                // Additional Options
                _buildSidebarButton(
                  context: context,
                  icon: Icons.settings,
                  title: "Settings",
                  subtitle: "App settings and preferences",
                  onTap: () {
                    Navigator.pop(context);
                    _showSettingsDialog(context, isDarkMode);
                  },
                  tileColor: tileColor,
                  textColor: textColor,
                ),
                _buildSidebarButton(
                  context: context,
                  icon: Icons.help_outline,
                  title: "Help & Support",
                  subtitle: "FAQ, Contact us, Privacy Policy",
                  onTap: () {
                    Navigator.pop(context);
                    _showHelpDialog(context, isDarkMode);
                  },
                  tileColor: tileColor,
                  textColor: textColor,
                ),

                const SizedBox(height: 25),

                // Feedback + Sign out
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _showFeedbackDialog(context, isDarkMode);
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: textColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding:
                            const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                      child: Text(
                        "Feedback",
                        style: TextStyle(color: textColor, fontSize: 14),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _performLogout,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF5A5F),
                        padding:
                            const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Sign out",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // Footer
                Center(
                  child: Column(
                    children: [
                      Container(
                        height: 60,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFF5A5F),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(60),
                            topRight: Radius.circular(60),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "ReBuy Inc. Version 1.0",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "© 2024 All rights reserved",
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
        
        // Instagram-style Logout Overlay
        Obx(() => _isLoggingOut.value
            ? Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.85),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Instagram-style Loading
                        Container(
                          width: 80,
                          height: 80,
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: SweepGradient(
                              colors: [
                                Colors.white.withOpacity(0.3),
                                const Color(0xFFFF5A5F),
                                Colors.white.withOpacity(0.3),
                              ],
                              stops: const [0.0, 0.5, 1.0],
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black.withOpacity(0.85),
                            ),
                            child: Center(
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFFFF5A5F),
                                ),
                                child: const Icon(
                                  Icons.shopping_bag,
                                  color: Colors.white,
                                  size: 28,
                                ),
                              ),
                            ),
                          ),
                        ),
                        
                        const SizedBox(height: 30),
                        
                        // Animated Text
                        TweenAnimationBuilder<double>(
                          duration: const Duration(milliseconds: 1800),
                          tween: Tween(begin: 0.0, end: 1.0),
                          builder: (context, value, child) {
                            return Opacity(
                              opacity: value,
                              child: Transform.translate(
                                offset: Offset(0.0, 10.0 * (1 - value)),
                                child: child,
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              const Text(
                                "Logging out",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Please wait...",
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink(),
        ),
      ],
    );
  }

  void _showThemeChangeSnackbar(bool isDark) {
    Get.snackbar(
      isDark ? 'Dark Mode' : 'Light Mode',
      isDark ? 'Theme switched to dark mode' : 'Theme switched to light mode',
      backgroundColor: const Color(0xFFFF5A5F),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
      borderRadius: 10,
      margin: const EdgeInsets.all(10),
      icon: Icon(
        isDark ? Icons.nightlight_round : Icons.wb_sunny,
        color: Colors.white,
      ),
    );
  }

  Widget _buildSidebarButton({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required Color tileColor,
    required Color textColor,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        onTap: onTap,
        tileColor: tileColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        leading: Icon(icon, color: textColor),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(fontSize: 12, color: Colors.grey[700]),
        ),
      ),
    );
  }

  void _showSettingsDialog(BuildContext context, bool isDark) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: isDark ? Colors.grey[900] : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'Settings',
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView(
              shrinkWrap: true,
              children: [
                ListTile(
                  leading: Icon(
                    Icons.notifications,
                    color: const Color(0xFFFF5A5F),
                  ),
                  title: Text(
                    'Notifications',
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  trailing: Switch(
                    value: true,
                    onChanged: (value) {},
                    activeColor: const Color(0xFFFF5A5F),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.language,
                    color: const Color(0xFFFF5A5F),
                  ),
                  title: Text(
                    'Language',
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  subtitle: const Text('English'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(
                    Icons.security,
                    color: const Color(0xFFFF5A5F),
                  ),
                  title: Text(
                    'Privacy & Security',
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Close',
                style: TextStyle(color: Color(0xFFFF5A5F)),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showHelpDialog(BuildContext context, bool isDark) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: isDark ? Colors.grey[900] : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'Help & Support',
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    Icons.help_outline,
                    color: const Color(0xFFFF5A5F),
                  ),
                  title: Text(
                    'FAQ',
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    Icons.email,
                    color: const Color(0xFFFF5A5F),
                  ),
                  title: Text(
                    'Contact Us',
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  subtitle: const Text('support@rebuy.com'),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    Icons.privacy_tip,
                    color: const Color(0xFFFF5A5F),
                  ),
                  title: Text(
                    'Privacy Policy',
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    Icons.description,
                    color: const Color(0xFFFF5A5F),
                  ),
                  title: Text(
                    'Terms of Service',
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Close',
                style: TextStyle(color: Color(0xFFFF5A5F)),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showFeedbackDialog(BuildContext context, bool isDark) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: isDark ? Colors.grey[900] : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'Feedback',
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Share your feedback...',
                  hintStyle: TextStyle(
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: isDark ? Colors.grey[800] : Colors.grey[100],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [1, 2, 3, 4, 5].map((star) {
                  return IconButton(
                    icon: Icon(
                      Icons.star,
                      color: star <= 4 ? const Color(0xFFFF5A5F) : Colors.grey,
                    ),
                    onPressed: () {},
                  );
                }).toList(),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Get.snackbar(
                  'Thank You!',
                  'Your feedback has been submitted.',
                  backgroundColor: const Color(0xFFFF5A5F),
                  colorText: Colors.white,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF5A5F),
              ),
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }
}
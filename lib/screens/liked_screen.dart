import 'package:flutter/material.dart';
import 'package:get/get.dart'; // ✅ ADDED
import 'package:market_mate/screens/sidebar_screen.dart';
import 'package:market_mate/theme/theme_controller.dart'; // ✅ ADDED
import '../custom_bottom_navbar.dart';

class LikedScreen extends StatefulWidget {
  const LikedScreen({super.key});

  @override
  State<LikedScreen> createState() => _LikedScreenState();
}

class _LikedScreenState extends State<LikedScreen> {
  // ✅ Sidebar open function
  void _showSidebar(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.9,
          minChildSize: 0.6,
          maxChildSize: 0.95,
          builder: (_, controller) {
            final ThemeController themeController = Get.find<ThemeController>();
            return Container(
              decoration: BoxDecoration(
                color: themeController.isDark.value
                    ? Colors.grey[900]
                    : Colors.white,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(25)),
              ),
              child: SidebarScreen(),
            );
          },
        );
      },
    );
  }

  // ✅ FIXED IMAGE PATHS ONLY
  final List<Map<String, String>> likedProducts = [
    {
      "title": "Apple AirPods Pro",
      "date": "21 Jan 2021",
      "price": "8,999",
      "image": "assets/images/airpods.jpg",
    },
    {
      "title": "JBL Charge 2 Speaker",
      "date": "20 Dec 2020",
      "price": "6,499",
      "image": "assets/images/speaker.jpg",
    },
    {
      "title": "PlayStation Controller",
      "date": "14 Nov 2020",
      "price": "1,299",
      "image": "assets/images/controller.jpg",
    },
    {
      "title": "Nexus Mountain Bike",
      "date": "05 Oct 2020",
      "price": "9,900",
      "image": "assets/images/bike.jpg",
    },
    {
      "title": "WildCraft Ranger Tent",
      "date": "30 Sep 2020",
      "price": "999",
      "image": "assets/images/tent.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();
    final bool isDarkMode = themeController.isDark.value;
    final bgColor = isDarkMode ? Colors.black : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        title: Text(
          "Liked Items",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.menu, color: textColor),
            onPressed: () => _showSidebar(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
          itemCount: likedProducts.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final product = likedProducts[index];
            return ProductListCard(
              title: product["title"]!,
              date: product["date"]!,
              price: product["price"]!,
              image: product["image"]!,
              isDarkMode: isDarkMode,
            );
          },
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 2,
        isDarkMode: isDarkMode,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFFF5A5F),
        child: const Icon(Icons.camera_alt, color: Colors.white),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

// ✅ Product List Card Widget
class ProductListCard extends StatelessWidget {
  final String title;
  final String date;
  final String price;
  final String image;
  final bool isDarkMode;

  const ProductListCard({
    super.key,
    required this.title,
    required this.date,
    required this.price,
    required this.image,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[900] : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDarkMode ? 0.2 : 0.15),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: isDarkMode ? Colors.transparent : Colors.grey[300]!,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              image,
              height: 70,
              width: 70,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 70,
                  width: 70,
                  color:
                      isDarkMode ? Colors.grey[800] : Colors.grey[300],
                  child: Icon(
                    Icons.image,
                    size: 30,
                    color: isDarkMode
                        ? Colors.grey[400]
                        : Colors.grey[600],
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color:
                        isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 12,
                    color: isDarkMode
                        ? Colors.grey[400]
                        : Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "₹$price",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFF5A5F),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon:
                const Icon(Icons.favorite, color: Color(0xFFFF5A5F)),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}

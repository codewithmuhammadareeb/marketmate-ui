import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_mate/screens/profile_screen.dart';
import 'package:market_mate/screens/sidebar_screen.dart';
import 'package:market_mate/theme/theme_controller.dart';
import 'package:market_mate/widgets/category_chip.dart';
import '../custom_bottom_navbar.dart';
import 'product_detail_screen.dart';
import '../models/product_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                color: themeController.isDark.value ? Colors.grey[900] : Colors.white,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(25),
                ),
              ),
              child: SidebarScreen(),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();
    final bool isDark = themeController.isDark.value;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark ? Colors.black : Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()),
            );
          },
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage("assets/images/profile.png"),
                backgroundColor: const Color(0xFFFF5A5F),
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hey Alice",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  Text(
                    "Welcome back!",
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? Colors.grey[300] : Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.menu,
              color: isDark ? Colors.white : Colors.black,
            ),
            onPressed: () => _showSidebar(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[900] : Colors.grey[100],
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: isDark ? Colors.transparent : Colors.grey[300]!,
                    width: 1,
                  ),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search for books, gadgets and more...',
                    hintStyle: TextStyle(
                      color: isDark ? Colors.grey[500] : Colors.grey[600],
                    ),
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search, 
                      color: isDark ? Colors.grey[500] : Colors.grey[600],
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  ),
                ),
              ),
              const SizedBox(height: 25),

              // New Arrivals
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "New Arrivals",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      "View more",
                      style: TextStyle(
                        color: Color(0xFFFF5A5F),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 220, // Increased height
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    HomeProductCard(
                      title: "Bluetooth Speaker",
                      price: "1,500",
                      image: "assets/images/bluetooth_speaker.png",
                      isDark: isDark,
                      rating: 4.5,
                    ),
                    HomeProductCard(
                      title: "Casual Sneakers",
                      price: "2,200",
                      image: "assets/images/casual_sneakers.png",
                      isDark: isDark,
                      rating: 4.2,
                    ),
                    HomeProductCard(
                      title: "Smart Watch",
                      price: "3,500",
                      image: "assets/images/smart_watch.png",
                      isDark: isDark,
                      rating: 4.8,
                    ),
                    HomeProductCard(
                      title: "Novel: Atomic Habits",
                      price: "500",
                      image: "assets/images/atomic_habits_book.png",
                      isDark: isDark,
                      rating: 4.7,
                    ),
                    HomeProductCard(
                      title: "Headphones",
                      price: "1,800",
                      image: "assets/images/headphones.png",
                      isDark: isDark,
                      rating: 4.4,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Categories Section
              Text(
                "Categories",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 12),
              
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CategoryChip(text: "Electronics"),
                    CategoryChip(text: "Fashion"),
                    CategoryChip(text: "Books"),
                    CategoryChip(text: "Home"),
                    CategoryChip(text: "Sports"),
                    CategoryChip(text: "Toys"),
                    CategoryChip(text: "Gadgets"),
                    CategoryChip(text: "Beauty"),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Featured Items - FIXED
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Featured Items",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      "View more",
                      style: TextStyle(
                        color: Color(0xFFFF5A5F),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              
              // Remove SizedBox and use GridView directly with shrinkWrap
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 0.75, // Adjusted ratio
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  HomeGridProduct(
                    title: 'Gaming Laptop',
                    price: '120,000',
                    image: 'assets/images/gaming_laptop.png',
                    isDark: isDark,
                    rating: 4.9,
                  ),
                  HomeGridProduct(
                    title: 'Sports Shoes',
                    price: '4,500',
                    image: 'assets/images/sports_shoes.png',
                    isDark: isDark,
                    rating: 4.3,
                  ),
                  HomeGridProduct(
                    title: 'Bluetooth Earbuds',
                    price: '2,800',
                    image: 'assets/images/bluetooth_earbuds.png',
                    isDark: isDark,
                    rating: 4.6,
                  ),
                  HomeGridProduct(
                    title: 'Formal Shirt',
                    price: '1,500',
                    image: 'assets/images/formal_shirt.png',
                    isDark: isDark,
                    rating: 4.4,
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 0,
        isDarkMode: isDark,
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

// Horizontal Product Card - PREMIUM DESIGN
class HomeProductCard extends StatelessWidget {
  final String title;
  final String price;
  final String image;
  final bool isDark;
  final double rating;

  const HomeProductCard({
    super.key,
    required this.title,
    required this.price,
    required this.image,
    required this.isDark,
    this.rating = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final product = Product(
          title: title,
          price: price,
          description: "This is a high-quality $title available at an affordable price with excellent features and durability.",
          image: image,
          brand: "Premium Brand",
          year: "2024",
          warranty: true,
          originalPacking: true,
        );
        
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(product: product),
          ),
        );
      },
      child: Container(
        width: 165,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[900] : Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDark ? 0.2 : 0.1),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image Container
            Container(
              height: 130,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                ),
                color: isDark ? Colors.grey[800] : Colors.grey[100],
              ),
              child: Stack(
                children: [
                  // Main Image
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Image.asset(
                        image,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => Center(
                          child: Icon(
                            Icons.image_not_supported,
                            size: 40,
                            color: isDark ? Colors.grey[600] : Colors.grey[400],
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                  // Rating Badge
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF5A5F).withOpacity(0.9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.white,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            rating.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Product Info
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: isDark ? Colors.white : Colors.black,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 6),
                  
                  // Price and Cart Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "₹$price",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFF5A5F),
                        ),
                      ),
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF5A5F),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.shopping_cart_outlined,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Grid Product Card - PREMIUM DESIGN
class HomeGridProduct extends StatelessWidget {
  final String title;
  final String price;
  final String image;
  final bool isDark;
  final double rating;

  const HomeGridProduct({
    super.key,
    required this.title,
    required this.price,
    required this.image,
    required this.isDark,
    this.rating = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final product = Product(
          title: title,
          price: price,
          description: "High-quality $title with excellent features, durability, and premium finish.",
          image: image,
          brand: "Premium Brand",
          year: "2024",
          warranty: true,
          originalPacking: true,
        );
        
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(product: product),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[900] : Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDark ? 0.2 : 0.1),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image Container
            Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                ),
                color: isDark ? Colors.grey[800] : Colors.grey[100],
              ),
              child: Stack(
                children: [
                  // Main Image
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Image.asset(
                        image,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => Center(
                          child: Icon(
                            Icons.image_not_supported,
                            size: 40,
                            color: isDark ? Colors.grey[600] : Colors.grey[400],
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                  // Favorite Button
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.favorite_border,
                        color: Color(0xFFFF5A5F),
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Product Info
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  
                  // Rating
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: const Color(0xFFFF5A5F),
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        rating.toString(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.grey[400] : Colors.grey[600],
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "(120 reviews)",
                        style: TextStyle(
                          fontSize: 10,
                          color: isDark ? Colors.grey[500] : Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  
                  // Price
                  Text(
                    "₹$price",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFF5A5F),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
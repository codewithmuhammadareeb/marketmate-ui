import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_mate/screens/sidebar_screen.dart';
import 'package:market_mate/theme/theme_controller.dart';
import '../custom_bottom_navbar.dart';
import 'product_detail_screen.dart';
import '../models/product_model.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
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
        title: Text(
          'Explore',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.menu, color: isDark ? Colors.white : Colors.black),
            onPressed: () => _showSidebar(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
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
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 16),
                          Icon(
                            Icons.search,
                            color: isDark ? Colors.grey[500] : Colors.grey[600],
                            size: 22,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search for electronics, clothes and more...',
                                hintStyle: TextStyle(
                                  color: isDark ? Colors.grey[500] : Colors.grey[600],
                                  fontSize: 14,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Container(
                            width: 40,
                            height: 40,
                            margin: const EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFF5A5F),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.tune,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),

                    // Categories
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
                          ExploreCategoryChip(
                            text: "Books",
                            icon: Icons.menu_book,
                          ),
                          ExploreCategoryChip(
                            text: "Clothes",
                            icon: Icons.checkroom,
                          ),
                          ExploreCategoryChip(
                            text: "Shoes",
                            icon: Icons.shopping_bag,
                          ),
                          ExploreCategoryChip(
                            text: "Mobiles",
                            icon: Icons.phone_iphone,
                          ),
                          ExploreCategoryChip(
                            text: "Electronics",
                            icon: Icons.electrical_services,
                          ),
                          ExploreCategoryChip(
                            text: "Sports",
                            icon: Icons.sports_basketball,
                          ),
                          ExploreCategoryChip(
                            text: "Home",
                            icon: Icons.home,
                          ),
                          ExploreCategoryChip(
                            text: "Beauty",
                            icon: Icons.spa,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),

                    // Featured Items
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
                          child: Row(
                            children: [
                              Text(
                                "View all",
                                style: TextStyle(
                                  color: const Color(0xFFFF5A5F),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Icon(
                                Icons.arrow_forward,
                                color: const Color(0xFFFF5A5F),
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    
                    // GridView - Removed the LayoutBuilder and fixed height calculation
                    GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: 0.7, // Adjusted aspect ratio for better fit
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        ProductCard(
                          title: 'Gaming Laptop',
                          description: '16GB RAM | RTX 4060 | 1TB SSD',
                          price: '120,000',
                          imagePath: 'assets/images/gaming_laptop.png',
                          isDark: isDark,
                          rating: 4.9,
                          reviews: 245,
                        ),
                        ProductCard(
                          title: 'Sports Shoes',
                          description: 'Running Shoes | Air Cushion',
                          price: '4,500',
                          imagePath: 'assets/images/sports_shoes.png',
                          isDark: isDark,
                          rating: 4.3,
                          reviews: 128,
                        ),
                        ProductCard(
                          title: 'Bluetooth Earbuds',
                          description: 'Noise Cancellation | 30hrs Battery',
                          price: '2,800',
                          imagePath: 'assets/images/bluetooth_earbuds.png',
                          isDark: isDark,
                          rating: 4.6,
                          reviews: 189,
                        ),
                        ProductCard(
                          title: 'Formal Shirt',
                          description: 'Slim Fit | Premium Cotton',
                          price: '1,500',
                          imagePath: 'assets/images/formal_shirt.png',
                          isDark: isDark,
                          rating: 4.4,
                          reviews: 76,
                        ),
                        ProductCard(
                          title: 'Smart Watch',
                          description: 'Heart Rate | GPS | Waterproof',
                          price: '8,500',
                          imagePath: 'assets/images/smart_watch.png',
                          isDark: isDark,
                          rating: 4.7,
                          reviews: 312,
                        ),
                        ProductCard(
                          title: 'Wireless Headphones',
                          description: 'Over-ear | Studio Quality',
                          price: '6,200',
                          imagePath: 'assets/images/headphones.png',
                          isDark: isDark,
                          rating: 4.5,
                          reviews: 167,
                        ),
                      ],
                    ),
                    const SizedBox(height: 30), // Added bottom padding
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 1,
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

// ExploreCategoryChip with Icon
class ExploreCategoryChip extends StatelessWidget {
  final String text;
  final IconData icon;
  
  const ExploreCategoryChip({
    super.key,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFFF5A5F),
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: const Color(0xFFFF5A5F),
            size: 18,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              color: Color(0xFFFF5A5F),
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

// PRODUCT CARD - PREMIUM DESIGN
class ProductCard extends StatelessWidget {
  final String title;
  final String description;
  final String price;
  final String imagePath;
  final bool isDark;
  final double rating;
  final int reviews;

  const ProductCard({
    super.key,
    required this.title,
    required this.description,
    required this.price,
    required this.imagePath,
    required this.isDark,
    this.rating = 4.0,
    this.reviews = 100,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final product = Product(
          title: title,
          price: price,
          description: description,
          image: imagePath,
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
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDark ? 0.2 : 0.08),
              blurRadius: 15,
              offset: const Offset(0, 6),
            ),
          ],
          border: Border.all(
            color: isDark ? Colors.grey[800]! : Colors.grey[100]!,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image with Gradient Overlay
            Stack(
              children: [
                Container(
                  height: 140,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    color: isDark ? Colors.grey[800] : Colors.grey[50],
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Image.asset(
                        imagePath,
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
                ),
                
                // Discount Badge
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFF5A5F), Color(0xFFFF8A9E)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFF5A5F).withOpacity(0.3),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Text(
                      "20% OFF",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                
                // Favorite Button
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: Colors.white,
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
            
            // Product Info
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: isDark ? Colors.white : Colors.black,
                      height: 1.2,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 11,
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  
                  // Rating and Reviews
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF5A5F).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: const Color(0xFFFF5A5F),
                              size: 12,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              rating.toString(),
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFF5A5F),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        "($reviews reviews)",
                        style: TextStyle(
                          fontSize: 10,
                          color: isDark ? Colors.grey[500] : Colors.grey[500],
                        ),
                      ),
                      const Spacer(),
                      
                      // Add to Cart Button
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF5A5F),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  
                  // Price
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
                      Text(
                        "₹${(int.parse(price.replaceAll(',', '')) * 1.25).round()}",
                        style: TextStyle(
                          fontSize: 12,
                          color: isDark ? Colors.grey[500] : Colors.grey[500],
                          decoration: TextDecoration.lineThrough,
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
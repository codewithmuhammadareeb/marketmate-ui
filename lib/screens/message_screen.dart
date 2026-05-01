import 'package:flutter/material.dart';
import 'package:get/get.dart'; // ✅ ADDED
import 'package:market_mate/custom_bottom_navbar.dart';
import 'package:market_mate/screens/sidebar_screen.dart';
import 'package:market_mate/theme/theme_controller.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  bool _isChatOpen = false;
  final TextEditingController _messageController = TextEditingController();

  // ✅ SIDEBAR FUNCTION - Updated with ThemeController
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
            final ThemeController themeController = Get.find<ThemeController>(); // ✅ ADDED
            return Container(
              decoration: BoxDecoration(
                color: themeController.isDark.value ? Colors.grey[900] : Colors.white, // ✅ CHANGED
                borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
              ),
              child:  SidebarScreen(), // ✅ REMOVED parameter
            );
          },
        );
      },
    );
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        _messages.add({
          "text": _messageController.text,
          "isMe": true,
          "time": "Now",
        });
        _messageController.clear();
      });
    }
  }

  final List<Map<String, dynamic>> _messages = [
    {"text": "Hello!", "isMe": false, "time": "10:30 AM"},
    {"text": "Hi, how are you?", "isMe": true, "time": "10:31 AM"},
    {"text": "I'm good, what about you?", "isMe": false, "time": "10:32 AM"},
    {"text": "Doing great! Want to meet tomorrow?", "isMe": true, "time": "10:33 AM"},
    {"text": "Sure, let's meet at 3 PM", "isMe": false, "time": "10:34 AM"},
    {"text": "Perfect! See you then", "isMe": true, "time": "10:35 AM"},
  ];

  final List<Map<String, dynamic>> _chatList = [
    {
      "name": "John Doe",
      "message": "Hey, how are you? Let's catch up soon...",
      "image": "assets/user1.jpg",
      "time": "10:30 AM",
      "unread": 2,
    },
    {
      "name": "Alice",
      "message": "Are you available tomorrow for the meeting?",
      "image": "assets/user2.jpg",
      "time": "Yesterday",
      "unread": 0,
    },
    {
      "name": "Michael",
      "message": "Check out this new product I found!",
      "image": "assets/user3.jpg",
      "time": "2 days ago",
      "unread": 5,
    },
    {
      "name": "Sarah",
      "message": "Thanks for your help with the project",
      "image": "assets/user4.jpg",
      "time": "3 days ago",
      "unread": 0,
    },
    {
      "name": "David",
      "message": "Let's schedule a call next week",
      "image": "assets/user5.jpg",
      "time": "1 week ago",
      "unread": 1,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>(); // ✅ ADDED
    final bool isDark = themeController.isDark.value; // ✅ ADDED
    
    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark ? Colors.black : Colors.white,
        elevation: 0,
        leading: _isChatOpen
            ? IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: isDark ? Colors.white : Colors.black,
                ),
                onPressed: () {
                  setState(() {
                    _isChatOpen = false;
                  });
                },
              )
            : null,
        title: _isChatOpen
            ? Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundImage: AssetImage(
                        _chatList.isNotEmpty ? _chatList[0]["image"] : "assets/user1.jpg"),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    _chatList.isNotEmpty ? _chatList[0]["name"] : "Chat",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              )
            : Text(
                "Messages",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
        centerTitle: true,
        // ✅ ONLY sidebar icon, NO theme toggle in app bar
        actions: [
          if (!_isChatOpen) // ✅ Only show sidebar icon when chat is not open
            IconButton(
              icon: Icon(
                Icons.menu,
                color: isDark ? Colors.white : Colors.black,
              ),
              onPressed: () => _showSidebar(context),
            ),
        ],
      ),
      body: _isChatOpen ? _buildChatView(isDark) : _buildMessagesList(isDark),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 3,
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

  Widget _buildMessagesList(bool isDark) {
    return Padding(
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
                hintText: 'Search messages...',
                hintStyle: TextStyle(
                  color: isDark ? Colors.grey[500] : Colors.grey[600],
                ),
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.search,
                  color: isDark ? Colors.grey[500] : Colors.grey[600],
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              ),
            ),
          ),
          const SizedBox(height: 25),
          Expanded(
            child: ListView.builder(
              itemCount: _chatList.length,
              itemBuilder: (context, index) {
                final chat = _chatList[index];
                return _messageTile(
                  chat["name"],
                  chat["message"],
                  chat["image"],
                  chat["time"],
                  chat["unread"],
                  isDark,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _messageTile(
    String name,
    String message,
    String image,
    String time,
    int unread,
    bool isDark,
  ) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isChatOpen = true;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[900] : Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(
            color: isDark ? Colors.transparent : Colors.grey[200]!,
            width: 1,
          ),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          leading: CircleAvatar(
            radius: 28,
            backgroundImage: AssetImage(image),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              Text(
                time,
                style: TextStyle(
                  fontSize: 12,
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                ),
              ),
            ],
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    message,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: isDark ? Colors.grey[300] : Colors.grey[700],
                      fontSize: 14,
                    ),
                  ),
                ),
                if (unread > 0)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF5A5F),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      unread.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChatView(bool isDark) {
    return Column(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? Colors.black : Colors.white,
            ),
            child: ListView.builder(
              reverse: false,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _chatBubble(
                  message["text"],
                  message["isMe"],
                  message["time"],
                  isDark,
                );
              },
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isDark ? Colors.grey[900] : Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.attach_file,
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                ),
                onPressed: () {},
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey[800] : Colors.grey[100],
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      controller: _messageController,
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                      ),
                      decoration: InputDecoration(
                        hintText: "Type a message...",
                        hintStyle: TextStyle(
                          color: isDark ? Colors.grey[400] : Colors.grey[600],
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: Icon(
                  Icons.emoji_emotions,
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                ),
                onPressed: () {},
              ),
              const SizedBox(width: 8),
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF5A5F), Color(0xFFC1839F)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: IconButton(
                  icon: const Icon(Icons.send, color: Colors.white, size: 22),
                  onPressed: _sendMessage,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _chatBubble(String text, bool isMe, String time, bool isDark) {
    return Column(
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (!isMe)
                CircleAvatar(
                  radius: 16,
                  backgroundImage: const AssetImage("assets/user1.jpg"),
                ),
              Flexible(
                child: Container(
                  margin: EdgeInsets.only(
                    left: isMe ? 0 : 8,
                    right: isMe ? 8 : 0,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    gradient: isMe
                        ? const LinearGradient(
                            colors: [Color(0xFFFF5A5F), Color(0xFFC1839F)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        : LinearGradient(
                            colors: [
                              isDark ? Colors.grey[800]! : Colors.white,
                              isDark ? Colors.grey[800]! : Colors.white,
                            ],
                          ),
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                    border: Border.all(
                      color: isDark ? Colors.transparent : Colors.grey[200]!,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        text,
                        style: TextStyle(
                          color: isMe
                              ? Colors.white
                              : (isDark ? Colors.white : Colors.black),
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        time,
                        style: TextStyle(
                          color: isMe
                              ? Colors.white.withOpacity(0.7)
                              : (isDark ? Colors.grey[400] : Colors.grey[600]),
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (isMe)
                CircleAvatar(
                  radius: 16,
                  backgroundImage: const AssetImage("assets/profile.jpg"),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
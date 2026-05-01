import 'package:flutter/material.dart';
import 'package:market_mate/screens/login_screen.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _iconScaleAnimation;
  late Animation<double> _iconRotationAnimation;
  late Animation<Color?> _bgColorAnimation;
  late Animation<double> _textOpacityAnimation;
  late Animation<double> _textScaleAnimation;
  
  String _appName = 'Market Mate';
  String _displayedText = '';
  int _charIndex = 0;
  bool _showSlogan = false;
  bool _showTagline = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 6), // ✅ CHANGED: 5 to 6 seconds
      vsync: this,
    );

    // Background color gradient animation - YOUR THEME COLORS
    _bgColorAnimation = ColorTween(
      begin: const Color(0xFFFDF6F2), // ✅ Your light theme color
      end: const Color(0xFFFF5A5F),   // ✅ Your brand red
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.7, curve: Curves.easeInOut),
    ));

    // Icon scale animation with multiple bounces
    _iconScaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 1.2)
            .chain(CurveTween(curve: Curves.elasticOut)),
        weight: 40,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.2, end: 0.9)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 20,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.9, end: 1.0)
            .chain(CurveTween(curve: Curves.elasticOut)),
        weight: 40,
      ),
    ]).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.4),
      ),
    );

    // Icon rotation animation
    _iconRotationAnimation = Tween<double>(
      begin: 0.0,
      end: 2 * 3.14159, // Full circle
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.4, curve: Curves.easeInOut),
      ),
    );

    // Text opacity animation
    _textOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 0.8, curve: Curves.easeIn),
      ),
    );

    // Text scale animation
    _textScaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 0.8, curve: Curves.elasticOut),
      ),
    );

    _controller.forward();

    // Typewriter effect sequence
    _startAnimations();
  }

  void _startAnimations() {
    // Start typing effect after icon animation
    Timer(const Duration(milliseconds: 1000), () { // ✅ CHANGED: 800 to 1000
      Timer.periodic(const Duration(milliseconds: 250), (timer) { // ✅ CHANGED: 200 to 250 (slower typing)
        if (_charIndex < _appName.length) {
          setState(() {
            _displayedText += _appName[_charIndex];
            _charIndex++;
          });
        } else {
          timer.cancel();
          
          // Show slogan after typing completes
          Timer(const Duration(milliseconds: 600), () { // ✅ CHANGED: 400 to 600
            setState(() {
              _showSlogan = true;
            });
            
            // Show tagline after slogan
            Timer(const Duration(milliseconds: 800), () { // ✅ CHANGED: 600 to 800
              setState(() {
                _showTagline = true;
              });
            });
          });
        }
      });
    });

    // Navigate to LoginScreen after 6 seconds ✅ CHANGED: 5 to 6 seconds
    Future.delayed(const Duration(seconds: 6), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginsingupScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  _bgColorAnimation.value ?? const Color(0xFFFDF6F2),
                  const Color(0xFFC1839F),
                  const Color(0xFFFF5A5F),
                ],
                stops: const [0.0, 0.5, 1.0],
                transform: GradientRotation(_controller.value * 0.25), // ✅ CHANGED: 0.3 to 0.25 (slower rotation)
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Animated Icon
                  AnimatedBuilder(
                    animation: _iconRotationAnimation,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _iconRotationAnimation.value,
                        child: ScaleTransition(
                          scale: _iconScaleAnimation,
                          child: Container(
                            width: 140,
                            height: 140,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFFFF5A5F), Color(0xFFC1839F)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFFFF5A5F).withOpacity(0.4),
                                  blurRadius: 25,
                                  spreadRadius: 5,
                                  offset: const Offset(0, 10),
                                ),
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 15,
                                  spreadRadius: 2,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Icon(
                                Icons.shopping_bag_rounded,
                                color: Colors.white,
                                size: 70,
                                shadows: [
                                  Shadow(
                                    color: Colors.black.withOpacity(0.3),
                                    blurRadius: 10,
                                    offset: const Offset(2, 2),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // App name with typewriter effect
                  ScaleTransition(
                    scale: _textScaleAnimation,
                    child: Opacity(
                      opacity: _textOpacityAnimation.value,
                      child: Text(
                        _displayedText,
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: 1.5,
                          fontFamily: 'Poppins',
                          shadows: [
                            Shadow(
                              blurRadius: 10.0,
                              color: Colors.black.withOpacity(0.3),
                              offset: const Offset(3.0, 3.0),
                            ),
                            Shadow(
                              blurRadius: 20.0,
                              color: const Color(0xFFFF5A5F).withOpacity(0.5),
                              offset: const Offset(0.0, 0.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 30), // ✅ CHANGED: 25 to 30
                  
                  // Animated slogan
                  if (_showSlogan)
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 800), // ✅ CHANGED: 600 to 800
                      opacity: _showSlogan ? 1.0 : 0.0,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.5),
                          end: Offset.zero,
                        ).animate(CurvedAnimation(
                          parent: _controller,
                          curve: const Interval(0.65, 0.9, curve: Curves.easeOut), // ✅ CHANGED: Adjusted timing
                        )),
                        child: const Text(
                          'Shop Smart. Save Big.',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            letterSpacing: 1.1,
                            fontFamily: 'Poppins',
                            shadows: [
                              Shadow(
                                blurRadius: 5.0,
                                color: Colors.black26,
                                offset: Offset(1.0, 1.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  
                  const SizedBox(height: 20), // ✅ CHANGED: 15 to 20
                  
                  // Animated tagline
                  if (_showTagline)
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 1000), // ✅ CHANGED: 800 to 1000
                      opacity: _showTagline ? 1.0 : 0.0,
                      child: FadeTransition(
                        opacity: Tween<double>(
                          begin: 0.0,
                          end: 1.0,
                        ).animate(CurvedAnimation(
                          parent: _controller,
                          curve: const Interval(0.75, 1.0, curve: Curves.easeIn), // ✅ CHANGED: Adjusted timing
                        )),
                        child: const Text(
                          'Premium pre-loved products at amazing prices',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic,
                            letterSpacing: 0.5,
                            shadows: [
                              Shadow(
                                blurRadius: 3.0,
                                color: Colors.black12,
                                offset: Offset(1.0, 1.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  
                  const SizedBox(height: 60), // ✅ CHANGED: 50 to 60
                  
                  // Loading indicator
                  Opacity(
                    opacity: _controller.value > 0.5 ? 1.0 : 0.0, // ✅ CHANGED: 0.6 to 0.5 (earlier appearance)
                    child: SizedBox(
                      width: 150, // ✅ CHANGED: 120 to 150 (wider)
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.white.withOpacity(0.2),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.white.withOpacity(0.9),
                        ),
                        borderRadius: BorderRadius.circular(10),
                        minHeight: 8, // ✅ CHANGED: 6 to 8 (thicker)
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 20), // ✅ CHANGED: 15 to 20
                  
                  // Loading text with animation
                  Opacity(
                    opacity: _controller.value > 0.6 ? 1.0 : 0.0, // ✅ CHANGED: 0.7 to 0.6 (earlier appearance)
                    child: Text(
                      'Loading${_getLoadingDots()}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16, // ✅ CHANGED: 15 to 16
                        fontWeight: FontWeight.w400,
                        shadows: [
                          Shadow(
                            blurRadius: 2.0,
                            color: Colors.black26,
                            offset: Offset(1.0, 1.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String _getLoadingDots() {
    final progress = (_controller.value * 8).toInt(); // ✅ CHANGED: 10 to 8 (slower dots)
    final dotCount = (progress % 4) + 1;
    return '.' * dotCount;
  }
}
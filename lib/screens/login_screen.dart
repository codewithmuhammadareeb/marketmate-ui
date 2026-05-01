import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:market_mate/screens/home_screen.dart';

class LoginsingupScreen extends StatefulWidget {
  const LoginsingupScreen({super.key});

  @override
  State<LoginsingupScreen> createState() => _LoginsingupScreenState();
}

class _LoginsingupScreenState extends State<LoginsingupScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  final _formKeyLogin = GlobalKey<FormState>();
  final _formKeySignupStep1 = GlobalKey<FormState>();
  final _formKeySignupStep2 = GlobalKey<FormState>();

  bool _isLogin = true;
  int _signupStep = 0;
  String? _loginError;

  @override
  void initState() {
    super.initState();
    // Remove or comment out _checkExistingUser()
    // _checkExistingUser();
  }

  // Remove this function entirely or keep it commented
  /*
  Future<void> _checkExistingUser() async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('user_email');
    if (savedEmail != null && savedEmail.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      });
    }
  }
  */

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  void _clearAllFields() {
    _emailController.clear();
    _passwordController.clear();
    _firstNameController.clear();
    _lastNameController.clear();
    _dobController.clear();
  }

  void _toggleAuth() {
    setState(() {
      _isLogin = !_isLogin;
      _signupStep = 0;
      _loginError = null;
      _clearAllFields();
    });
  }

  InputDecoration _inputDecor(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.grey[100],
      prefixIcon: Icon(icon, color: Colors.grey[600]),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Color(0xFFFF5A5F), width: 2),
      ),
      labelStyle: TextStyle(color: Colors.grey[700]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      transitionBuilder: (child, anim) => SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.05),
                          end: Offset.zero,
                        ).animate(CurvedAnimation(
                          parent: anim,
                          curve: Curves.easeOut,
                        )),
                        child: FadeTransition(
                          opacity: anim,
                          child: child,
                        ),
                      ),
                      child: Container(
                        key: ValueKey(_isLogin ? 'login' : 'signup'),
                        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // App Logo at center top
                            _buildAppLogo(),
                            const SizedBox(height: 25),
                            
                            _isLogin ? _buildLogin() : _buildSignup(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // ---------------- LOGIN ------------------
  Widget _buildLogin() {
    return Form(
      key: _formKeyLogin,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Log in",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: Color(0xFFFF5A5F),
            ),
          ),
          const SizedBox(height: 25),
          
          TextFormField(
            controller: _emailController,
            style: const TextStyle(color: Colors.black87),
            decoration: _inputDecor("Email", Icons.email),
            validator: (v) => v!.isEmpty ? "Email required" : null,
          ),
          const SizedBox(height: 18),
          
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            style: const TextStyle(color: Colors.black87),
            decoration: _inputDecor("Password", Icons.lock),
            validator: (v) => v!.length < 6 ? "Minimum 6 characters" : null,
          ),
          
          // Forgot Password
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                // TODO: Implement forgot password
              },
              child: Text(
                "Forgot Password?",
                style: TextStyle(
                  color: Color(0xFFFF5A5F),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          
          if (_loginError != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                _loginError!,
                style: TextStyle(
                  color: Color(0xFFFF5A5F),
                  fontSize: 14,
                ),
              ),
            ),
            
          const SizedBox(height: 10),
          _mainButton("Log in", _login),
          const SizedBox(height: 20),
          
          // OR divider
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Expanded(child: Divider(color: Colors.grey[300])),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "or continue with",
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                ),
                Expanded(child: Divider(color: Colors.grey[300])),
              ],
            ),
          ),
          
          // Social buttons - 3 options
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _socialButton(Icons.g_mobiledata, "Google"),
              const SizedBox(width: 20),
              _socialButton(Icons.facebook, "Facebook"),
              const SizedBox(width: 20),
              _socialButton(Icons.apple, "Apple"),
            ],
          ),
          
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an account? ",
                style: TextStyle(color: Colors.grey[700], fontSize: 15),
              ),
              GestureDetector(
                onTap: _toggleAuth,
                child: Text(
                  "Sign up",
                  style: TextStyle(
                    color: Color(0xFFFF5A5F),
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------- SIGNUP ------------------
  Widget _buildSignup() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          "Sign up",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: Color(0xFFFF5A5F),
          ),
        ),
        const SizedBox(height: 25),
        
        if (_signupStep == 0) _signupStepOne(),
        if (_signupStep == 1) _signupStepTwo(),
        const SizedBox(height: 20),
        
        // Social signup option for signup screen
        if (_signupStep == 0) ...[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Expanded(child: Divider(color: Colors.grey[300])),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "or sign up with",
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                ),
                Expanded(child: Divider(color: Colors.grey[300])),
              ],
            ),
          ),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _socialButton(Icons.g_mobiledata, "Google"),
              const SizedBox(width: 20),
              _socialButton(Icons.facebook, "Facebook"),
              const SizedBox(width: 20),
              _socialButton(Icons.apple, "Apple"),
            ],
          ),
          const SizedBox(height: 20),
        ],
        
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Already have an account? ",
              style: TextStyle(color: Colors.grey[700], fontSize: 15),
            ),
            GestureDetector(
              onTap: _toggleAuth,
              child: Text(
                "Log in",
                style: TextStyle(
                  color: Color(0xFFFF5A5F),
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ---------------- APP LOGO ------------------
  Widget _buildAppLogo() {
    return Column(
      children: [
        // Shopping bag icon
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFFF5A5F), Color(0xFFC1839F)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Color(0xFFFF5A5F).withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: const Center(
            child: Icon(
              Icons.shopping_bag_outlined,
              size: 40,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 15),
        
        // App name - CHANGED FROM "Your Choice" TO "Market Mate"
        Text(
          "Market Mate",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: Color(0xFFFF5A5F),
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 5),
        
        // Tagline
        Text(
          "Style that speaks for you",
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  // ---------------- SOCIAL BUTTON (Updated with Flutter Icons) ------------------
  Widget _socialButton(IconData icon, String label) {
    return Column(
      children: [
        Container(
          height: 56,
          width: 56,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey[300]!),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Icon(
              icon,
              size: 28,
              color: _getIconColor(icon),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // Helper function to get appropriate color for each social icon
  Color _getIconColor(IconData icon) {
    if (icon == Icons.g_mobiledata) {
      return Colors.red; // Google color
    } else if (icon == Icons.facebook) {
      return Colors.blue; // Facebook color
    } else if (icon == Icons.apple) {
      return Colors.black; // Apple color
    }
    return Colors.grey[700]!;
  }

  // ---------------- BUTTONS ------------------
  Widget _mainButton(String text, VoidCallback onTap) {
    return SizedBox(
      height: 52,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFFF5A5F),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  Widget _greyButton(String text, VoidCallback onTap) {
    return SizedBox(
      height: 52,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[100],
          foregroundColor: Colors.grey[800],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.grey[300]!),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // ---------------- SIGNUP STEPS ------------------
  Widget _signupStepOne() {
    return Form(
      key: _formKeySignupStep1,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _emailController,
            style: const TextStyle(color: Colors.black87),
            decoration: _inputDecor("Email", Icons.email),
            validator: (v) => v!.isEmpty ? "Email required" : null,
          ),
          const SizedBox(height: 18),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            style: const TextStyle(color: Colors.black87),
            decoration: _inputDecor("Password", Icons.lock),
            validator: (v) => v!.length < 6 ? "Minimum 6 characters" : null,
          ),
          const SizedBox(height: 30),
          _mainButton("Continue", () {
            if (_formKeySignupStep1.currentState!.validate()) {
              setState(() => _signupStep = 1);
            }
          }),
        ],
      ),
    );
  }

  Widget _signupStepTwo() {
    return Form(
      key: _formKeySignupStep2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _firstNameController,
            style: const TextStyle(color: Colors.black87),
            decoration: _inputDecor("First Name", Icons.person_outline),
            validator: (v) => v!.isEmpty ? "Required" : null,
          ),
          const SizedBox(height: 18),
          TextFormField(
            controller: _lastNameController,
            style: const TextStyle(color: Colors.black87),
            decoration: _inputDecor("Last Name", Icons.person_outline),
            validator: (v) => v!.isEmpty ? "Required" : null,
          ),
          const SizedBox(height: 18),
          TextFormField(
            controller: _dobController,
            readOnly: true,
            style: const TextStyle(color: Colors.black87),
            decoration: _inputDecor("Date of Birth", Icons.calendar_today),
            validator: (v) => v!.isEmpty ? "Required" : null,
            onTap: () async {
              final FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
              
              final DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: ColorScheme.light(
                        primary: Color(0xFFFF5A5F),
                        onPrimary: Colors.white,
                        surface: Colors.white,
                        onSurface: Colors.black,
                      ),
                      dialogBackgroundColor: Colors.white,
                    ),
                    child: child!,
                  );
                },
              );
              
              if (pickedDate != null) {
                final formattedDate = "${pickedDate.day.toString().padLeft(2, '0')}/"
                    "${pickedDate.month.toString().padLeft(2, '0')}/"
                    "${pickedDate.year}";
                setState(() {
                  _dobController.text = formattedDate;
                });
              }
            },
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              Expanded(
                child: _greyButton("Back", () {
                  setState(() => _signupStep = 0);
                }),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: _mainButton("Create Account", _signup),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------- SIGNUP ACTION ------------------
  Future<void> _signup() async {
    if (_formKeySignupStep2.currentState!.validate()) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_email', _emailController.text.trim());
      await prefs.setString('user_password', _passwordController.text.trim());
      
      // Store additional user info
      await prefs.setString('user_first_name', _firstNameController.text.trim());
      await prefs.setString('user_last_name', _lastNameController.text.trim());
      await prefs.setString('user_dob', _dobController.text.trim());

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    }
  }

  // ---------------- LOGIN ACTION ------------------
  Future<void> _login() async {
    if (_formKeyLogin.currentState!.validate()) {
      final prefs = await SharedPreferences.getInstance();
      final savedEmail = prefs.getString('user_email');
      final savedPassword = prefs.getString('user_password');

      if (_emailController.text.trim() == savedEmail &&
          _passwordController.text.trim() == savedPassword) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      } else {
        setState(() => _loginError = "Invalid email or password");
      }
    }
  }
}
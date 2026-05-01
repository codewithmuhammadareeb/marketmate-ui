// import 'package:flutter/material.dart';
// import 'package:your_choice/screens/home_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class SignupScreen extends StatefulWidget {
//   const SignupScreen({super.key});

//   @override
//   State<SignupScreen> createState() => _SignupScreenState();
// }

// class _SignupScreenState extends State<SignupScreen>
//     with SingleTickerProviderStateMixin {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _firstNameController = TextEditingController();
//   final TextEditingController _lastNameController = TextEditingController();
//   final TextEditingController _dobController = TextEditingController();

//   final _formKeyStep1 = GlobalKey<FormState>();
//   final _formKeyStep2 = GlobalKey<FormState>();
//   DateTime? _selectedDate;
//   int _currentStep = 0;

//   late AnimationController _animController;
//   late Animation<Offset> _fieldsSlideAnimation;
//   late Animation<double> _fieldsFadeAnimation;

//   @override
//   void initState() {
//     super.initState();

//     _animController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 600),
//     );

//     _fieldsSlideAnimation = Tween<Offset>(
//       begin: const Offset(0, 0.2),
//       end: Offset.zero,
//     ).animate(
//       CurvedAnimation(parent: _animController, curve: Curves.easeOut),
//     );

//     _fieldsFadeAnimation = Tween<double>(begin: 0, end: 1).animate(
//       CurvedAnimation(parent: _animController, curve: Curves.easeIn),
//     );

//     _animController.forward();
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(1900),
//       lastDate: DateTime.now(),
//     );
//     if (picked != null && picked != _selectedDate) {
//       setState(() {
//         _selectedDate = picked;
//         _dobController.text = "${picked.day}/${picked.month}/${picked.year}";
//       });
//     }
//   }

//   void _goToNextStep() {
//     if (_formKeyStep1.currentState!.validate()) {
//       setState(() {
//         _currentStep = 1;
//       });
//       _animController.forward(from: 0);
//     }
//   }

//   void _goToPreviousStep() {
//     setState(() {
//       _currentStep = 0;
//     });
//     _animController.forward(from: 0);
//   }

//   void _createAccount(BuildContext context) async {
//     if (_formKeyStep2.currentState!.validate()) {
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setString('user_email', _emailController.text.trim());
//       await prefs.setString('user_password', _passwordController.text.trim());

//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const HomeScreen()),
//       );
//     }
//   }

//   InputDecoration _inputDecoration(String label, IconData icon) {
//     return InputDecoration(
//       labelText: label,
//       labelStyle: const TextStyle(color: Colors.grey),
//       filled: true,
//       fillColor: Colors.grey[200],
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(10),
//         borderSide: BorderSide.none,
//       ),
//       errorBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(10),
//         borderSide: const BorderSide(color: Colors.red, width: 1.5),
//       ),
//       focusedErrorBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(10),
//         borderSide: const BorderSide(color: Colors.red, width: 1.5),
//       ),
//       prefixIcon: Icon(icon, color: Colors.grey),
//     );
//   }

//   @override
//   void dispose() {
//     _animController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             children: [
//               const SizedBox(height: 40),
//               const Align(
//                 alignment: Alignment.centerRight,
//                 child: Text(
//                   'ReBuy',
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               const Text(
//                 'Sign up',
//                 style: TextStyle(
//                   fontSize: 32,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               const Text(
//                 'Sign up with one of the following options',
//                 style: TextStyle(fontSize: 16, color: Colors.grey),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   SocialLoginButton(icon: Icons.g_mobiledata, onPressed: () {}),
//                   SocialLoginButton(icon: Icons.facebook, onPressed: () {}),
//                   SocialLoginButton(icon: Icons.apple, onPressed: () {}),
//                 ],
//               ),
//               const SizedBox(height: 25),
//               const Row(
//                 children: [
//                   Expanded(child: Divider(color: Colors.grey, thickness: 1)),
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 10),
//                     child: Text('or', style: TextStyle(color: Colors.grey)),
//                   ),
//                   Expanded(child: Divider(color: Colors.grey, thickness: 1)),
//                 ],
//               ),
//               const SizedBox(height: 25),
//               SlideTransition(
//                 position: _fieldsSlideAnimation,
//                 child: FadeTransition(
//                   opacity: _fieldsFadeAnimation,
//                   child: _currentStep == 0
//                       ? Form(
//                           key: _formKeyStep1,
//                           child: Column(
//                             children: [
//                               TextFormField(
//                                 controller: _emailController,
//                                 style: const TextStyle(color: Colors.black),
//                                 decoration: _inputDecoration('Email', Icons.email),
//                                 keyboardType: TextInputType.emailAddress,
//                                 validator: (value) {
//                                   if (value == null || value.isEmpty) {
//                                     return "Email required";
//                                   }
//                                   if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
//                                       .hasMatch(value)) {
//                                     return "Enter valid email";
//                                   }
//                                   return null;
//                                 },
//                               ),
//                               const SizedBox(height: 15),
//                               TextFormField(
//                                 controller: _passwordController,
//                                 style: const TextStyle(color: Colors.black),
//                                 obscureText: true,
//                                 decoration: _inputDecoration('Password', Icons.lock),
//                                 validator: (value) {
//                                   if (value == null || value.isEmpty) {
//                                     return "Password required";
//                                   }
//                                   if (value.length < 6) {
//                                     return "At least 6 characters";
//                                   }
//                                   return null;
//                                 },
//                               ),
//                               const SizedBox(height: 25),
//                               SizedBox(
//                                 width: double.infinity,
//                                 height: 50,
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                     gradient: const LinearGradient(
//                                       begin: Alignment(-0.9, -0.9),
//                                       end: Alignment(0.9, 0.9),
//                                       colors: [Color(0xFFFF5A5F), Color(0xFFC1839F)],
//                                       stops: [0.22, 0.77],
//                                     ),
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                   child: ElevatedButton(
//                                     onPressed: _goToNextStep,
//                                     style: ElevatedButton.styleFrom(
//                                       backgroundColor: Colors.transparent,
//                                       shadowColor: Colors.transparent,
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(10),
//                                       ),
//                                     ),
//                                     child: const Text(
//                                       'Next',
//                                       style: TextStyle(
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         )
//                       : Form(
//                           key: _formKeyStep2,
//                           child: Column(
//                             children: [
//                               TextFormField(
//                                 controller: _firstNameController,
//                                 style: const TextStyle(color: Colors.black),
//                                 decoration:
//                                     _inputDecoration('First Name', Icons.person),
//                                 validator: (value) =>
//                                     value == null || value.isEmpty ? "Required" : null,
//                               ),
//                               const SizedBox(height: 15),
//                               TextFormField(
//                                 controller: _lastNameController,
//                                 style: const TextStyle(color: Colors.black),
//                                 decoration:
//                                     _inputDecoration('Last Name', Icons.person),
//                                 validator: (value) =>
//                                     value == null || value.isEmpty ? "Required" : null,
//                               ),
//                               const SizedBox(height: 15),
//                               TextFormField(
//                                 controller: _dobController,
//                                 style: const TextStyle(color: Colors.black),
//                                 readOnly: true,
//                                 onTap: () => _selectDate(context),
//                                 decoration: _inputDecoration(
//                                   'Date of Birth',
//                                   Icons.calendar_today,
//                                 ).copyWith(
//                                   suffixIcon: IconButton(
//                                     icon: const Icon(Icons.calendar_month,
//                                         color: Colors.grey),
//                                     onPressed: () => _selectDate(context),
//                                   ),
//                                 ),
//                                 validator: (value) =>
//                                     value == null || value.isEmpty ? "Required" : null,
//                               ),
//                               const SizedBox(height: 25),
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: SizedBox(
//                                       height: 50,
//                                       child: ElevatedButton(
//                                         onPressed: _goToPreviousStep,
//                                         style: ElevatedButton.styleFrom(
//                                           backgroundColor: Colors.grey[300],
//                                           shape: RoundedRectangleBorder(
//                                             borderRadius: BorderRadius.circular(10),
//                                           ),
//                                         ),
//                                         child: const Text(
//                                           'Back',
//                                           style: TextStyle(
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.bold,
//                                             color: Colors.black,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   const SizedBox(width: 15),
//                                   Expanded(
//                                     child: SizedBox(
//                                       height: 50,
//                                       child: Container(
//                                         decoration: BoxDecoration(
//                                           gradient: const LinearGradient(
//                                             begin: Alignment(-0.9, -0.9),
//                                             end: Alignment(0.9, 0.9),
//                                             colors: [
//                                               Color(0xFFFF5A5F),
//                                               Color(0xFFC1839F)
//                                             ],
//                                             stops: [0.22, 0.77],
//                                           ),
//                                           borderRadius: BorderRadius.circular(10),
//                                         ),
//                                         child: ElevatedButton(
//                                           onPressed: () => _createAccount(context),
//                                           style: ElevatedButton.styleFrom(
//                                             backgroundColor: Colors.transparent,
//                                             shadowColor: Colors.transparent,
//                                             shape: RoundedRectangleBorder(
//                                               borderRadius: BorderRadius.circular(10),
//                                             ),
//                                           ),
//                                           child: const Text(
//                                             'Create account',
//                                             style: TextStyle(
//                                               fontSize: 18,
//                                               fontWeight: FontWeight.bold,
//                                               color: Colors.white,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                 ),
//               ),
//               const SizedBox(height: 15),
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 child: const Text.rich(
//                   TextSpan(
//                     text: "Already have an account? ",
//                     style: TextStyle(color: Colors.grey),
//                     children: [
//                       TextSpan(
//                         text: 'Log in',
//                         style: TextStyle(
//                           color: Color(0xFFFF5A5F),
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class SocialLoginButton extends StatelessWidget {
//   final IconData icon;
//   final VoidCallback onPressed;

//   const SocialLoginButton({
//     super.key,
//     required this.icon,
//     required this.onPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 60,
//       height: 60,
//       decoration: BoxDecoration(
//         color: Colors.grey[200],
//         shape: BoxShape.circle,
//       ),
//       child: IconButton(
//         icon: Icon(icon, size: 30, color: Colors.black),
//         onPressed: onPressed,
//       ),
//     );
//   }
// }

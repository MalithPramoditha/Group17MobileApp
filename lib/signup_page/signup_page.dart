import 'package:facultyreservation/home_page/home_page.dart';
import 'package:facultyreservation/login_page/login_page.dart';
import 'package:flutter/material.dart';
import 'package:pulsator/pulsator.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupPage extends StatefulWidget {
  final PageController controller;

  const SignupPage({Key? key, required this.controller}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _repassController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          // image: DecorationImage(
          //   image: AssetImage("assets/vector-3.jpg"),
          //   fit: BoxFit.cover,
          // ),
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  textDirection: TextDirection.ltr,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Color(0xFF003580),
                          fontSize: 30,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 56,
                      child: TextField(
                        controller: _emailController,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            color: Color(0xFF003580),
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              width: 2,
                              color: Color(0xFF003580),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              width: 4,
                              color: Color(0xFF003580),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 147,
                          height: 56,
                          child: TextField(
                            controller: _passController,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                            decoration: const InputDecoration(
                              labelText: 'Password',
                              hintText: 'Create Password',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 10,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                              ),
                              labelStyle: TextStyle(
                                color: Color(0xFF003580),
                                fontSize: 15,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Color(0xFF003580),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(
                                  width: 4,
                                  color: Color(0xFF003580),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 147,
                          height: 56,
                          child: TextField(
                            controller: _repassController,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                            decoration: const InputDecoration(
                              labelText: 'Retype',
                              hintText: 'Confirm Password',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 10,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                              ),
                              labelStyle: TextStyle(
                                color: Color(0xFF003580),
                                fontSize: 15,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Color(0xFF003580),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(
                                  width: 4,
                                  color: Color(0xFF003580),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (errorMessage.isNotEmpty)
                      Text(
                        errorMessage,
                        style: TextStyle(color: Colors.red),
                      ),
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: SizedBox(
                        width: 329,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: isLoading ? null : _register,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF003580),
                          ),
                          child: isLoading
                              ? CircularProgressIndicator()
                              : const Text(
                                  'Create account',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          'Have an account?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          width: 2.5,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LoginPage(controller: widget.controller)),
                            );
                          },
                          child: const Text(
                            'Log In ',
                            style: TextStyle(
                              color: Color(0xFF003580),
                              fontSize: 15,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                    Center(
                      child: SizedBox(
                        width: 200.0,
                        height: 200.0,
                        child: Pulsator(
                          style: const PulseStyle(color: Color(0xFF003580)),
                          count: 5,
                          duration: const Duration(seconds: 4),
                          repeat: 0,
                          startFromScratch: false,
                          autoStart: true,
                          fit: PulseFit.contain,
                          child: Center(
                            child: Image.asset(
                              'assets/vector-2.png',
                              width: 75.0,
                              height: 75.0,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _register() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      // Validate email format
      RegExp emailRegExp = RegExp(
          r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$'); // Basic email format
      if (!emailRegExp.hasMatch(_emailController.text.trim())) {
        throw FirebaseAuthException(
            code: 'invalid-email',
            message: 'The email address is badly formatted.');
      }

      // Check if passwords match
      if (_passController.text != _repassController.text) {
        throw FirebaseAuthException(
            code: 'password-mismatch',
            message: 'The entered passwords do not match.');
      }

      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passController.text,
      );

      print('Registration successful: ${userCredential.user!.email}');
      
      // Navigate to the HomePage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(controller: widget.controller),
        ),
      );
    } catch (e) {
      print('Registration failed: $e');
      print('Error Code: ${(e as FirebaseAuthException).code}');
      setState(() {
        errorMessage = 'Registration failed. Please try again.';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

}

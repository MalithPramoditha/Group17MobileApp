import 'package:facultyreservation/home_page/home_page.dart';
import 'package:pulsator/pulsator.dart';
import 'package:facultyreservation/signup_page/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
 
class LoginPage extends StatefulWidget {
  final PageController controller;

  const LoginPage({Key? key, required this.controller}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
 
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  textDirection: TextDirection.ltr,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    const Center(
                      child: Text(
                        'Log In',
                        style: TextStyle(
                          color: Color(0xFF003580),
                          fontSize: 30,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
                              width: 100.0,
                              height: 100.0,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                    TextField(
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
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: _passwordController,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Password',
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
                    const SizedBox(
                      height: 20,
                    ),
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: SizedBox(
                        width: 329,
                        height: 56,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF003580),
                          ),
                          onPressed: () async {
                            try {
                              UserCredential userCredential =
                                  await _auth.signInWithEmailAndPassword(
                                email: _emailController.text,
                                password: _passwordController.text,
                              );
                              print('Login successful: ${userCredential.user!.email}');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      HomePage(controller: widget.controller),
                                ),
                              );
                            } catch (e) {
                              print('Login failed: $e');
                            }
                          },
                          child: const Text('Login',
                          style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                  ),),
                        ),
                      ),
                    ),
                 
                    SizedBox(height: 20,),
                    
                    Row(
                      children: [
                        const Text(
                          'Don’t have an account?',
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
                                  builder: (context) => SignupPage(
                                      controller: widget.controller)),
                            );
                          },
                          child: const Text(
                            'Sign Up',
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
                      height: 5,
                    ),
                    const Text(
                      'Forget Password?',
                      style: TextStyle(
                        color: Color(0xFF003580),
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
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
}

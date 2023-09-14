import 'package:expense_tracker/settings_page.dart';
import 'package:expense_tracker/signup_page.dart';
import 'package:expense_tracker/summary_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Authentication

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false;
  final FirebaseAuth _auth = FirebaseAuth.instance; // Create an instance of FirebaseAuth

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Function to handle user login
  Future<void> signInWithEmailAndPassword() async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      final User? user = userCredential.user;
      if (user != null) {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SummaryPage()),
        );
      } else {
        // Handle the case where login fails
        print('Login failed');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff3aa6b9),
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Please fill the credentials',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff727272),
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(height: 32),
                Container(
                  width: 350,
                  decoration: BoxDecoration(
                    color: Color(0xffb2f3f3),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: TextField(
                    controller: emailController, // Use the email controller
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email, color: Color(0xff3AA6B9)),
                      labelStyle: TextStyle(
                        color: Color(0xff3AA6B9),
                        fontFamily: 'Poppins',
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(16.0),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  width: 350,
                  decoration: BoxDecoration(
                    color: Color(0xffb2f3f3),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: TextField(
                    controller: passwordController, // Use the password controller
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock, color: Color(0xff3AA6B9)),
                      labelStyle: TextStyle(
                        color: Color(0xff3AA6B9),
                        fontFamily: 'Poppins',
                      ),
                      suffixIcon: IconButton(
                        icon: _isPasswordVisible
                            ? Icon(Icons.visibility_off, color: Color(0xff3AA6B9))
                            : Icon(Icons.visibility, color: Color(0xff3AA6B9)),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(16.0),
                    ),
                    obscureText: !_isPasswordVisible,
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    signInWithEmailAndPassword(); // Call the function for login
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    minimumSize: MaterialStateProperty.all(Size(300, 50)),
                    backgroundColor: MaterialStateProperty.all<Color>(Color(0xff3AA6B9)),
                  ),
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "Don't have an account yet?",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff727272),
                    fontFamily: 'Poppins',
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()),
                    ); // Navigate to the sign-up page
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      color: Color(0xff3aa6b9),
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
}

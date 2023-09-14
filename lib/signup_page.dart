import 'package:expense_tracker/summary_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Authentication
import 'login_page.dart'; // Import your login page
import 'package:firebase_database/firebase_database.dart';


class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseDatabase _database = FirebaseDatabase.instance;


  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  // Function to handle user registration
  Future<void> registerWithEmailAndPassword() async {
    try {
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      final User? user = userCredential.user;

      if (user != null) {
        // User is registered successfully, store their details in the database
        await _database.ref().child("users").child(user.uid).set({
          "name": nameController.text,
          "email": emailController.text,
          "phoneNumber": phoneNumberController.text,
        });

        // Navigate to another screen after successful registration
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SummaryPage()),
        );
      } else {
        // Handle the case where registration fails
        print('Registration failed');
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
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff3AA6B9),
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Create your account',
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
                    controller: nameController, // Use the name controller
                    decoration: InputDecoration(
                      labelText: 'Name',
                      prefixIcon: Icon(Icons.person, color: Color(0xff3AA6B9)),
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
                SizedBox(height: 16),
                Container(
                  width: 350,
                  decoration: BoxDecoration(
                    color: Color(0xffb2f3f3),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: TextField(
                    controller: confirmPasswordController, // Use the confirm password controller
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      prefixIcon: Icon(Icons.lock, color: Color(0xff3AA6B9)),
                      labelStyle: TextStyle(
                        color: Color(0xff3AA6B9),
                        fontFamily: 'Poppins',
                      ),
                      suffixIcon: IconButton(
                        icon: _isConfirmPasswordVisible
                            ? Icon(Icons.visibility_off, color: Color(0xff3AA6B9))
                            : Icon(Icons.visibility, color: Color(0xff3AA6B9)),
                        onPressed: () {
                          setState(() {
                            _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                          });
                        },
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(16.0),
                    ),
                    obscureText: !_isConfirmPasswordVisible,
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
                    controller: phoneNumberController, // Use the phone number controller
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      prefixIcon: Icon(Icons.phone, color: Color(0xff3AA6B9)),
                      labelStyle: TextStyle(
                        color: Color(0xff3AA6B9),
                        fontFamily: 'Poppins',
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(16.0),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    registerWithEmailAndPassword(); // Call the function for registration
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
                    'Sign Up',
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    ); // Navigate to the login page
                  },
                  child: Text(
                    'Already have an account? Sign In',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      color: Color(0xff3AA6B9),
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

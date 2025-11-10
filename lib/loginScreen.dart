import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

void main() {
  runApp(const loginScreen());
}


class loginScreen extends StatefulWidget {
  const loginScreen({super.key});

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  // A GlobalKey is needed to identify and validate the Form
  final _formKey = GlobalKey<FormState>();

  // This controller will keep track of what's typed in the password field
  final _passwordController = TextEditingController();


  // This is the function for Task 1: Password Validation
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }

    // Check for at least one capital letter
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must have at least one capital letter.';
    }

    // Check for at least one small letter
    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Password must have at least one small letter.';
    }

    // Check for at least one special character
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must have at least one special character.';
    }

    // NEW: Check for at least 8 characters
    if (value.length < 8) {
      return 'Password must be at least 8 characters long.';
    }

    // NEW: Check for no spaces
    if (value.contains(' ')) {
      return 'Password cannot contain spaces.';
    }


    // If all checks pass, return null (meaning no error)
    return null;
  }

  // This is the function for Task 2: Navigate to Facebook
  void _launchFacebookURL() async {
    const url = 'https://www.facebook.com';
    // We check if the phone can launch the URL
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      // Handle the error if the URL can't be launched
      print('Could not launch $url');
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,

        body: SafeArea(
          // Used SingleChildScrollView to prevent overflow when keyboard appears
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                // Back button
                Padding(
                  padding: const EdgeInsets.only(left: 16.41, top: 10),
                  child: Image.asset(
                    'myIcons/Back.png',
                    width: 9.38,
                    height: 17.47,
                    fit: BoxFit.cover,
                  ),
                ),

                // Instagram logo
                Container(
                  margin: const EdgeInsets.only(left: 96, top: 168),
                  child: Image.asset(
                    'myImages/instagramLogo.png',
                    width: 182,
                    height: 49,
                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(height: 40),

                //Form widget for username and password
                Form(
                  key: _formKey,
                  child: Container(
                    margin: const EdgeInsets.only(left: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Username
                        TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            fillColor: Color.fromRGBO(250, 250, 250, 1),
                            filled: true,
                            constraints: const BoxConstraints.tightFor(
                              width: 343,
                              height: 44,
                            ),
                            hintStyle: const TextStyle(color: Colors.grey),
                            hintText: 'Username',
                          ),
                        ),

                        const SizedBox(height: 8),

                        //TextFormField for password
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            fillColor: Color.fromRGBO(250, 250, 250, 1),
                            filled: true,
                            constraints: const BoxConstraints.tightFor(
                              width: 343,
                              height: 44,
                            ),
                            hintStyle: const TextStyle(color: Colors.grey),
                            hintText: 'Password',
                          ),
                          validator: _validatePassword,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),

                        const SizedBox(height: 8),

                        // Forgot password
                        Container(
                          padding: const EdgeInsets.only(left: 240),
                          child: const Text(
                            'Forgot password?',
                            style: TextStyle(
                                fontSize: 12,
                                color: Color.fromRGBO(55, 151, 239, 1),
                                fontWeight: FontWeight.bold),
                          ),
                        ),

                        const SizedBox(height: 8),

                        //Login button
                        SizedBox(
                          width: 343,
                          height: 44,
                          child: ElevatedButton(
                            onPressed: () {
                              // This line runs the _validatePassword function
                              if (_formKey.currentState!.validate()) {
                                // If the form is valid, show a success message or log in
                                print('Form is valid! Logging in...');
                              } else {
                                // If the form is invalid, the errors will show up
                                print('Form is invalid.');
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                              const Color.fromRGBO(55, 151, 239, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            child:
                            const Text(
                              'Log in',
                              style: TextStyle(color: Colors.white),
                            ),

                          ),
                        ),

                        //Wrapped in GestureDetector and added Icon
                        GestureDetector(
                          onTap: _launchFacebookURL,
                          child: Container(
                            padding: const EdgeInsets.only(top: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.facebook,
                                  color: Color.fromRGBO(55, 151, 239, 1),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Log in with Facebook',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Color.fromRGBO(55, 151, 239, 1),
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // OR divider
                Row(
                  children: [
                    const SizedBox(width: 16),
                    Expanded(
                      child: Divider(
                        color: Colors.grey.shade300,
                        thickness: 1,
                      ),
                    ),
                    const Text(
                      "  OR  ",
                      style: TextStyle(color: Colors.grey),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.grey.shade300,
                        thickness: 1,
                      ),
                    ),
                    const SizedBox(width: 16),
                  ],
                ),

                const SizedBox(height: 30),

                // Sign up text
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 0.5),
                        ),
                      ),
                      Text(
                        "Sign up.",
                        style: TextStyle(
                          color: Color.fromRGBO(55, 151, 239, 1),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 50),

                // Instagram from Facebook text
                Center(
                  child: Text(
                    "Instagram from Facebook",
                    style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 0.4), fontSize: 12),
                  ),
                ),

                const SizedBox(height: 20), // Added for spacing at the bottom
              ],
            ),
          ),
        ),
      ),
    );
  }
}
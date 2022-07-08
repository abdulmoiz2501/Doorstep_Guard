import 'package:doorstep_guard/Services/Firestore_PersonalDetails.dart';
import 'package:doorstep_guard/Screens/navigator/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:doorstep_guard/Screens/Login/login_screen.dart';
import 'package:doorstep_guard/Screens/Signup/components/background.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:doorstep_guard/components/already_have_an_account_acheck.dart';
import 'package:doorstep_guard/components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:progress_dialog/progress_dialog.dart';


class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _success;
  bool _registered =false , _obscureText = true;
  String _userEmail;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Form(
         key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "SIGN UP",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.03),
              Image.asset(
                "assets/images/signup.png",
                height: size.height * 0.32,
              ),
              SizedBox(
                height: 15,
              ),
              new Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                width: size.width * 0.8,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(29),
                  border: Border.all(color: Colors.black),
                ),
                child: TextFormField(
                  controller: _emailController,
                  cursorColor: Color(0xFF6F35A5),
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.person,
                      color: Color(0xFF172953),
                    ),
                    hintText: 'Your Email',
                    border: InputBorder.none,
                  ),
                  validator: MultiValidator(
                    [
                      RequiredValidator(errorText: '*Email required'),
                      EmailValidator(errorText: 'Invalid Email'),
                    ],
                  ),
                ),
              ),
              new Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                width: size.width * 0.8,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(29),
                  border: Border.all(color: Colors.black),
                ),
                child: TextFormField(
                  obscureText: _obscureText,
                  controller: _passwordController,
                  cursorColor: Color(0xFF6F35A5),
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.lock,
                      color: Color(0xFF172953),
                    ),
                    suffixIcon: GestureDetector(
                      child: Icon(
                        Icons.visibility,
                        color: Color(0xFF172953),
                      ),
                      onTap: _toggle,
                    ),
                    hintText: 'Password',
                    border: InputBorder.none,
                  ),
                  validator: MultiValidator(
                    [
                      RequiredValidator(errorText: '*Password required'),
                      MinLengthValidator(6,
                          errorText: "Password should be atleast 6 characters"),
                      MaxLengthValidator(15,
                          errorText: "Password greater than 15 characters"),
                    ],
                  ),
                ),
              ),
              RoundedButton(
                text: "Sign Up",
                press: () {
                  _emailController.text = _emailController.text.trim();
                  if (_formKey.currentState.validate()) {
                    _register();
                  }
                },
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                login: false,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return LoginScreen();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  } //second last


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // registering email and password
  Future _register() async {
    try {
      final ProgressDialog pr = ProgressDialog(context);
      pr.style(
        message: 'Please Wait...',
        progressWidget: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFF172953)),
        ),
      );
      pr.show();
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: _emailController.text,
            password: _passwordController.text,
          )
          .whenComplete(() => pr.hide());
      User user = userCredential.user;

      await DataBaseService(uid: user.uid).updateUserData("", "", "", "", "", "", "", "");

      if (user != null) {
        setState(() {
          _registered = true;
          _success = true;
          _userEmail = user.email;
        });
      } else {
        setState(() {
          _registered = true;
          _success = true;
        });
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        setState(() {
          _registered = false;
        });
        Scaffold.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 2),
          backgroundColor: Color(0xFF172953),
          content: Text(
            "Already Registered",
          ),
        ));
      }

      if (e.code == 'network-request-failed') {
        Scaffold.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 2),
          backgroundColor: Color(0xFF172953),
          content: Text(
            "No Network",
          ),
        ));
      }
    }
    if (_registered != false) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BottomBar(),
        ),
      );
    }
  }
} //final

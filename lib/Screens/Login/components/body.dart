import 'package:doorstep_guard/Screens/navigator/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:doorstep_guard/Screens/Login/components/background.dart';
import 'package:doorstep_guard/Screens/Signup/signup_screen.dart';
import 'package:doorstep_guard/components/already_have_an_account_acheck.dart';
import 'package:doorstep_guard/components/rounded_button.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _success;
  bool _registered = false , _obscureText = true;
  String _userEmail;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
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
                "LOGIN",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.03),

              Image.asset(
                "assets/images/login.png",
                height: size.height * 0.35,
              ),
              SizedBox(height: size.height * 0.03),
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
                text: "Login",
                press: () {
                  _emailController.text=_emailController.text.trim();
                  if (_formKey.currentState.validate()) {
                    _Login();
                  }
                },
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SignUpScreen();
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
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // registering email and password
  Future<void> _Login() async {
     ProgressDialog pr;
    try {
      pr = ProgressDialog(context);
      pr.style(
        message: 'Please Wait...',
        progressWidget: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFF172953)),
        ),
      );
      pr.show();
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      ).then((value) {
        pr.hide();

        CollectionReference users = FirebaseFirestore.instance.collection('User Details');
        User user=FirebaseAuth.instance.currentUser;
        FirebaseFirestore.instance.collection('User Details').doc(user.uid)
            .get().then((value) {
          pr.hide();
          Map map=value.data();
          var data = map["user type "];
          if(data  == "guard")
          {
            Navigator.pushReplacement(context, MaterialPageRoute(builder : (context)=> BottomBar(),
            ),);
          }
          else
          {
            FirebaseAuth.instance.signOut();
            Scaffold.of(context).showSnackBar(SnackBar(
              duration: Duration(seconds: 2),
              backgroundColor: Color(0xFF172953),
              content: Text(
                "Invalid User Type",
              ),
            ));
          }
        });

      });


    } on FirebaseAuthException catch (e) {
      pr.hide();
      print(e.code);
      if (e.code == 'user-not-found') {
        Scaffold.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 2),
          backgroundColor: Color(0xFF172953),
          content: Text(
            "User Not Found",
          ),
        ));
      }

      if (e.code == 'wrong-password') {
        pr.hide();
        Scaffold.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 2),
          backgroundColor: Color(0xFF172953),
          content: Text(
            "Wrong Password",
          ),
        ));
      }

      if (e.code == 'network-request-failed') {
        pr.hide();
        Scaffold.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 2),
          backgroundColor: Color(0xFF172953),
          content: Text(
            "No Network",
          ),
        ));
      }
    }


  }

}

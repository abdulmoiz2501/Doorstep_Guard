//import 'package:DoorStep/Screens/MyAccountSaved/MyAccountSaved.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:doorstep_guard/Screens/Login/login_screen.dart';
//import 'package:doorstep_guard/Screens/MyAccount/My_Account.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:doorstep_guard/Screens/FAQ/Faq.dart';
//import 'package:doorstep_guard/Screens/Support/Support.dart';
import 'package:progress_dialog/progress_dialog.dart';

class MenuDrawer extends StatefulWidget {
  @override
  _MenuDrawerState createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  //final FirebaseAuth _auth = FirebaseAuth.instance;

  // isUserDetailCompleted() {
  //   final ProgressDialog pr = ProgressDialog(context);
  //   pr.style(
  //     message: 'Please Wait...',
  //     progressWidget: CircularProgressIndicator(
  //       valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFF6F35A5)),
  //     ),
  //   );
  //   pr.show();
  //   User user = FirebaseAuth.instance.currentUser;
  //   print(user.uid);
  //   FirebaseFirestore.instance
  //       .collection('User Details')
  //       .doc(user.uid)
  //       .get()
  //       .then((value) {
  //     pr.hide();
  //     Map map = value.data();
  //     var data = map["Email "];
  //     if (data == "") {
  //       print("user email ${user.email}");
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => MyAccount(user.email)),
  //       );
  //     } else {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => MyAccountSaved()),
  //       );
  //     }
  //   }).onError((error, stackTrace) => pr.hide());
  // }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Head of Drawer
          UserAccountsDrawerHeader(
            /* accountName: Text(
                    'Abdul Moiz',
                    style: TextStyle(
                      color: Colors.black,
                      backgroundColor: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                    ),
                  ),

              accountEmail: Text(
                    'test@buic.com',
                    style: TextStyle(
                      color: Colors.black,
                      backgroundColor: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/profile.png',

                  ),
                ),
                backgroundColor: Colors.white,
              ),*/
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/NavBar.png'),
                fit: BoxFit.fill,
              ),
              color: Colors.white,
            ),
          ),

          // MY ACCOUNT
          ListTile(
              leading: Icon(Icons.account_circle),
              title: Text(
                'My Account',
                style:
                    TextStyle(fontSize: 17, fontFamily: 'Montserrat Regular'),
              ),
              //onTap: () => isUserDetailCompleted(),
          ),

          //SETTING
          ListTile(
            leading: Icon(Icons.settings),
            title: Text(
              'Settings',
              style: TextStyle(fontSize: 17, fontFamily: 'Montserrat Regular'),
            ),
          ),

          //HELP & SUPPORT
          ListTile(
            leading: Icon(Icons.contact_support),
            title: Text(
              'Help/Support',
              style: TextStyle(fontSize: 17, fontFamily: 'Montserrat Regular'),
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  //builder: (context) => Support(),
                ),
              );
            },
          ),
          //LOGOUT
          ListTile(
            leading: Icon(Icons.logout),
            title: Text(
              'Logout',
              style: TextStyle(fontSize: 17, fontFamily: 'Montserrat Regular'),
            ),
            //onTap: signOut,
          ),
        ],
      ),
    );
  }
  //
  // Future<void> signOut() async {
  //   try {
  //     return await _auth.signOut().then((value) => Navigator.pushReplacement(
  //         context, MaterialPageRoute(builder: (context) => LoginScreen())));
  //   } catch (error) {
  //     print(error.toString());
  //     return null;
  //   }
  // }
}

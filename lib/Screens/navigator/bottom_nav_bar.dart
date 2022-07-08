import 'package:doorstep_guard/Screens/Dashboard/Dashboard.dart';
import 'package:doorstep_guard/Screens/Login/login_screen.dart';
import 'package:doorstep_guard/Screens/MyAccount/My_Account.dart';
import 'package:doorstep_guard/Screens/MyAccountSaved/MyAccountSaved.dart';
import 'package:flutter/material.dart';
import 'package:flashy_tab_bar/flashy_tab_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:progress_dialog/progress_dialog.dart';

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {

  int _selectedIndex = 1;
  List<Widget> _children = [];
  @override
  // list  of  screens of bottom nav bar
  void initState() {
    super.initState();
    _children = [

      Container(
        color: kPrimaryColor,
      ),
      Dashboard(),
      Container(
        color: kPrimaryColor,
      ),


    ];
  }

  // for sign out at option 3 logout
  void _signOut() async {
    await FirebaseAuth.instance.signOut().then((value) =>
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        ),).onError((error, stackTrace) {
          print(error.toString());
    });

  }

  // to check which index is selected
  void onItemTap(int selectedIndex)
  {
    if (_selectedIndex == 2) {
      _signOut();
    }
    else if (_selectedIndex == 0)
      {
        _isUserDetailCompleted();
      }
    else {
      setState(() {
        _selectedIndex = selectedIndex;
      });
    }

  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //check if user has logged in first time or not and act accordingly
  _isUserDetailCompleted(){
    final ProgressDialog pr = ProgressDialog(context);
    pr.style(
      message: 'Please Wait...',
      progressWidget: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFF172953)),
      ),
    );
    pr.show();
    User user=FirebaseAuth.instance.currentUser;
    print(user.uid);
    FirebaseFirestore.instance.collection('User Details').doc(user.uid)
        .get().then((value) {
      pr.hide();
      Map map=value.data();
      var data=map["Email "];
      if(data==""){
        print("user email ${user.email}");
        Navigator.push(context, MaterialPageRoute(builder : (context)=> MyAccount(user.email)),);
      }
      else{
        Navigator.push(context, MaterialPageRoute(builder : (context)=> MyAccountSaved()),);
      }

    }).onError((error, stackTrace) => pr.hide());



  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar : PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: AppBar(
            centerTitle: true,
            title: Text("Guard",style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),),
            backgroundColor: kPrimaryColor,
          ),
        ),

        body: _children[_selectedIndex],

        bottomNavigationBar: FlashyTabBar(
          animationDuration: Duration(milliseconds: 600),
          backgroundColor: kPrimaryColor,
          animationCurve: Curves.linear,
          selectedIndex: _selectedIndex,
          showElevation: true, // use this to remove appBar's elevation
          onItemSelected: (index) => setState(() {
            _selectedIndex = index;
            if (_selectedIndex == 2) {
              _signOut();
            }
            else if (_selectedIndex == 0)
            {
              _isUserDetailCompleted();
            }


          }),
          items: [

            FlashyTabBarItem(
              icon: Icon(Icons.account_circle_rounded),
              title: Text('My Account'),
              activeColor: Colors.white,
              inactiveColor: Colors.white,
            ),
            FlashyTabBarItem(
              icon: Icon(Icons.home),
              title: Text('Dashboard'),
              activeColor: Colors.white,
              inactiveColor: Colors.white,
            ),
            FlashyTabBarItem(
              icon: Icon(Icons.logout),
              title: Text('Logout'),
              activeColor: Colors.white,
              inactiveColor: Colors.white,
            ),

          ],
        ),
      ),
    );
  }
}
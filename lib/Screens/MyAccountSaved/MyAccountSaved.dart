import 'package:doorstep_guard/Screens/EditUserDetails/Edit_User_Details.dart';
import 'package:doorstep_guard/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';


class MyAccountSaved extends StatefulWidget {
  @override
  _MyAccountSavedState createState() => _MyAccountSavedState();
}

class _MyAccountSavedState extends State<MyAccountSaved> {
  CollectionReference users = FirebaseFirestore.instance.collection('User Details');
  User user=FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: AppBar(
          backgroundColor: Color(0xFF172953),
          actions: [
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: FlatButton(
                color: Colors.white,

                onPressed: (){ editPage();},
                child: Text ("Edit",style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),),
                shape:  RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black, width: 1.0),
                    borderRadius: BorderRadius.circular(20.0)),
                  minWidth: size.width*0.18,
              ),
            ),
          ],
        ),
      ),

      body: new Container(
            alignment: Alignment.topCenter,
            color: Colors.white,
            child: new Column(
              children: [
                
                SizedBox(
                  height: size.height * 0.03,
                ),

                   Text(
                      'Details',
                      style: TextStyle(
                        fontFamily: 'Montserrat Medium',
                        fontWeight: FontWeight.bold,
                      ),
                  ),


                SizedBox(
                  height: size.height * 0.015,
                ),
                Image.asset(
                  'assets/images/myAccountSaved.png',
                  height: size.height*0.2,
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                FutureBuilder<DocumentSnapshot>(
                  future: users.doc(user.uid).get(),
                  builder:
                      (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

                    if (snapshot.hasError) {
                      return Text("Something went wrong");
                    }

                    if (snapshot.hasData && !snapshot.data.exists) {
                      return Text("Document does not exist");
                    }

                    if (snapshot.connectionState == ConnectionState.done) {
                      Map<String, dynamic> data = snapshot.data.data() as Map<String, dynamic>;
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 30),
                          child: new Container(
                            height: MediaQuery.of(context).size.height,
                            color: Colors.white,
                            child: Column(
                              children: [

                                fieldForm("Name : ", data["Full Name "] , size),
                                fieldForm("Cnic : ", data["Cnic "], size),
                                fieldForm("Phone : ",data["Phone "], size),
                                fieldForm("Email : ", data["Email "], size),
                                fieldForm("Phase : ", data["Phase "], size),
                                fieldForm("Street : ", data["Street No "], size),
                                fieldForm("House No : ", data["House No "], size),
                                fieldForm("Postal Code : ", data["Postal Code  "], size),
                              ],),
                          ),
                        ),
                      );
                    }

                    return Container(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFF172953)),
                      ),
                    );
                  },
                ),

              ],
            ),
          ),
    );
  }

  Widget fieldForm(String field, String fieldData ,Size size) {
    return new Column(
      children: [
        SizedBox(
          height: size.height *0.02,
        ),

        new Row(
          children: [
            SizedBox(
              width: 45,
            ),
            new Text(
              field,
              style: TextStyle(fontSize: 16, fontFamily: "Montserrat Medium",fontWeight: FontWeight.w700),
            ),
            SizedBox(
              width: 15,
            ),
            new Text(
              fieldData,
              style: TextStyle(fontSize: 16, fontFamily: "Montserrat Medium",fontWeight: FontWeight.w600),
            ),
          ],
        ),

        Divider(
          height: size.height*0.02,
          indent: 35,
          endIndent: 35,
          color: Colors.grey.shade900,
          thickness: 1.5,
        ),

      ],
    );
  }

  editPage()
  {
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
      var data = map['Email '];
      if(data != null)
        {
        Navigator.pushReplacement(context, MaterialPageRoute(builder : (context)=> EditUserDetails(map['Email '], map['Full Name '],  map['Cnic '],  map['Phone '],  map['Phase '],  map['Street No '],  map['House No '],  map['Postal Code  '])
        ),);
        }
        });
        }

}
